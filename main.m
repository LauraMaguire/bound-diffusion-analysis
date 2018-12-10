%% Specify number of experiments to be analyzed
Ntrials = 16;

%% Prepare the data
% Load experiment information
[info, plots] = LoadExperiments(Ntrials);
% Load normalized accumulation and profile data
% The first dimension indexes the experiment number, and the second indexes
% the channel (1 = green NTF2, 2 = red mCherry)
[acc,pro,time,pos] = LoadAccAndProfiles(Ntrials,plots);

%% Load image data
% It takes a long time to run, so it will only run if 'images' doesn't
% already exist in the workspace.
if exist('images','var')
    disp('Images have already been loaded.');
else
    images = LoadImage(Ntrials,info);
end
%% Calculate area and perimeter of each gel
% First run a function that works if the whole gel is in the image
[masks, area, perimeter] = GelMask(Ntrials,images,1.58);
% Second pass: Add a border and estimate shape.
[masks, area, perimeter] = GelMaskWithBorder(Ntrials,images,1.58, masks, area, perimeter);


%% Calculate tauD using perimeter and area data
% tauD is the product of time constant and diffusion constant
tauD = (pi/4)*(area./perimeter).^2;

%% Fit to Mortensen accumulation equation.
% Fit is to c(t) = c0(1-sum_i^inf(xi_i*exp(-Gamma_i*D*t))
% xi_i and Gamma_i are constants
Nterms = 100;
fits = AccFitSetup(time, acc, tauD, Ntrials, Nterms);

%% Fit early-time NTF2 profiles to erfc equation.

% Specify starting index (cut off reservoir portion of profile)
% Set by hand (not best practice), based on max intensity value and
% adjusted if needed
I = [52,205,59,188,251,105,197,2,229,194,202,2,152,3,313,95];
results = ErfcFixedTSetup500(time, pos, pro, tauD, I, Ntrials);

%% Fit erfc parameter results to exponentials
DEffAsymptote = zeros(1,Ntrials);
AmpEffAsymptote = zeros(1,Ntrials);
for n=1:Ntrials%[1 2 3 5 9 10 11]
    if length(results{n}.DEff)>1
    [fitresult,~] = ExpFit500(1:length(results{n}.DEff(2:end)),results{n}.DEff(2:end)/60);
    DEffAsymptote(n) = fitresult.c;
    [fitresult,~] = ExpFit1000(1:length(results{n}.DEff(2:end)),results{n}.AmpEff(2:end));
    AmpEffAsymptote(n) = fitresult.c+fitresult.a;
    else
        DEffAsymptote(n) = NaN;
        AmpEffAsymptote(n) = NaN;
    end
end
clear n fitresult
%% Insert NTF2 results into fits structure
fits.c0(:,1) = AmpEffAsymptote.';
fits.D(:,1) = DEffAsymptote.';
%% Calculate partition coefficients
partCoeffs = FitCalcPartCoeffs(fits, Ntrials);

%% Calculate bound probability pb
bProb = FindBoundProb(partCoeffs, Ntrials);

%% Calculate bound diffusion coefficient
dBound = (fits.D(:,1)-(1-bProb).*fits.D(:,2))./bProb;


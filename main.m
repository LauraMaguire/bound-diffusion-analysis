%% Specify number of experiments to be analyzed
Ntrials = 16;

%% Prepare the data
% Load experiment information
[info, plots] = LoadExperiments(Ntrials);
% Load normalized accumulation and profile data
% The first dimension indexes the experiment number, and the second indexes
% the channel (1 = green NTF2, 2 = red mCherry)
[acc,pro, time] = LoadAccAndProfiles(Ntrials,plots);

%% Load image data
if exist('images','var')
    disp('Images have already been loaded.');
else
    [images] = LoadImage(Ntrials,info);
end
%% Calculate area and perimeter of each gel
% First run a function that works if the whole gel is in the image
[masks, area, perimeter] = GelMask(Ntrials,images,1.58);

%% Calculate time constant using perimeter and area data
tauD = (pi/4)*(area./perimeter).^2;

%% Calculate partition coefficient using exponential fit
partCoeffs = ExpCalcPartCoeffs(time,acc, Ntrials);

%% Fit to Mortensen accumulation equation
fits = AccFitSetup(time, acc, tauD, Ntrials);

%% Estimate tau based on D-values of previous fit
tau = tauD./fits.D;

%% Iterate and fit again, limiting data to t < 0.1*tau (short time)
fits = AccFitSetupRepeat(time, acc, tauD, tau, Ntrials);

%% Calculate partition coefficients and bound probability pb
[partCoeffs, bProb] = FindBoundProb(fits, Ntrials);

%% Calculate bound diffusion coefficient
dBound = (fits.D(:,1)-(1-bProb).*fits.D(:,2))./bProb;


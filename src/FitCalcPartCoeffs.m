function [partCoeffs] = FitCalcPartCoeffs(fits, Ntrials)
partCoeffs = zeros(Ntrials,2); % green goes in first column, red in second

for n=1:Ntrials
    partCoeffs(n,1) = fits.c0(n,1);
    partCoeffs(n,2) = fits.c0(n,2);
end
disp('Finished calculating partition coefficients and bound probability.');
end
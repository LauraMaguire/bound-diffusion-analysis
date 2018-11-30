function [partCoeffs, bProb] = FindBoundProb(fits, Ntrials)
partCoeffs = zeros(Ntrials,2); % green goes in first column, red in second
bProb = zeros(Ntrials,1);

for n=1:Ntrials
    partCoeffs(n,1) = fits.amp(n,1);
    partCoeffs(n,2) = fits.amp(n,2);
    bProb(n) = 1-partCoeffs(n,2)/partCoeffs(n,1); % expression from paper supplement
end
disp('Finished calculating partition coefficients and bound probability.');
end
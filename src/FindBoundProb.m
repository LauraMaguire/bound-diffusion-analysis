function [bProb] = FindBoundProb(partCoeffs, Ntrials)
bProb = zeros(Ntrials,1);

for n=1:Ntrials
    bProb(n) = max(0,1-partCoeffs(n,2)/partCoeffs(n,1)); % expression from paper supplement
end
disp('Finished calculating partition coefficients and bound probability.');
end
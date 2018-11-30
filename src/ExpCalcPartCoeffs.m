function [partCoeffs] = ExpCalcPartCoeffs(time, acc, Ntrials)
    partCoeffs = zeros(Ntrials,2);
    for n=1:Ntrials % loop over all trials
        [fitresult, ~] = ExpFit(time{n},acc{n,1}); % green data first
        partCoeffs(n,1) = fitresult.A+fitresult.C;
        [fitresult, ~] = ExpFit(time{n},acc{n,2}); % red data second
        partCoeffs(n,2) = fitresult.A+fitresult.C;
        disp(['Fit ' num2str(n) ' of ' num2str(Ntrials) '.']);
    end
    disp('Finished fitting accumulation data.');
end
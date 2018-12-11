function [fits] = AccFitSetupTest(time, acc, tauD, Ntrials, Nterms)
    fits.c0 = zeros(Ntrials,2); % amplitude
    fits.D = zeros(Ntrials,2); % lifetime
    fits.y0 = zeros(Ntrials,2); % lifetime
    fits.gof = cell(Ntrials,2); % offset
    for n=1:Ntrials % loop over all trials
        if isnan(tauD(n))
            disp(['Skipping experiment ' num2str(n) ' of ' num2str(Ntrials) '.']);
        else
        [fitresult, gofcur] = accFitFree((time{n}-time{n}(1)),acc{n,1},tauD(n),Nterms); % green data first
        fits.c0(n,1) = fitresult.c0;
        fits.D(n,1) = fitresult.D;
        fits.y0(n,1) = fitresult.y0;
        fits.gof{n,1} = gofcur;
        fits.RMSE(n,1) = gofcur.rmse;
    
        [fitresult, gofcur] = accFitFree((time{n}-time{n}(1)),acc{n,2},tauD(n),Nterms); % red data second
        fits.c0(n,2) = fitresult.c0;
        fits.D(n,2) = fitresult.D;
        fits.y0(n,2) = fitresult.y0;
        fits.gof{n,2} = gofcur;
        fits.RMSE(n,2) = gofcur.rmse;
        disp(['Fit ' num2str(n) ' of ' num2str(Ntrials) '.']);
        end
    end
    disp('Finished fitting accumulation data.');
end
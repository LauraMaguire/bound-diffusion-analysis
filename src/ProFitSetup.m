function [fits] = ProFitSetup(pos, time, pro, timeIndex, tauD, Ntrials, Nterms,halfMaxIndices,lim)
    fits.c0 = zeros(Ntrials,2); % amplitude
    fits.D = zeros(Ntrials,2); % lifetime
    fits.c1 = zeros(Ntrials,2);
    fits.T1 = zeros(Ntrials,2);
    fits.adjrsquare = zeros(Ntrials,2);
    for n=1:Ntrials % loop over all trials
        if isnan(tauD(n))
            disp(['Skipping experiment ' num2str(n) ' of ' num2str(Ntrials) '.']);
        else
            p = pos{n};
        [fitresult, gofcur] = proFit(p,pro{n,1}(timeIndex,:)-pro{n,1}(1,end),time{n}(timeIndex), tauD(n), Nterms, halfMaxIndices{n}(1)); % green data first
        fits.c0(n,1) = fitresult.c0;
        fits.D(n,1) = fitresult.D;
%         fits.c1(n,1) = fitresult.c1;
%         fits.T1(n,1) = fitresult.T1;
        fits.adjrsquare(n,1) = gofcur.adjrsquare;
    
        [fitresult, gofcur] = proFit(p,pro{n,2}(timeIndex,:)-pro{n,2}(1,end),time{n}(timeIndex), tauD(n), Nterms,lim(n,4)); % red data second
        fits.c0(n,2) = fitresult.c0;
        fits.D(n,2) = fitresult.D;
%         fits.c1(n,2) = fitresult.c1;
%         fits.T1(n,2) = fitresult.T1;
        fits.adjrsquare(n,2) = gofcur.adjrsquare;
        disp(['Fit ' num2str(n) ' of ' num2str(Ntrials) '.']);
        end
    end
    disp('Finished fitting accumulation data.');
end
function [fits] = AccFitSetupRepeat(time, acc, tauD, tau, Ntrials)
    fits.amp = zeros(Ntrials,2); % amplitude
    fits.D = zeros(Ntrials,2); % lifetime
    fits.T0 = zeros(Ntrials,2);
    fits.A0 = zeros(Ntrials,2);
    fits.gof = cell(Ntrials,2); % offset
    for n=1:Ntrials % loop over all trials
        if isnan(tauD(n))
            disp(['Skipping experiment ' num2str(n) ' of ' num2str(Ntrials) '.']);
        else
        cutoff = find(time{n}<0.5*tau(n), 1, 'last' );
        [fitresult, gofcur] = accFitShortTime(time{n}(1:cutoff),acc{n,1}(1:cutoff),tauD(n)); % green data first
        fits.amp(n,1) = fitresult.A;
        fits.D(n,1) = fitresult.D;
        fits.T0(n,1) = -fitresult.T0;
        fits.A0(n,1) = fitresult.A0;
        fits.gof{n,1} = gofcur;
    
        [fitresult, gofcur] = accFitShortTime(time{n}(1:cutoff),acc{n,2}(1:cutoff),tauD(n)); % red data second
        fits.amp(n,2) = fitresult.A;
        fits.D(n,2) = fitresult.D;
        fits.T0(n,2) = -fitresult.T0;
        fits.A0(n,2) = fitresult.A0;
        fits.gof{n,2} = gofcur;
        disp(['Fit ' num2str(n) ' of ' num2str(Ntrials) '.']);
        end
    end
    disp('Finished fitting accumulation data.');
end
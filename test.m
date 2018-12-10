[results] = ErfcFixedTSetup(time, pos, pro, tauD, halfMaxIndices, Ntrials,1);

%%
for n=1:12
semilogy(time{n}(2:length(results{n}.yOffsetEff)),results{n}.rmse(2:end));
xlabel('Time (min)');
ylabel('RMSE');
title('RMSE as a function of time, erfc fits full');
hold all
end

%%
for n=1:12
semilogy(time{n}(2:length(results{n}.yOffsetEff)),results{n}.AmpEff(2:end));
xlabel('Time (min)');
ylabel('c0 fit parameter');
title('C0 as a function of time, erfc fits full');
hold all
end

%%
for n=1:12
semilogy(time{n}(2:length(results{n}.yOffsetEff)),results{n}.DEff(2:end));
xlabel('Time (min)');
ylabel('D fit parameter (um^2/s)');
title('D as a function of time, erfc fits full');
hold all
end

%%
for n=1:16
semilogy(time{n}(2:length(results{n}.yOffsetEff)),results{n}.yOffsetEff(2:end));
xlabel('Time (min)');
ylabel('D fit parameter (um^2/s)');
title('D as a function of time, erfc fits full');
hold all
end


%%
DEffAsymptote = zeros(1,Ntrials);
AmpEffAsymptote = zeros(1,Ntrials);
for n=1:Ntrials%[1 2 3 5 9 10 11]
    if length(results{n}.DEff)>1
    [fitresult,gof] = ExpFit500(1:length(results{n}.DEff(2:end)),results{n}.DEff(2:end)/60);
    DEffAsymptote(n) = fitresult.c;
    [fitresult,gof] = ExpFit1000(1:length(results{n}.DEff(2:end)),results{n}.AmpEff(2:end));
    %[fitresult2,gof] = ExpFit1000(1:length(results{n}.DEff(2:end)),results{n}.yOffsetEff(2:end));
    AmpEffAsymptote(n) = fitresult.c+fitresult.a;
    else
        DEffAsymptote(n) = NaN;
        AmpEffAsymptote(n) = NaN;
    end
end
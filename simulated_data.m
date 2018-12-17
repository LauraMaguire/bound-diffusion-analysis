prob = (A_recbind(1:51,2:end)+C_recbind(1:51,2:end))/2e-5;

pron = (A_rec(1:51,2:end)+C_rec(1:51,2:end))/2e-5;

accb = zeros(1,51);
for t=1:100
    accb(t) = sum(sum(prob(:,t)))/51;
end

accn = zeros(1,51);
for t=1:100
    accn(t) = sum(sum(pron(:,t)))/51;
end
clear t

%%
accdye = 0.2*accn(1:4:end);
accdye(length(accdye):100)=accdye(end);
plot(accdye);
%%
acc2 = accb+accdye;

%%
plot(accb/accb(end));
hold all
plot(accn/accn(end));
hold all
plot(acc2/acc2(end));
legend({'Binding', 'No binding', 'Binding with 20% free dye'});
ylabel('Normalized intensity');
xlabel('Time (arb. units)');
title('Simulated 1D accumulation');

%%
plot(accb);
hold all
plot(accn);
hold all
plot(acc2);
legend({'Binding', 'No binding', 'Binding with 20% free dye'});
ylabel('Normalized intensity');
xlabel('Time (arb. units)');
title('Simulated 1D accumulation');

%%
time = 1:100;

%%
c0n = zeros(1,6);
Dn = zeros(1,6);
rmsen = zeros(1,6);
c0b = zeros(1,6);
Db = zeros(1,6);
rmseb = zeros(1,6);
y0n = zeros(1,6);
for n=[1 10 50 100 500 1000]
[fitresult, gof] = accFitFree(time, acc2, 1e5, n);
c0b(n) = fitresult.c0;
Db(n) = fitresult.D;
%y0n(n) = fitresult.y0;
rmseb(n) = gof.rmse;

[fitresult, gof] = accFitFree(time, accn, 1e5, n);
c0n(n) = fitresult.c0;
Dn(n) = fitresult.D;
%y0n(n) = fitresult.y0;
rmsen(n) = gof.rmse;
end

tlist = [1 10 50 100 500 1000];
loglog(tlist, c0b(c0b>0),'o')
hold all
loglog(tlist,c0n(c0n>0),'o')
xlabel('Nterms');
ylabel('Partition coefficient');
legend({'Binding+dye', 'No binding'});
figure
loglog(tlist,Db(Db>0),'o')
hold all
loglog(tlist,Dn(Dn>0),'o')
xlabel('Nterms');
ylabel('Diffusion constant (um^2/s)');
legend({'Binding+dye', 'No binding'});
figure
loglog(tlist,rmseb(rmseb>0),'o')
hold all
loglog(tlist,rmsen(rmsen>0),'o')
xlabel('Nterms');
ylabel('RMSE');
legend({'Binding+dye', 'No binding'});





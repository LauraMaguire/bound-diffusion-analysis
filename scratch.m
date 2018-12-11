for n=1:16
    disp(['Lower estimate of tau ratio for exp. ' num2str(n) ' is ' num2str(tauD1(n)/time{n}(end))]);
    disp(['Upper estimate of tau ratio for exp. ' num2str(n) ' is ' num2str(tauD2(n)/time{n}(end))]);
end

%%
sse = zeros(1,16);
for n=[1 2 3 5 9 10 11]
    sse(n) = gof100{n,2}.sse/gof10{n,2}.sse;
    test(n) = gof100{n,2}.sse;
    test2(n) = gof100{n,1}.sse;
end

%%
semilogy(test,'o');
hold all
semilogy(test2,'o');

%%
toggle = 1;
A = zeros(Ntrials,6);
D = zeros(Ntrials,6);
sse = zeros(Ntrials,6);
y0 = zeros(Ntrials,6);
its = [1 10 50 100 500 1000];
for n=[8 14 17 18 19 20 21 22]
    A(:,1) = fits1.c0(:,toggle);
    D(:,1) = fits1.D(:,toggle);
    err(:,1) = fits1.RMSE(:,toggle);
    y0(:,1) = fits1.y0(:,toggle);
    
    A(:,2) = fits10.c0(:,toggle);
    D(:,2) = fits10.D(:,toggle);
    err(:,2) = fits10.RMSE(:,toggle);
    y0(:,2) = fits10.y0(:,toggle);
    
    A(:,3) = fits50.c0(:,toggle);
    D(:,3) = fits50.D(:,toggle);
    err(:,3) = fits50.RMSE(:,toggle);
    y0(:,3) = fits50.y0(:,toggle);
    
    A(:,4) = fits100.c0(:,toggle);
    D(:,4) = fits100.D(:,toggle);
    err(:,4) = fits100.RMSE(:,toggle);
    y0(:,4) = fits100.y0(:,toggle);
    
    A(:,5) = fits500.c0(:,toggle);
    D(:,5) = fits500.D(:,toggle);
    err(:,5) = fits500.RMSE(:,toggle);
    y0(:,5) = fits500.y0(:,toggle);
    
    A(:,6) = fits1000.c0(:,toggle);
    D(:,6) = fits1000.D(:,toggle);
    err(:,6) = fits1000.RMSE(:,toggle);
    y0(:,6) = fits1000.y0(:,toggle);
end

%% Script that produces accFit result plots
loglog(its, A(:,:),'-o');
title('Equilibrium concentration c0 vs number of terms in fit')
xlabel('Number of terms in series');
ylabel('c0 fit value');
figure
loglog(its, D(:,:),'-o');
title('Diffusion constant D vs number of terms in fit')
xlabel('Number of terms in series');
ylabel('D fit value');
figure
loglog(its, err(:,:),'-o');
title('RMSE vs number of terms in fit')
xlabel('Number of terms in series');
ylabel('RMSE fit value');
figure
loglog(its, abs(y0(:,:)),'-o');
title('y-offset magnitude vs number of terms in fit')
xlabel('Number of terms in series');
ylabel('abs(y0) fit value');

%%
for n=1:16
    goodPoints = find(time{n} < tauD(n)/100);
    if length(goodPoints) > 10
        cutoff(n) = goodPoints(end);
    else
        cutoff(n) = time{n}(end);
    end
end


%%
green = (acc{3,1}-acc{3,1}(1));
green = green./green(end);
red = (acc{2,2}-acc{2,2}(1));
red = red./red(end);
plot(time{3},green)
hold all
plot(time{3},red)
%%
greenc = (acc{14,1}-acc{14,1}(1));
greenc = greenc./greenc(end);
redc = (acc{14,2}-acc{14,2}(1));
redc = redc./redc(end);
plot(greenc)
hold all
plot(redc)

%%
t = 50;
D = 100;
radius = 800;
c0 = 2;

BesZeros = besselzero(0,1000,1);
alpha = BesZeros./radius;
denom = BesZeros.*besselj(1,BesZeros);
TimeConst = BesZeros.^2/radius^2;

x = 1:radius;
y=c0*1;
for n=1:1000
    y=y-c0*2*besselj(0,alpha(n).*x).*exp(-D*TimeConst(n)*t)./denom(n);
end

xx = 1.58*(1:floor(radius/1.58));
yy  = nan(1,floor(radius/1.58));
yy(1:416) = pro{2,1}(t,225:end)-pro{2,1}(1,end);

plot(x,y)
hold all
plot(xx,fliplr(yy));




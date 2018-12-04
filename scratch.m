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
A = zeros(16,6);
D = zeros(16,6);
sse = zeros(16,6);
its = [1 10 50 100 500 1000];
for n=[1 2 3 5 9 10 11]
    A(:,1) = fits1.A(:,toggle);
    D(:,1) = fits1.D(:,toggle);
    err(:,1) = fits1000.RMSE(:,toggle);
    err(:,1) = fits1.RMSE(:,toggle);
    
    A(:,2) = fits10.A(:,toggle);
    D(:,2) = fits10.D(:,toggle);
    err(:,2) = fits10.RMSE(:,toggle);
    
    A(:,3) = fits50.A(:,toggle);
    D(:,3) = fits50.D(:,toggle);
    err(:,3) = fits50.RMSE(:,toggle);
    
    A(:,4) = fits100.A(:,toggle);
    D(:,4) = fits100.D(:,toggle);
    err(:,4) = fits100.RMSE(:,toggle);
    
    A(:,5) = fits500.A(:,toggle);
    D(:,5) = fits500.D(:,toggle);
    err(:,5) = fits500.RMSE(:,toggle);
    
    A(:,6) = fits1000.A(:,toggle);
    D(:,6) = fits1000.D(:,toggle);
    err(:,6) = fits1000.RMSE(:,toggle);
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

%%
for n=1:16
    goodPoints = find(time{n} < tauD(n)/100);
    if length(goodPoints) > 10
        cutoff(n) = goodPoints(end);
    else
        cutoff(n) = time{n}(end);
    end
end





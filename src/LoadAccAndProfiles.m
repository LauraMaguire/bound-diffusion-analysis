function [acc, pro, time] = LoadAccAndProfiles(Ntrials,plots)
    acc = cell(Ntrials,2);
    pro = cell(Ntrials,2);

    time = cell(1,Ntrials); % set up storage for time axes
    pos = cell(1, Ntrials); % set up storage for position axes

    for n=1:Ntrials % loop over all trials
    
        time{n} = 60*plots{n}.timeAx; % convert time axis to seconds and save
        pos{n} = plots{n}.posAx;
    
        currentGrnAcc = plots{n}.accumulation(1,:); % name some things for clarity
        currentRedAcc = plots{n}.accumulation(2,:);
        currentGrnRes = plots{n}.reservoir(1,:);
        currentRedRes = plots{n}.reservoir(2,:);
    
        pro{n,1} = zeros(length(time{n}),length(pos{n}));
        pro{n,2} = zeros(length(time{n}),length(pos{n}));
        for t = 1:length(time{n})
            pro{n,1}(t,:) = plots{n}.grnProfile(t,:)./plots{n}.reservoir(1,t);
            pro{n,2}(t,:) = plots{n}.redProfile(t,:)./plots{n}.reservoir(2,t);
        end
    
        acc{n,1} = currentGrnAcc./currentGrnRes; % save the normalized accumulation
        acc{n,2} = currentRedAcc./currentRedRes;
    end
    disp('Finished storing profiles and normalized accumulation.');
end
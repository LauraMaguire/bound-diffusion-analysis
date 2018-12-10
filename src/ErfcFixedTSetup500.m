function [results] = ErfcFixedTSetup500(time, pos, pro, tauD, I, Ntrials)
    for n=2:Ntrials
        tskip = 30:10:floor(length(time{n}/10));
        results{n}.DEff = [];
        results{n}.AmpEff = [];
        results{n}.yOffsetEff = [];
        %results{n}.xOffsetEff = [];
        results{n}.rmse = [];
        
%         tskip = 30:10:floor(length(time{n}/10));
        
        if isnan(tauD(n))
            tskip = 1;
        else
            tskip = find((time{n})<(tauD(n)/100));
            if length(tskip)>50
                tskip = tskip(1:50);
            elseif isempty(tskip)
                tskip = 1;
                
            end
            disp(length(tskip));
            disp(tskip);
        end
        
        for tt=tskip
            disp(tt);
            %[~,I(n)] = max(pro{n,1}(tt,:));
            %I = halfMaxIndices{n,1}(tt);
            %x = pos{n}(I:end);
            x = 1.58*(1:length(pro{n,1}(tt,I(n):end)));
            y = (pro{n,1}(tt,I(n):end)-pro{n,1}(1,end));%./pro{1,n}(1,lim();
            if tt==tskip(1)
                [r,gof] = erfcFit500(x,y,tt,0);
                %x0 = r.x0;
                %x0=0;
            else
                [r,gof] = erfcFit500(x,y,tt,0); %no number
            end
            results{n}.DEff = [results{n}.DEff r.D];
            results{n}.AmpEff = [results{n}.AmpEff r.C0];
            results{n}.yOffsetEff = [results{n}.yOffsetEff r.c1];
            %results{n}.xOffsetEff = [results{n}.xOffsetEff x0];
            results{n}.rmse = [results{n}.rmse gof.rmse];
        end
        
        %close all

    end

end
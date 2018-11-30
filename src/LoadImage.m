function [images] = LoadImage(Ntrials, info)
    images=cell(Ntrials,1);
    imlimits =cell(Ntrials,1);
    for n=1:Ntrials
        disp(['Loading ' num2str(n) ' of ' num2str(Ntrials) ' experiments.']);
        data = bfopen([info{n}.expFolderMac '/' info{n}.expName]);
        images{n} = im2double(data{1,1}{2,1});
    end
end
%% Prepare the data
% Load experiment information
[info, plots] = LoadExperiments(16);
% Load normalized accumulation and profile data
% The first dimension indexes the experiment number, and the second indexes
% the channel (1 = green NTF2, 2 = red mCherry)
[acc,pro] = LoadAccAndProfiles(16,plots);

%%
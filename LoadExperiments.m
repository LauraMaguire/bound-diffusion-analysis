function [info, plots] = LoadExperiments(Ntrials)

info = cell(Ntrials,1); % create storage location for experiment information
plots = cell(Ntrials,1); % create storage location for experiment results
trialList = dir; % make a list of all files in current folder
for n=1:Ntrials % loop over all trials
    cd('Data'); % navigate to folder for a specific trial
    disp(['Opening trial ' trialList(n+3).name ' of ' num2str(Ntrials) '.']);
    infoStructure = load('info.mat'); % import the info
    info{n} = infoStructure.info;
    plotsStructure = load('plots.mat'); % import the plot data
    plots{n} = plotsStructure.plots;
    cd('..'); % go back up to the original directory
end
cd('..');
end
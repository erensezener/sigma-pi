%% Workspace and path setup
clear;
% poolobj = parpool;


filename_to_save = 'search_for_3Q_ags.mat';

addpath(genpath('../heuristic-share/Data'));

load('4D/All4DClean.mat');

%% Config

options.StallGenLimit = 100;
options.UseParallel = false;
options.Generations = 2*10^2;
options.Display = 'off';


%% Parameters
tic
n = 4;
l = 2^n;
number_of_ys = 2^(2^n);

%% Preprocess data
ys = zeros(number_of_ys/2,l);

for i = 1:number_of_ys/2
    ys(i,:) = yCell{i,1};
end

%% Do the computation

results = zeros(number_of_ys/2,1);
times = zeros(number_of_ys/2,1);

parfor i = 1:12
% parfor i = 1:size(results,1)
    y = yCell{i,1};
    t = cputime;
    results(i,:) = l - solve_via_3Q_GA(y', options);
    times(i,:) = cputime - t; t = cputime;
end

%% Save the data
save(filename_to_save);
toc

% delete(poolobj);
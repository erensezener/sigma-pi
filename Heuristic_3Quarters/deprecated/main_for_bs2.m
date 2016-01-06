%% Workspace and path setup
clear;
parobj = parpool;
filename_to_save = 'search_for_bs_stallgen3.mat';

addpath(genpath('../heuristic-share/Data'));

load('4D/All4DClean.mat');

%% Config

options.StallGenLimit = 3;
options.UseParallel = false;
options.Generations = 30;
options.Display = 'off';
options.PopulationType = 'bitString';



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

% for i = 1:16
parfor i = 1:size(results,1)
    y = yCell{i,1};
    t = cputime;
    results(i,:) = solve_via_GA_for_bs(y', options);
    times(i,:) = cputime - t; t = cputime;
end

%% Save the data
save(filename_to_save);
toc

delete(parobj);

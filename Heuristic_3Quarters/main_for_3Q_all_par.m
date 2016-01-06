%% Workspace and path setup
clear;
poolobj = parpool;


filename_to_save = 'search_for_3Q_all_par_1p7.mat';

addpath(genpath('../heuristic-share/Data'));

load('4D/All4DClean.mat');

%% Config

options.UseParallel = false;
options.Generations = 2*10^2;
options.Display = 'off';
stall_gens = ceil(logspace(0,1.7,10));


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

results = zeros(number_of_ys/2,length(stall_gens));
times = zeros(number_of_ys/2,length(stall_gens));

% parfor i = 1:4
parfor i = 1:size(results,1)
    y = yCell{i,1};
    time_diffs = ones(1,length(stall_gens));
    temp_results = ones(1,length(stall_gens));
    for j = 1:length(stall_gens)
        t = cputime;
        temp_results(j) = l - solve_via_3Q_GA_all(y', options, stall_gens(j));
        time_diffs(j) = cputime - t;
        t = cputime;
    end
    times(i,:) = time_diffs;
    results(i,:) = temp_results;
end

%% Save the data
save(filename_to_save);
toc

delete(poolobj);
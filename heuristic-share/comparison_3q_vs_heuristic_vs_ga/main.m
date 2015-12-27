%% Workspace and path setup
parpool;
clear;
filename_to_save = 'comparison_new.mat';
addpath(genpath('../3-Q'));
addpath(genpath('../Data'));
addpath(genpath('../heuristic_binary_search'));

load('../Data/4D/All4DClean.mat');

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

results = zeros(number_of_ys/2,4); % [3Q, Heuristic, BS_Heuristic, GA];
times = zeros(number_of_ys/2,4); % [3Q, Heuristic, BS_Heuristic, GA];

% parfor i = 1:10
parfor i = 1:size(results,1)
    y = yCell{i,1};
    
    result = zeros(1,4);
    time = zeros(1,4);
    t = cputime;
    result(1) = solve_3Q(y);
    time(1) = cputime - t; t = cputime;
    result(2) = linear_heuristic(y);
    time(2) = cputime - t; t = cputime;
    result(3) = bs_heuristic(y);
    time(3) = cputime - t; t = cputime;
    result(4) = simple_ga_sorted(y);
    time(4) = cputime - t; t = cputime;
    results(i,:) = result;
    times(i,:) = time;
end

%% Save the data
save(filename_to_save);
toc

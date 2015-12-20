%% Workspace and path setup
parpool;
clear;
filename_to_save = 'comparison_temp.mat';
addpath(genpath('../3-Q'));
addpath(genpath('../Data'));
addpath(genpath('../heuristic_binary_search'));

load('../Data/4D/All4DClean.mat');

%% Parameters
tic
number_of_ys = 16;
n = size(Solutions,1);


%% Preprocess data
ys = zeros(number_of_ys/2,2^n);

for i = 1:number_of_ys/2
    ys(i,:) = yCell{i,1};
end

%% Do the computation

results = zeros(number_of_ys/2,4); % [3Q, Heuristic, BS_Heuristic, GA];
times = zeros(number_of_ys/2,4); % [3Q, Heuristic, BS_Heuristic, GA];

for i = 1:size(results,1)
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
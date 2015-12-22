%% Workspace and path setup
parpool;
clear;
filename_to_save = 'all_4D_with_GA.mat';
addpath(genpath('../heuristic-share/Data'));

load('4D/All4DClean.mat');

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

% parfor i = 1:8
parfor i = 1:size(results,1)
    y = yCell{i,1};
    t = cputime;
    results(i,:) = l - solve_via_GA(y');
    times(i,:) = cputime - t; t = cputime;
end

%% Save the data
save(filename_to_save);
toc
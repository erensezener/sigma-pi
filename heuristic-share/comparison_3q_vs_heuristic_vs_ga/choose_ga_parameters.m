%% Workspace and path setup
% poolobj = parpool;
clear;

filename_to_save = 'ga_parameter_search.mat';

addpath(genpath('../heuristic-share/Data'));

load('../Data/4D/All4DClean.mat');


%% Parameters
tic

sel = [0.8:-0.1:0.5];
mutrate = logspace(-3, -1, 10);
last = 100;
sample_size = 1000;

n = 4;
l = 2^n;
number_of_ys = 2^(2^n);

%% Preprocess data
ys = zeros(number_of_ys/2,l);

for i = 1:number_of_ys/2
    ys(i,:) = yCell{i,1};
end

%% Do the computation

results = zeros(sample_size, length(sel),length(mutrate));
times = zeros(sample_size, length(sel),length(mutrate));

indices = randi(number_of_ys/2, sample_size, 1);

%parfor i = 1:12
for i = indices
    for sel_i = 1:length(sel)
        for mutrate_i = 1:length(mutrate)
            sel_val = sel(sel_i);
            mutrate_val = mutrate(mutrate_i);
            y = yCell{i,1};
            t = cputime;
            results(i, sel_i,mutrate_i) = simple_ga_parameterized(y', last, sel_val, mutrate_val);
            times(i, sel_i,mutrate_i) = cputime - t; t = cputime;
        end
    end
end

projected_results = sum(results,1);
projected_times = sum(times,1);

%% Save the data
save(filename_to_save);
toc

delete(poolobj);
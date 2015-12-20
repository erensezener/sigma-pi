%% Workspace and path setup
parpool;
clear;
filename_to_save = 'comparison_temp.mat';
% addpath(genpath('../heuristic-share/Data/6D'));
load('../heuristic-share/Data/6D/4BentFunctions.mat');


%% Run parameters
number_of_monomials_to_eliminate = 64 - 26;
y_to_solve = y;
number_of_iters = 10^2;

number_of_successes = bf_search_nchoosek_par(y_to_solve,number_of_monomials_to_eliminate,number_of_iters);

save(filename_to_save)
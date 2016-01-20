clear;
poolobj = parpool;

filename_to_save = '6d_bent1_6_4.mat';
addpath(genpath('../heuristic-share/Data/6D'));
load('4BentFunctions.mat');



options.UseParallel = true;
options.Generations = 10^6;
stall_gen = 10^4;
options.Display = 'off';
% options.PopulationSize = 10;

tic;
[ best_score, x,fval,exitflag, output, population, scores ] = solve_via_3Q_GA_all(y', options, stall_gen);
best_score = 64 - best_score;
toc

save(filename_to_save);
delete(poolobj);
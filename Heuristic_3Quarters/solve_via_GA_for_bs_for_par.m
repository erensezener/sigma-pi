function [ best_score, x,fval,exitflag, output, population, scores ] = solve_via_GA_for_bs_for_par(y, options, stall_gen)
%SOLVE_VIA_GA_3QUARTERS Summary of this function goes here
%   Detailed explanation goes here

options.StallGenLimit = stall_gen;


search_wrapper = @(genotype) binary_cost_function(y , genotype);


[x,fval,exitflag, output, population, scores] = ga(search_wrapper,length(y),[],[],[],[],[], [], [], [], options);

best_score = min(scores);

end

function [ best_score, x,fval,exitflag, output, population, scores ] = solve_via_GA_for_bs(y, options)
%SOLVE_VIA_GA_3QUARTERS Summary of this function goes here
%   Detailed explanation goes here

search_wrapper = @(genotype) binary_cost_function(y , genotype);

[x,fval,exitflag, output, population, scores] = ga(search_wrapper,length(y),[],[],[],[],[], [], [], [], options);
% [x,fval,exitflag, output, population, scores] = ga(search_wrapper,length(y),[],[],[],[],lb, [], [], [], options);

best_score = min(scores);

end

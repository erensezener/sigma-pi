function [ best_score, x,fval,exitflag, output, population, scores ] = solve_via_GA_for_ks_for_par(y, options, stall_gen)
%SOLVE_VIA_GA_3QUARTERS Summary of this function goes here
%   Detailed explanation goes here

options.StallGenLimit = stall_gen;


search_wrapper = @(genotype) attempt_for_ks(y , genotype);

integer_indices = 1:length(y);
lb = ones(1, length(y));
up = 4 * ones(1, length(y)); %sort of arbitrary. can be experimented with.


[x,fval,exitflag, output, population, scores] = ga(search_wrapper,length(y),[],[],[],[],lb, up, [], integer_indices, options);
% [x,fval,exitflag, output, population, scores] = ga(search_wrapper,length(y),[],[],[],[],lb, [], [], [], options);

best_score = min(scores);

end

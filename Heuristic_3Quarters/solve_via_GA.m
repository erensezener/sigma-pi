function [ x,fval,exitflag, output, population, scores ] = solve_via_GA(y)
%SOLVE_VIA_GA_3QUARTERS Summary of this function goes here
%   Detailed explanation goes here

[~, F,G, ~] = makeFG(recmonsetup(log2(length(y))),y);
% search_wrapper = @(F,G,y,genotype) (@(genotype) attempt_for_alphas_betas(F,G, y , genotype));
search_wrapper = @(genotype) -1 * attempt_for_alphas_betas(F,G, y , genotype);

integer_indices = 1:length(y);
lb = ones(1, length(y));
up = ones(1, length(y)) * length(y)*4; %sort of random. can be experimented with

options.StallGenLimit = 10^4;
options.UseParallel = true;
options.Generations = length(y) * 10^4;

[x,fval,exitflag, output, population, scores] = ga(search_wrapper,length(y),[],[],[],[],lb, up, [], integer_indices, options);

end


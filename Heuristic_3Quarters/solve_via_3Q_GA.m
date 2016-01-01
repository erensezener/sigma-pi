function [ best_score, x,fval,exitflag, output, population, scores ] = solve_via_3Q_GA(y, options, stall_gen)
%SOLVE_VIA_GA_3QUARTERS Summary of this function goes here
%   Detailed explanation goes here

options.StallGenLimit = stall_gen;


[~, F,G, ~] = makeFG(recmonsetup(log2(length(y))),y);

[no_rows_F, ~] = size(F);
[no_rows_G ~] = size(G);
genotype_length = 2 * min(no_rows_F, no_rows_G);

if genotype_length == 0 
    best_score = attempt_for_3Q_alphas_betas(F,G, y , []);
    x = [];
    fval= [];
    exitflag= [];
    output= [];
    population= [];
    scores= [];
    return;
end

search_wrapper = @(genotype) -1 * attempt_for_3Q_alphas_betas(F,G, y , genotype);

integer_indices = 1:genotype_length;
lb = ones(1, genotype_length);
up = ones(1, genotype_length) * 3; %sort of arbitrary. can be experimented with.


[x,fval,exitflag, output, population, scores] = ga(search_wrapper,genotype_length,[],[],[],[],lb, up, [], integer_indices, options);
best_score = min(scores) * (-1);

end

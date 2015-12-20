function [ output_args ] = solve_via_GA_3Quarters(y)
%SOLVE_VIA_GA_3QUARTERS Summary of this function goes here
%   Detailed explanation goes here

[~, F,G, ~] = makeFG(recmonsetup(log2(length(y))),y);

genRandSol2(F,G, y, MAXIT, INT_BOUND);  

end


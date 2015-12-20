function [ number_of_coefficients, coef ] = solve_3Q( y )
%3Q_SOLVER Summary of this function goes here
%   Detailed explanation goes here

n=log2(length(y));
Q = monsetup(n);

[~,~,coef] = Ayir(Q,y);
% This is the 3-quarters thm solution (it must have at least 2^n/4 zeros)
number_of_coefficients = nnz(coef);

end
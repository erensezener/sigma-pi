function [ number_of_mons ] = attempt_for_ks( y, k )
%ATTEMPT_FOR_KS Summary of this function goes here
%   Detailed explanation goes here

% make y's and k's column vectors
if size(y,1) == 1
    y = y';
end
if size(k,1) == 1
    k = k';
end

k = 2*k-1;

Q = diag(y) * recmonsetup(log2(size(y,1)));

number_of_mons = nnz(k' * Q);

end


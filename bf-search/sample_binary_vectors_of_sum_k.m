function [ vector ] = sample_binary_vectors_of_sum_k( length, k )
%SAMPLE_BINARY_VECTORS_OF_SUM_K Creates logical vectors s.t. sum(V) = k
%   length is the length of the vector
%   k is the number of 1's in the vector

indices = randperm(length, k);
vector = false(length, 1);
vector(indices) = true;

end
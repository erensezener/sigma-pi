 % create a problem in dim=4
 y = ix2prob(31,16); 
 [sol, F,G] = makeFG(recmonsetup(log2(length(y))),y);
%  OUTPUT:
%  F =
% 
%     -1     1    -1     1     1    -1     1    -1
%     -1    -1     1     1     1     1    -1    -1
%     -1     1     1    -1     1    -1    -1     1
% 
% 
% G =
% 
%      1     1     1     1     1     1     1     1
%      1    -1     1    -1     1    -1     1    -1
%      1     1    -1    -1     1     1    -1    -1
%      1    -1    -1     1     1    -1    -1     1
%      1     1     1     1    -1    -1    -1    -1
     
%  So we will utilize G to zero first half of the monomial vector (i.e that corresponds to the F part.)
%  In the original code these were selected as vectors of all one. But this is infact arbitrary, any positive value
%  a>0, aa>0 would do. By fixing a, aa we can choose g, gg to create zeros, which effects both first and second half of
%  the solution See Eq. 5.12. Also in the selection of g and gg's we have freedom. Which is utilized genRandSol2 but not in genRandSol
 
% genSol is used to manually experiment a, aa, g and gg for firs freedom given in the 3-quarters thm.
% It is basically defunct.
 genSol(F,G, y, [1 1 1], [1 1 1], [1 1 1 1 1]*0, [1 1 1 1 1]*0)
 
 
 % ----------------------------
 % 5 dim example
 % Create the problem (y), and obtain F and G:
 y = ix2prob(127,32); [basesol, F,G] = makeFG(recmonsetup(log2(length(y))),y);
 
 % Rand search with the first freedom can be done with 
 % genRandSol(F,G, y);
 
 % Rand search with both freedoms can be done with 50000 is MAXIT, 5 is the
 % maximum integer to be used for random search
 
 genRandSol2(F,G, y, 50000,5);
 
 
 
 
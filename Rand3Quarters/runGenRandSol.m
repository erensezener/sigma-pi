% Erhan Oztop December 14, 2015
% This script shows how to use  genRandSol.m

INTERACTIVE = 0;

if (INTERACTIVE==1),
    dim    = input('Problem dim:');
    prno   = input('Problem no:');
    MAXIT  = input('Max iteration:');
    INT_BOUND = input('Integer bound (3 seems enough for 5-dim problems):');
else
    MAXIT = 50000;
    INT_BOUND = 3;
    dim = 5;
    prno = hex2dec('dcfdda51');
end;

fprintf('Trying for problem %d (dim = %d) with random integer bound = %d MAXIT:%d\n',prno, dim,INT_BOUND, MAXIT);  

y = ix2prob(prno,2^dim); 
%threeQsol, F,G, threeQnumzeros] = makeFG(recmonsetup(log2(length(y))),y);

% genRandSol2(F,G, y, MAXIT, INT_BOUND);  
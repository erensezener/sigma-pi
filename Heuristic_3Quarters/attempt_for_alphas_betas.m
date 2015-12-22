function numzero=attempt_for_alphas_betas(F,G, y , genotype)
% Finds a solution for a randomly generated a, aa, g, gg 
% genotype is a column vector

if size(genotype,1) == 1
    genotype = genotype';
end

[no_rows_F, Fn_1] = size(F);
[no_rows_G Gn_1] = size(G);
a = genotype(1:no_rows_F)';
aa = genotype(no_rows_F+1:2*no_rows_F)';
g = genotype(end - 2*no_rows_G+1:end - no_rows_G)';
gg = genotype(end - no_rows_G+1:end)';
if size(a,1) ~= size(aa,1) || size(g,1) ~= size(gg,1) || size(a,1) ~= size(g,1)
    error('Fucked up')
end

if size(y,2)==1,   y=y'; end;   % make a row vector

% if (Fn_1 ~= Gn_1)
%     fprintf('ERROR: Bad input matrices. Number of columns must be the same.\n');
%     fprintf('ERROR: Use the output of Ayir as input to this function\n');
%     return;
% end;


n_1 = Gn_1 ;  % this is equal to the 2^(dim-1) where dim is the original problem dimension
N = 2*n_1;    % N = 2^dim
% ##################################################################
% HERE WE CHECK if F or G is empty, if so we return an easy answer with
% half the monomials zeroed. Instead recursively Ayir can be applied to the
% induced lower dimensinal problem and a better result of .75*2^n number of zeros can be obt
D = recmonsetup(log2(length(y)));
if (isempty(G)),
    x=(a+aa)*F ;
    t=(-a+aa)*F ;
    sol=[x,t]';
    check_positive=D*sol.*y';
    if (length(y)==sum(check_positive>0)),
    else
        disp('!!!!!!!!! END OF THE WORLD 1 !!!!!!!!!!');
    end;
    numzero = sum(sol == 0);
    return;
end;

if (isempty(F)),
    x=(-g+gg)*G ;
    t=(g+gg)*G ;
    sol=[x,t]';
    check_positive=D*sol.*y';
    if (length(y)==sum(check_positive>0)),
    else
        disp('!!!!!!!!! END OF THE WORLD 2!!!!!!!!!!');
    end;
    numzero = sum(sol == 0);
    return;
end;
% ##################################################################


x=(a+aa)*F+(-g+gg)*G ; % note that xpart=(a+aa)*F
t=(-a+aa)*F+(g+gg)*G ;
sol=[x,t]';

% do the final check
D = recmonsetup(log2(N));
check_positive=D*sol.*y';
if (N==sum(check_positive>0)),
    numzero = sum(sol == 0);
else
    numzero = 0;
end;
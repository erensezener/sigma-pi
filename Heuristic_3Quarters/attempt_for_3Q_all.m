function numzero=attempt_for_3Q_all(F,G, y , genotype)
% Finds a solution for a randomly generated a, aa, g, gg
% genotype is a column vector

if size(genotype,1) == 1
    genotype = genotype';
end

%to make things odd only
genotype = 2*genotype - ones(size(genotype));

[no_rows_F, Fn_1] = size(F);
[no_rows_G, Gn_1] = size(G);

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
    a = ones(1,no_rows_F);
    aa = ones(1,no_rows_F);
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
    g = ones(1,no_rows_G);
    gg = ones(1,no_rows_G);
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


if no_rows_G>=no_rows_F,
    a = genotype(1:no_rows_F)';
    aa = genotype(no_rows_F+1:2*no_rows_F)';
    r = genotype(2*no_rows_F + 1:end)';
    
    xpart=(a+aa)*F;
    
    [Ered,~,lead,~]=echelon(G,[]);
    v=-xpart(lead)*Ered;  %
    beta=v*G'/(N/2);
    g=zeros(1,no_rows_G);
    gg=zeros(1,no_rows_G);
    %%
    
    negix = find(beta<=0);
    posix = find(beta>0);
    
    g((beta<=0))=-beta(beta<=0)+r(negix);
    gg((beta<=0))= r(negix);
    
    g((beta>0))=r(posix);
    gg((beta>0))=beta(beta>0)+ r(posix);
    
    
    %%
    %check_is_zero=(-g+gg)-beta
    x=(a+aa)*F+(-g+gg)*G ; % note that xpart=(a+aa)*F
    t=(-a+aa)*F+(g+gg)*G ;
    sol=[x,t]';
else
    g = genotype(1:no_rows_G)';
    gg = genotype(no_rows_G+1:2*no_rows_G)';
    r = genotype(2*no_rows_G+1:end)';
    
    tpart=(g+gg)*G;
    [Dred,~,lead,~]=echelon(F,[]);
    v=-tpart(lead)*Dred;  %
    beta=v*F'/(N/2);
    a=zeros(1,no_rows_F);
    aa=zeros(1,no_rows_F);
    
    negix = find(beta<=0);
    posix = find(beta>0);
    neglen = length(negix);
    poslen = length(posix);
    
    a(negix)=-beta(negix) + r(negix);
    aa((beta<=0))= r(negix);
    
    a(posix)=r(posix);
    aa(posix)=beta(posix)+r(posix);
    
    %%
    %check_is_zero=(-a+aa)-beta
    x=(a+aa)*F+(-g+gg)*G ;
    t=(-a+aa)*F+(g+gg)*G ;%  note that tpart=(g+gg)*G
    sol=[x,t]';
    
end

% do the final check
D = recmonsetup(log2(N));
check_positive=D*sol.*y';
if (N==sum(check_positive>0)),
    numzero = sum(sol == 0);
else
    numzero = 0;
end;
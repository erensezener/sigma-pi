function sol=genSol(F,G, y, a, aa, g, gg)
% Erhan Oztop, Dec 12, 2015
% This script is mostly defunct and was used to manually experiment the first freedom given in 3-quarters.
% Instead use genRanSol2.m which does search on both [a, aa] and [g,gg]
% freedoms.
%
% IF    norows_G >= norows_F then a, aa can be set to arbitrary positive
% values. The length of a and aa must be norows_F
% ELSE then b, bb can be set to arbitrary positive
% values. The length of b and bb must be norows_G
    
sol = [];
[norows_F, Fn_1] = size(F);
[norows_G, Gn_1] = size(G);

if size(y,2)==1,   y=y'; end;   % make a row vector

if (Fn_1 ~= Gn_1)
	fprintf('ERROR: Bad input matrices. Number of columns must be the same.\n');
    fprintf('ERROR: Use the output of Ayir as input to this function\n');
    return;
end;

% a, aa, b, bb must be row vectors, if not fix it
if size(a,1) ~= 1,   a =  a'; end;
if size(aa,1)~= 1,  aa = aa'; end;
if size(g,1) ~= 1,   g =  g'; end;
if size(gg,1)~= 1,  gg = gg'; end;
	
% Check if we have consistent a,aa or b,bb vectors
if (norows_G >= norows_F),
    if (length(a)~= norows_F) ||  (length(aa)~= norows_F)
        fprintf('ERROR: a and/or aa vectors must have the same number of elements as the number of rows in F\n');
        return;
    end
else
    if (length(g)~= norows_G) ||  (length(gg)~= norows_G)
        fprintf('ERROR: g and/or gg vectors must have the same number of elements as the number of rows in G\n');
        return;
    end;
end;


n_1 = Gn_1 ;  % this is equal to the 2^(dim-1) where dim is the original problem dimension
N = 2*n_1;    % N = 2^dim
% ##################################################################
% HERE WE CHECK if F or G is empty, if so we return an easy answer with
% half the monomials zeroed. Instead recursively Ayir can be applied to the
% induced lower dimensinal problem and a better result of .75*2^n number of zeros can be obt
if (isempty(G)),
    x=(a+aa)*F ;
	t=(-a+aa)*F ;
	sol=[x,t]';
    check_positive=D*sol.*y';
if (N==sum(check_positive>0)),
else
    disp('!!!!!!!!! END OF THE WORLD 1 !!!!!!!!!!');
    sol=[];
end;
return;
end;

if (isempty(F)),
    x=(-g+gg)*G ; 
	t=(g+gg)*G ;
	sol=[x,t]';
    check_positive=D*sol.*y';
if (N==sum(check_positive>0)),
else
    disp('!!!!!!!!! END OF THE WORLD 2!!!!!!!!!!');
    sol=[];
end;
return;
end;
% ##################################################################


if norows_G>=norows_F,
	fprintf(' G>F (bottom) is bigger \n');
	%% a=ones(1,norows_F);
	%% aa=ones(1,norows_F);
	xpart=(a+aa)*F;
    fprintf('xpart (f) ');
    xpart
	[Ered,bignore,lead,I]=echelon(G,[]);
     fprintf('Echelon of G) ');
    Ered
    v=-xpart(lead)*Ered;  %
     fprintf('Echelon of G) ');
    v
	%beta=-xh(lead)*I;  % this is equivalent
    beta=v*G'/(N/2);
    beta
	g=zeros(1,norows_G);
	gg=zeros(1,norows_G);
	g((beta<=0))=-beta(beta<=0)+1;
	gg((beta<=0))=1;
	
	g((beta>0))=1;
	gg((beta>0))=beta(beta>0)+1;
	
    fprintf('gammas are found:');
    g
    gg
    
	%check_is_zero=(-g+gg)-beta
	x=(a+aa)*F+(-g+gg)*G ; % note that xpart=(a+aa)*F
	t=(-a+aa)*F+(g+gg)*G ;
	sol=[x,t]';
    sol' 
    z=[sum(F,1)+v, (g+gg)*G]
else
     % fprintf('F (upper) is bigger  or equal\n');
%     g=ones(1,norows_G);
%	 gg=ones(1,norows_G);
	tpart=(g+gg)*G;
    %tic;
	[Dred,bignore,lead,I]=echelon(F,[]);
    %toc;
    v=-tpart(lead)*Dred;  % 
	%beta=-tpart(lead)*I; % this is equivalent
    beta=v*F'/(N/2);
	a=zeros(1,norows_F);
	aa=zeros(1,norows_F);
	a((beta<=0))=-beta(beta<=0)+1;
	aa((beta<=0))=1;
	
	a((beta>0))=1;
	aa((beta>0))=beta(beta>0)+1;
	
	%check_is_zero=(-a+aa)-beta
	x=(a+aa)*F+(-g+gg)*G ; 
	t=(-a+aa)*F+(g+gg)*G ;%  note that tpart=(g+gg)*G
	sol=[x,t]';
    
end;


D = recmonsetup(log2(N));
check_positive=D*sol.*y';
if (N==sum(check_positive>0)),
    %disp('OK! , Solution coefficients:');
    %sol'
else
    disp('!!!!!!!!! END OF THE WORLD 3 !!!!!!!!!!');
    sol=[];
end;
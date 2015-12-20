function sol=genRandSol(F,G, y)
% Erhan Oztop, Dec 12, 2015
% genRandSol2 must be used instead of this function.
% This tries to make a random search to improve the number of zeros found
% by 3-quarters. This version only utilizes the first freedom given in the
% proof od 3-quarters. 
    
sol = [];
[norows_F, Fn_1] = size(F);
[norows_G, Gn_1] = size(G);

if size(y,2)==1,   y=y'; end;   % make a row vector

if (Fn_1 ~= Gn_1)
	fprintf('ERROR: Bad input matrices. Number of columns must be the same.\n');
    fprintf('ERROR: Use the output of Ayir as input to this function\n');
    return;
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
MAXIT = 10000;
MAXV  = 5;
maxnumzero  = 0;
for it = 1:MAXIT
    if norows_G>=norows_F,     
        a = floor(rand(1,norows_F)*MAXV)+1;
        aa = floor(rand(1,norows_F)*MAXV)+1;
        xpart=(a+aa)*F;
        
        [Ered,bignore,lead,I]=echelon(G,[]);
        v=-xpart(lead)*Ered;  %
        %beta=-xh(lead)*I;  % this is equivalent
        beta=v*G'/(N/2);
        g=zeros(1,norows_G);
        gg=zeros(1,norows_G);
        g((beta<=0))=-beta(beta<=0)+1;
        gg((beta<=0))=1;

        g((beta>0))=1;
        gg((beta>0))=beta(beta>0)+1;

        

        %check_is_zero=(-g+gg)-beta
        x=(a+aa)*F+(-g+gg)*G ; % note that xpart=(a+aa)*F
        t=(-a+aa)*F+(g+gg)*G ;
        sol=[x,t]';
        z=[sum(F,1)+v, (g+gg)*G];
    else
        % fprintf('F (upper) is bigger  or equal\n');
        g = floor(rand(1,norows_G)*MAXV)+1;
        gg = floor(rand(1,norows_G)*MAXV)+1;;

        tpart=(g+gg)*G;
        [Dred,bignore,lead,I]=echelon(F,[]);
        v=-tpart(lead)*Dred;  %
        %beta=-tpart(lead)*I; % this is equivalent
        beta=v*F'/(N/2);
        a=zeros(1,norows_F);
        aa=zeros(1,norows_F);
        
%         sr = beta*0;
%         for k=1:length(beta),
%             if(beta(k)<=0),
%                 sr(k) = floor(rand(1,norows_F)*MAXV)+1;
%             end;
%         end;
        a((beta<=0))=-beta(beta<=0) + 1;
        aa((beta<=0))= 1;

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

    numzero = sum(sol == 0);
    if numzero > maxnumzero,
        maxnumzero = numzero;
        fprintf('%d > Found new maxzero %d\n', it, maxnumzero);
        aSV  = a;
        aaSV = aa;
        gSV  = g;
        ggSV = gg;
        solSV = sol
    end;
end;
fprintf('-------------------------------\n');
besta  = aSV 
bestaa = aaSV
bestg  = gSV 
bestgg = ggSV
bestsol= solSV
fprintf('Max zero found:%d\n', maxnumzero);
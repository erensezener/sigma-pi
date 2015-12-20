function sol=genRandSol2(F,G, y, MAXIT ,MAXV)
% Erhan Oztop, Dec 12, 2015
% This initiates a random search on alpha, alpha', gamma, gamma' parameters
% appearing in the proof 3-quarters (2006 NC paper)
% F and G must be obtained makeFG(), y is the problem in bipolar form.
% MAXIT is the number of random substititions that will be tried
% MAXV  is the upper bound of integers that will be tried (i.e.1,2..MAXV)
% Output will be a solution to the problem y with hopefully with a lot of
% zero coefficients. Note that the bound of 3-quarters is always respected 
% as any positive assignment to alpha, alpha', gamma, gamma' must generate
% a solution with at least 25% of the monomials with zero coefficients as
% shown in 2006 NC paper.

% To search for solutions for the 5-dimensional problem hex2dec('dcfdda51')  
% given in the Appendix of 2015 NC paper use this: 
% y = ix2prob(hex2dec('dcfdda51'),32); 
% [threeQsol, F,G, threeQnumzeros] = makeFG(recmonsetup(log2(length(y))),y)
% genRandSol2(F,G, y);    

if (~exist('MAXIT','var')),
    MAXIT = 50000;
    MAXV  = 7;
    fprintf('MAXIT is set to %d\n',MAXIT);
end;
if (~exist('MAXV','var')),
    MAXV  = 7;
    fprintf('MAXV is set to %d\n',MAXV);
end;
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
        negix = find(beta<=0);
        posix = find(beta>0);
        neglen = length(negix);
        poslen = length(posix);
        sr = floor(rand(1,neglen)*MAXV)+1;
        
        a(negix)=-beta(negix) + sr;
        aa((beta<=0))= sr;

        sr = floor(rand(1,poslen)*MAXV)+1;
        a(posix)=sr;
        aa(posix)=beta(posix)+sr;

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
if (mod(it-1,round(MAXIT/100))==0)
    per = round(100*it/MAXIT);
    fprintf('[%d%%]',per);
    if (mod(per,10)==0),
        fprintf('\n');
    end;
end;
end;

fprintf('\n-------------------------------\n');
besta  = aSV 
bestaa = aaSV
bestg  = gSV 
bestgg = ggSV
bestsol= solSV
fprintf('Max zero found:%d\n', maxnumzero);
function [sol, F,G, numzeros]=makeFG(D,y)
% Erhan Oztop, Dec 12, 2015
% This returns the 3-quarters solution and the byproduct matrices of 
% F and G (see 2006 NC paper)
% Below is basically the  2005 description of the code used: 
% Given the dim dimensional problem of solving sol to satisfy sgn(D*sol)=y with 
% Ayir (i.e. makeFG now) creates two dim-1 systems which is equivalent to the initial system
% Further it constructs a solution which has guaranteed to have at least
% 1/4 of the 2^dim monomials with zero coefficients. 
% This is the implementation of the theorem proved in NC 2006 
% THEOREM: The minimum number of monomials that can solve any binary classification problem in 
% {-1,1}^n  is (upper) bounded by  3*2^(n-2)

% To use it: 
% Try y = ix2prob(31,8); makeFG(recmonsetup(log2(length(y))),y)




if size(y,2)==1,   y=y'; end;

upper=[];
lower=[];
Zup=[];
Zlo=[];
N=length(y);
for u=1:N/2,
    d=N/2+u;
    if (y(u)==1 & y(d)==1),
        upper=[upper; D(u,1:N/2)];
        Zup=[Zup;1];
    end;
        if (y(u)==-1 & y(d)==-1),
        upper=[upper; D(u,1:N/2)];
        Zup=[Zup;-1];
    end;
     if (y(u)==1 & y(d)==-1),
        lower=[lower; D(u,1:N/2)];
        Zlo=[Zlo;1];
    end;
     if (y(u)==-1 & y(d)==1),
        lower=[lower; D(u,1:N/2)];
        Zlo=[Zlo;-1];
    end;
end; %u
    
      
F=diag(Zup)*upper;
G=diag(Zlo)*lower;
  
          
% assume solution vector is [x;t] then the original system is equivalent to:
% Dx<Dt<-Dx  and Et<Ex<-Et

[rD,nn]=size(F);
[rE,nn]=size(G);

%F
%G
if (isempty(G)),
    a=ones(1,rD);
	aa=ones(1,rD);
    x=(a+aa)*F ;
	t=(-a+aa)*F ;
	sol=[x,t]';
    check_positive=D*sol.*y';
    fprintf(' G empty returning lower dimension problem solution \n');
if (N==sum(check_positive>0)),
else
    disp('!!!!!!!!! TERRIBLE1 !!!!!!!!!!');
    sol=[];
end;
return;
end;

if (isempty(F)),
    g=ones(1,rE);
	gg=ones(1,rE);
    x=(-g+gg)*G ; 
	t=(g+gg)*G ;
	sol=[x,t]';
    check_positive=D*sol.*y';
    fprintf(' F empty returning lower dimension problem solution \n');
if (N==sum(check_positive>0)),
else
    disp('!!!!!!!!! TERRIBLE 2!!!!!!!!!!');
    sol=[];
end;
return;
end;

% naming is a bit changed so G=E F=D
if rE>=rD,
	%% fprintf(' G>F (bottom) is bigger \n');
	a=ones(1,rD);
	aa=ones(1,rD);
	xpart=(a+aa)*F;
    %% fprintf('xpart (f) ');
    %% xpart
	[Ered,bignore,lead,I]=echelon(G,[]);
    %% fprintf('Echelon of G) ');
    %% Ered
    v=-xpart(lead)*Ered;  %
    %% fprintf('Echelon of G) ');
    %% v
	%beta=-xh(lead)*I;  % this is equivalent
    beta=v*G'/(N/2);
    %% beta
	g=zeros(1,rE);
	gg=zeros(1,rE);
	g((beta<=0))=-beta(beta<=0)+1;
	gg((beta<=0))=1;
	
	g((beta>0))=1;
	gg((beta>0))=beta(beta>0)+1;
	
    %% fprintf('gammas are found:');
    %% g
    %% gg
    
	%check_is_zero=(-g+gg)-beta
	x=(a+aa)*F+(-g+gg)*G ; % note that xpart=(a+aa)*F
	t=(-a+aa)*F+(g+gg)*G ;
	sol=[x,t]';
    %% sol'
    %% z=[sum(F,1)+v, (g+gg)*G]
else
     % fprintf('F (upper) is bigger  or equal\n');
     g=ones(1,rE);
	gg=ones(1,rE);
	tpart=(g+gg)*G;
    %tic;
	[Dred,bignore,lead,I]=echelon(F,[]);
    %toc;
    v=-tpart(lead)*Dred;  % 
	%beta=-tpart(lead)*I; % this is equivalent
    beta=v*F'/(N/2);
	a=zeros(1,rD);
	aa=zeros(1,rD);
	a((beta<=0))=-beta(beta<=0)+1;
	aa((beta<=0))=1;
	
	a((beta>0))=1;
	aa((beta>0))=beta(beta>0)+1;
	
	%check_is_zero=(-a+aa)-beta
	x=(a+aa)*F+(-g+gg)*G ; 
	t=(-a+aa)*F+(g+gg)*G ;%  note that tpart=(g+gg)*G
	sol=[x,t]';
    
end;

sol_3Q = sol'

check_positive=D*sol.*y';
if (N==sum(check_positive>0)),
    %disp('OK! , Solution coefficients:');
    %sol'
else
    disp('!!!!!!!!! TERRIBLE !!!!!!!!!!');
    sol=[];
end;

numzeros = sum(sol==0);
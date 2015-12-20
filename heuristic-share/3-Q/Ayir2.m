function [D,E,sol]=Ayir2(Q,y)
% Given the dim dimensional problem of solving sol to satisfy sgn(Q*sol)=y with 
% Ayir creates two dim-1 systems which is equivalent to the initial system
% Further it constructs a solution which has guaranteed to have at least
% 1/4 of the 2^dim monomials with zero coefficients. 
% This is the implementation of the theorem I proved 
% THEOREM: The minimum number of monomials that can solve any binary classification problem in 
% {-1,1}^n  is (upper) bounded by  3*2^(n-2)
% Erhan Oztop, May 12, 2005

upper=[];
lower=[];
Zup=[];
Zlo=[];
N=length(y);
for u=1:N/2,
    d=N/2+u;
    if (y(u)==1 & y(d)==1),
        upper=[upper; Q(u,1:N/2)];
        Zup=[Zup;1];
    end;
        if (y(u)==-1 & y(d)==-1),
        upper=[upper; Q(u,1:N/2)];
        Zup=[Zup;-1];
    end;
     if (y(u)==1 & y(d)==-1),
        lower=[lower; Q(u,1:N/2)];
        Zlo=[Zlo;1];
    end;
     if (y(u)==-1 & y(d)==1),
        lower=[lower; Q(u,1:N/2)];
        Zlo=[Zlo;-1];
    end;
end; %u
    
      
D=diag(Zup)*upper;
E=diag(Zlo)*lower;
  
          
% assume solution vector is [x;t] then the original system is equivalent to:
% Dx<Dt<-Dx  and Et<Ex<-Et

[rD,nn]=size(D);
[rE,nn]=size(E);

%D
%E
if (isempty(E)),
    a=ones(1,rD);
	aa=ones(1,rD);
    x=(a+aa)*D ;
	t=(-a+aa)*D ;
	sol=[x,t]';
    check_positive=Q*sol.*y';
if (N==sum(check_positive>0)),
else
    disp('!!!!!!!!! TERRIBLE1 !!!!!!!!!!');
    sol=[];
end;
return;
end;

if (isempty(D)),
    g=ones(1,rE);
	gg=ones(1,rE);
    x=(-g+gg)*E ; 
	t=(g+gg)*E ;
	sol=[x,t]';
    check_positive=Q*sol.*y';
if (N==sum(check_positive>0)),
else
    disp('!!!!!!!!! TERRIBLE 2!!!!!!!!!!');
    sol=[];
end;
return;
end;

% naming is a bit changed so G=E F=D
if rE>=rD,
	fprintf(' G>F (bottom) is bigger \n');
	a=ones(1,rD)*0.5;
	aa=ones(1,rD)*0.5;
	xpart=(a+aa)*D;
    fprintf('xpart (f) ');
    xpart
	[Ered,bignore,lead,I]=echelon(E,[]);
     fprintf('Echelon of G) ');
    Ered
    v=-xpart(lead)*Ered;  %
     fprintf('Echelon of G) ');
    v
	%beta=-xh(lead)*I;  % this is equivalent
    beta=v*E'/(N/2);
    beta
	g=zeros(1,rE);
	gg=zeros(1,rE);
	g((beta<=0))=-beta(beta<=0)+1;
	gg((beta<=0))=1;
	
	g((beta>0))=1;
	gg((beta>0))=beta(beta>0)+1;
	
    fprintf('gammas are found:');
    g
    gg
    
	%check_is_zero=(-g+gg)-beta
	x=(a+aa)*D+(-g+gg)*E ; % note that xpart=(a+aa)*D
	t=(-a+aa)*D+(g+gg)*E ;
	sol=[x,t]';
    sol'
    z=[sum(D,1)+v, (g+gg)*E]
else
     % fprintf('D (upper) is bigger  or equal\n');
     g=ones(1,rE);
	gg=ones(1,rE);
	tpart=(g+gg)*E;
	[Dred,bignore,lead,I]=echelon(D,[]);
    v=-tpart(lead)*Dred;  % 
	%beta=-tpart(lead)*I; % this is equivalent
    beta=v*D'/(N/2);
	a=zeros(1,rD);
	aa=zeros(1,rD);
	a((beta<=0))=-beta(beta<=0)+1;
	aa((beta<=0))=1;
	
	a((beta>0))=1;
	aa((beta>0))=beta(beta>0)+1;
	
	%check_is_zero=(-a+aa)-beta
	x=(a+aa)*D+(-g+gg)*E ; 
	t=(-a+aa)*D+(g+gg)*E ;%  note that tpart=(g+gg)*E
	sol=[x,t]';
    
end;



check_positive=Q*sol.*y';
if (N==sum(check_positive>0)),
    %disp('OK! , Solution coefficients:');
    %sol'
else
    disp('!!!!!!!!! TERRIBLE !!!!!!!!!!');
    sol=[];
end;
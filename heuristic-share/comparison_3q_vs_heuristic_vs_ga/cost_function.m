function [ numberOfCoefficients, a ] = cost_function( y , mask)
%SORTED_NSHEURISTIC gets vector representation of a Boolean function in
%{-1,1}^(2^n) form and applies the heuristic algorithm.

l = length(y);
n = log2(l);
D = monsetup(n);
Y = diag(y);
Q = Y * D;
options.Algorithm = 'simplex';
options.Display = 'none';


H = Q(:, logical(mask));

%Simplex function is called via linprog, built-in Matlab toolbox.
% [x, ~, exitflag] = x = linprog(f,A,b,Aeq,beq,lb,ub,x0,options)
% Goal of the function is,
% minimize f' * x,
% s.t. A * x <= b, Aeq * x = beq, lb<=x<=ub

% We are not particular about f' * x , hence f is 0's
% We have no inequalities, hence A = [], b = []
% Aeq = H'
% beq = [0 0 0 .... 0]
% lb = [1 1 1 .... 1]
% up = [1000 1000 .... 1000]
% That is we solve H' * x = 0 s.t. 1<=x<=1000
% If optimization is completed succesfully, exitflag is 1.
%[x,~,exitflag] = linprog(zeros(l,1),[],[],H',zeros(size(currentRows,1),1),ones(l,1),1000*ones(l,1));

[x,~,exitflag] = linprog(zeros(l,1),[],[],H',zeros(sum(mask),1),ones(l,1),1000*ones(l,1),[], options);
if size(x,1) ~= l
    x = ones(l,1);
end
a = Q' * x;
a(logical(mask),:) = 0 ;
res = Q * a;

if exitflag == 1 && nnz(res>0) == 2^n %Checks if the result is valid
    numberOfCoefficients = 2 ^ n - sum(mask);

else %If cannot eliminate the last coefficient, remove it from the indices
    numberOfCoefficients = 2^n;
end
end
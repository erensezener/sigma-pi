function [successes] = bf_search_nchoosek( y, k, number_of_attempts )
%SORTED_NSHEURISTIC gets vector representation of a Boolean function in
%{-1,1}^(2^n) form and applies the heuristic algorithm.
% k is the number of monomials which will be attempted to be eliminated


l = length(y);
n = log2(l);
D = monsetup(n);
Y = diag(y);
Q = Y * D;
invQ = D * Y;
colSum = sum(invQ,2); %obtain spectral coefficients
T = abs(colSum);
[~, indices] = sort(T); %sort spectral coefficients
options.Algorithm = 'simplex';
options.Display = 'none';

successes = false(number_of_attempts, l);
last_success_index = 0;

tic
for i = 1:number_of_attempts
    selection_key = sample_binary_vectors_of_sum_k(l, k)';
    currentRows = indices(selection_key);
    H = Q(:, currentRows);
    
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

    [x,~,exitflag] = linprog(zeros(l,1),[],[],H',zeros(size(currentRows,1),1),ones(l,1),1000*ones(l,1),[], options);
    if size(x,1) ~= l
        x = ones(l,1);
    end
    a = Q' * x;
    a(currentRows,:) = 0 ;
    res = Q * a;
        
    if exitflag == 1 && nnz(res>0) == 2^n %if the result is valid
        last_success_index = last_success_index + 1;
        successes(last_success_index, :) = selection_key;
    end
end
successes = successes(1:last_success_index, :); %trim the zeroes of the pre-allocated matrix
toc
end
iterations = 8;
monomials = zeros(iterations,2);
n = 8;

problem_ints = randi(2^53-1, iterations, 1);


parfor i = 1:iterations
    y = ix2prob(problem_ints(i,1)-1,2^n);
    [linear_mons, ~] = linear_heuristic(y);
    [bs_mons, ~] = bs_heuristic(y);
    monomials(i,:) = [linear_mons, bs_mons]; 
end
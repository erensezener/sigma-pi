function [number_of_coefficients, a] = simple_ga_parameterized(y, last, sel, mutrate)

% This is a simple GA written in MATLAB
% costfunction.m calculates a cost for each row or
% chromosome in pop. This function must be provided
% by the user.
% last: number of generations
% sel: selection rate
% mut_rate: mutation rate

N=size(y,2); % number of bits in a chromosome
M=16; % number of chromosomes must be even
M2=2*ceil(sel*M/2); % number of chromosomes kept
nmuts=mutrate*N*(M-1); % number of mutations
% creates M random chromosomes with N bits
pop=round(rand(M,N)); % initial population
for ib=1:last
    cost = zeros(size(pop,1),1);
    for i = 1:size(pop,1)
        cost(i,:) = cost_function(y, pop(i,:)); % cost function
        %     cost(i,:) = -1 * sum(pop(i,:));
    end
    % ranks results and chromosomes
    [cost,ind]=sort(cost);
    best_pop = pop(ind(1), :);
    pop=pop(ind(1:M2),:);
    [ib cost(1)];
    %mate
    cross=ceil((N-1)*rand(M2,1));
    % pairs chromosomes and performs crossover
    for ic=1:2:M2
        pop(ceil(M2*rand),1:cross)=pop(ic,1:cross);
        pop(ceil(M2*rand),cross+1:N)=pop(ic+1,cross+1:N);
        pop(ceil(M2*rand),1:cross)=pop(ic+1,1:cross);
        pop(ceil(M2*rand),cross+1:N)=pop(ic,cross+1:N);
    end
    %mutate
    for ic=1:nmuts
        ix=ceil(M*rand/2);
        iy=ceil(N*rand);
        pop(ix,iy)=1-pop(ix,iy);
    end %ic
end %ib

number_of_coefficients = cost(1);
[n, a] = cost_function(y, best_pop);
if n~=number_of_coefficients
    display('Oopps');
    return;
end
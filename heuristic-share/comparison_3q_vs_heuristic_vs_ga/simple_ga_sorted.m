function [number_of_coefficients] = simple_ga_sorted(y)

% This is a simple GA written in MATLAB
% costfunction.m calculates a cost for each row or
% chromosome in pop. This function must be provided
% by the user.

 
N=size(y,2); % number of bits in a chromosome
M=16; % number of chromosomes must be even
last=40; % number of generations
sel=0.5; % selection rate
M2=2*ceil(sel*M/2); % number of chromosomes kept
mutrate=0.01; % mutation rate
nmuts=mutrate*N*(M-1); % number of mutations
% creates M random chromosomes with N bits
pop=round(rand(M,N)); % initial population
for ib=1:last
 cost = zeros(size(pop,1),1);
 for i = 1:size(pop,1)
    cost(i,:) = cost_function_sorted(y, pop(i,:)); % cost function
%     cost(i,:) = -1 * sum(pop(i,:));
 end
 % ranks results and chromosomes
 [cost,ind]=sort(cost);
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
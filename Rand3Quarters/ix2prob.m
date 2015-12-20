function [y,kk]=ix2prob(ix,fdim);
%% [y,kk]=ix2prob(ix,fdim); 
%% Given the problem id returns the output spec.
%% If problem dimension is n the function space dimension is 2^n
%% So fdim should be given as 2^(#ofvariables) 

   y=zeros(fdim,1);
   kk=0; 
 for h=1:fdim,   % was bogously 2^dim!!
     y(h)=2*mod(ix,2)-1;
     ix=floor(ix/2);
     kk=kk+(y(h)+1)/2;
 end; % h
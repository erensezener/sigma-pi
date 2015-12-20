function [y,kk]=ix2prob(ix,dim);
%% given the problem id returns the output spec.

   y=zeros(dim,1);
   kk=0; 
 for h=1:dim,   % was bogously 2^dim!!
     y(h)=2*mod(ix,2)-1;
     ix=floor(ix/2);
     kk=kk+(y(h)+1)/2;
 end; % h
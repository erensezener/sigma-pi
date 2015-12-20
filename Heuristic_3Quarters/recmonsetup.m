function [D]=recmonsetup(dim)
% Erhan Oztop Sep 2008 
% Given the dimension it constructs the high order expansion recursively
% This is much faster than the iterative version monsetup(dim)
%  The polynomial coefficents, a, of the exact interpolation can be found with a=D^-1*Y
%  But the sign freedom allows us to write a=Dinv*Y*K for K>0
if (dim==0),
    D = 1;
else
    Ds = recmonsetup(dim-1);
    D = [ Ds Ds; Ds -Ds];
end;

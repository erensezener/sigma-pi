% n: number of dimensions,
% y: function specification

%y = [1 -1 1 1  1 -1 -1 1  -1 1 -1 -1 -1 -1 1 -1 1 -1 1 -1  1 1 -1 -1 1 -1 1 -1 1 1 1 -1 1 1 1 -1  -1 1 -1 -1  1 1 1 -1 -1 -1 1 1 1 1 -1 1  -1 -1 -1 -1  1 1 1 -1 1 -1 -1 -1 1 -1 1 -1  -1 1 -1 -1  1 -1 1 -1 -1 -1 1 1 1 -1 1 -1  1 1 -1 -1 -1 -1 1 -1 -1 1 1 -1 1 -1 1 -1  -1 1 -1 -1  1 -1 1 -1 -1 -1 1 -1 1 1 -1 1  -1 -1 -1 -1  1 1 1 -1 1 1 1 1];
%y = [1 -1 1 -1  -1 1 -1 -1  1 1 1 -1 -1 -1 1 1 1 -1 1 -1  -1 1 -1 -1  1 1 1 -1 1 1 1 1];
%y = [-1 1 1 1  1 1 1 1  1 1 1 1  1 -1 1 1  ];

% y = [-1     1     1     1     1     1     1     1];

y = [1 1 1 1];

% y = [1 1 1 1 -1 1 -1 -1 -1 -1 1 -1 -1 -1 1 -1];

n=log2(length(y));
Q = monsetup(n);

[F,G,coef] = Ayir(Q,y);
% This is the 3-quarters thm solution (it must have at least 2^n/4 zeros)
coef = coef'
nnz(coef)

% This is the exact interpolation solution
spect = sum(diag(y)*Q)*2^-n;




%The effect of this program can be obtained with this command
%[F,G,coef] = Ayir(monsetup(3),[1 -1 1 -1  -1 1 -1 -1])
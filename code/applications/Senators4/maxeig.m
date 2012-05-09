function [u,sigma]=maxeig(S)
% Compute maximum eigenvalue and eigenvector of S
n=size(S,1);
if n==1
    u=1;sigma=S;
else
    options.disp=0;
    [u,sigma]=eigs((S+S')/2,1,'la',options);
end
function [subres,sol,vars,rhobreaks,res]=FullPathLarge(A,S)
% Given decomposition, compute full greedy path
n=size(A,1);
subset=[1];subres=[subset';zeros(n-length(subset),1)];
res=[];rhobreaks=[sum(A(:,1).^2)];sol=[];vars=[];
% Loop through other vectors
for i=1:(n-1)
    % Compute solution at current subset
    [v,mv]=maxeig(S(subset,subset));
    vsol=zeros(n,1);vsol(subset)=v;
    sol=[sol,vsol];vars=[vars,mv];
    % Compute x at current subset
    x=A(:,subset)*v;x=x/norm(x);
    res=[res,x];
    % Compute next rho breakpoint
    set=1:n;set(subset)=[];
    vals=(x'*A(:,set)).^2;
    [rhomax,vpos]=max(vals);
    rhobreaks=[rhobreaks;rhomax];
    subset=[subset,set(vpos)];subres=[subres,[subset';zeros(n-length(subset),1)]];
end
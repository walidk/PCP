%% Weigthed Median heuristics for solving Robust PCA
function [t] = wmh(n, c,d)
%%% Initialization
%n = 5;

%c = ones(1,n);
%d = zeros(1,n);

%for i = 1:n
% d(i) = n+1-i;
% c(i) =  (i);
%end

%%% Sorting 



[D,IX] = sort(d);

for i = 1:n
    C(i) = c(IX(i));
end


wantcontinue = 1;

if ( C(1)   >= sum   (C(2:n)))
        t = D(1);
end

if ( C(n)   >= sum   (C(1:n-1)))
        t = D(n);
end


for i = 2:n-1
    if (wantcontinue == 1 && sum(C(1:i-1))   <= sum   (C(i:n))    &&  sum(C(1:i))  >=  sum(C(i+1:n)))
        t = D(i);
        wantcontinue = 0;
    end  
end


%onevec = ones(1,n);
%cvx_begin
%    variables tcheck
%    minimize(sum(C * abs(tcheck*onevec-D)'));
%cvx_end

t;
%tcheck

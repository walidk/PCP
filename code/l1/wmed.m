function t = wmed(Z, u)
% Weighted median
% t = wmed(Z, u)
% If Z is a vector, returns the solution to the problem
% minimize norm(Z - t*u, 1)
% This is an l_1 projection problem of vector Z onto vector u.
% If Z is a matrix, returns the solution to the problem
% minimize norm(Z - t*u', 1)
% This will solve M constrained vector projection probelems.


[N1 N2] = size(Z);

t = zeros(N2, 1);

if(N2 == 1) % vector case
    supp_u = u~=0;
    u_trunc = u(supp_u);
    card_u = size(u_trunc, 1);
    [z perm] = sort(Z(supp_u) ./ u_trunc);
    u_sorted = abs(u_trunc(perm));
    
    
    if(card_u > 0) %u non zero
        n = 0;
        s1 = 0;
        s2 = sum(u_sorted); % Display this for debug: this is sometime NAN
        while(n < card_u && s1 <= s2)
            n = n+1;
            s1 = s1 + u_sorted(n);
            s2 = s2 - u_sorted(n);
        end
        t = z(n);
    else % u = 0
        t = 1;
    end 
else % matrix case
    for m=1:N2
        t(m) = wmed(Z(:,m), u);
    end
end
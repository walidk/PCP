function t = cwmed(Z, u)
% Constrained weighted median
% t = cwmed(Z, u)
% If Z is a vector, returns the solution to the constrained problem
% minimize norm(Z - t*u, 1)
% subject to |t| <= 1
% This is a contrained l_1 projection problem of vector Z onto vector u.
% If Z is a matrix, returns the solution to the constrained problem
% minimize norm(Z - t*u', 1)
% subject to norm(t, inf) = 1
% Note the equality constraint. This will first solve N2 constrained vector
% projection probelems, then normalize the solution if necessary.


[N1 N2] = size(Z);

t = zeros(N2, 1);

% first solve M projected weighted median problems ========================
normed = false;
for m=1:N2
    t(m) = wmed(Z(:,m), u);
    if(abs(t(m)) > 1)
        t(m) = sign(t(m));
        normed = true;
    end
end


% Project obtained solution if needed =====================================
if(~normed) % have to normalize one of the components
    m0 = 1;
    eps0 = 1;
    min = -norm(Z(:,1) - t(1)*u, 1) + norm(Z(:,1) + u, 1);
    for m=1:N2
        for eps=-1:2:1 % eps is -1 or 1
            obj_val = -norm(Z(:,m) - t(m)*u, 1) + norm(Z(:,m) + eps*u, 1); % project t(m) on eps
            if(obj_val < min)
                m0 = m;
                eps0 = eps;
                min = obj_val;
            end
        end
    end
    t(m0) = eps0;
end
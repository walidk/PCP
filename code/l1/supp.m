function s = supp(M, z_thresh)
% s = support(M, z_thresh)
% returns the number of elements in the matrix M that are greater than
% z_thresh in absolute value.
% If not provided, z_thresh defaults to 1e-05


if(nargin == 1)
    z_thresh = 1e-05;
end
s = sum(abs(M(:)) > z_thresh);
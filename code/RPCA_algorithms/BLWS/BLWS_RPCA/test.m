% test

for rho_r = [0.05]
    for m = [500]
        compare_rpca(m, rho_r, 0.10);
    end
end
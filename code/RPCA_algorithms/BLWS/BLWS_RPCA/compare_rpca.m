% compare rpca
function [] = compare_rpca(m, rho_r, rho_s)

%addpath PROPACK;
    
close all ;

n = m ;
r = round(rho_r*min(m,n)) ;
p = rho_s ;
U = (randn(m,r)); V = (randn(n,r));
A = U*V' ;
    
temp = randperm(m*n) ;
numCorruptedEntries = round(p*m*n) ;
corruptedPositions = temp(1:numCorruptedEntries) ;
E = zeros(m,n) ;
E(corruptedPositions) = 1000 * (rand(numCorruptedEntries,1)-0.5) ;
    
D = A + E ;
    
clear temp corruptedPositions A E;

[A_dual, E_dual, total_svd, svp, tElapsed] = BLWS_ialm_rpca(D, -1, 1e-6, -1, 0) ;
    
A = U * V';
disp('Relative error in estimate of A') ;
error = norm(A_dual-A,'fro')/norm(A,'fro');
disp(error) ;
clear A;
disp('# svd');
disp(total_svd);
disp('Rank of estimated A') ;
disp(svp) ;
disp('0-norm of estimated E') ;
disp(length(find(abs(E_dual)>0))) ;
disp('|D-A-E|_F');
disp(norm(D-A_dual-E_dual,'fro'));
disp('Time taken (in seconds)') ;
disp(tElapsed) ;

disp('||A||_* + lambda * |E|_1');
disp(sum(svd(A_dual)) + sum(abs(E_dual(:))));

fid = fopen('result.txt','a+t') ;
fprintf(fid, '\n');
fprintf(fid, '%g & %g & %g & IALM & %e & %g & %g & %g & %f & %e ', m, r, numCorruptedEntries,...
    error, svp, length(find(abs(E_dual)>0)), total_svd, tElapsed, norm(D-A_dual-E_dual,'fro'));
fclose(fid) ;

clear A_dual E_dual;

[A_dual, E_dual, total_svd, svp, tElapsed] = BLWS_ialm_rpca(D, -1, 1e-6, -1, 1) ;
    
A = U * V';
disp('Relative error in estimate of A') ;
error = norm(A_dual-A,'fro')/norm(A,'fro');
disp(error) ;
clear A;
disp('Iterations') ;
disp(total_svd) ;
disp('Rank of estimated A') ;
disp(svp) ;
disp('0-norm of estimated E') ;
disp(length(find(abs(E_dual)>0))) ;
disp('|D-A-E|_F');
disp(norm(D-A_dual-E_dual,'fro'));
disp('Time taken (in seconds)') ;
disp(tElapsed) ;

disp('||A||_* + lambda * |E|_1');
disp(sum(svd(A_dual)) + sum(abs(E_dual(:))));

fid = fopen('result.txt','a+t') ;
fprintf(fid, '\n');
fprintf(fid, '%g & %g & %g & IALM_BL & %e & %g & %g & %g & %f & %e ', m, r, numCorruptedEntries,...
    error, svp,...
    length(find(abs(E_dual)>0)), total_svd, tElapsed, norm(D-A_dual-E_dual,'fro'));
fclose(fid) ;

clear A_dual E_dual;

function [S2, L2] = robustpcarankonev3(n, A , r)

numberofrun = 100;

Ainstorage = A;
for indexouter = 1:r
p(:,indexouter) = ones(1,n) * 0.1;
q(:,indexouter)= ones(1,n)* 0.1;
end


for i = 1: numberofrun
    for indexouter= 1:r
        
        %Computing A to optimze
        A = Ainstorage;
  
        for indexinner = 1:r
            if indexinner ~= indexouter
                A = A - squeeze(p(:,indexinner))*squeeze(q(:,indexinner))' ;
            end
        end
checkpbefore = sum(sum(abs(A-squeeze(p(:,indexouter))*squeeze(q(:,indexouter))'))) ;   
        %computing p
        for index = 1:n 
 c = abs(q(:,indexouter))';
 d = ( A(index,:)./squeeze(q(:,indexouter))' );
 p(index,indexouter) = wmh(n,c,d);
        
        %qtemp=    squeeze(q(:,indexouter))';
        %c = abs(qtemp);
        %d = ( A(index,:)./qtemp );
        %p(index,indexouter) = wmh(n,c,d);
%cvx_begin
%variables  pkk(n)
 %minimize(abs(sum(sum(A - pkk * squeeze(q(:,indexouter))')))) 
 %subject to 
 %for indexdebug = 1:n
%    if indexdebug ~= index
%        pkk(indexdebug) ==  p(indexdebug,indexouter);
 %   end
 %end
%cvx_end

%p(index,indexouter) = pkk(index); 
        
checkp2 = sum(sum(abs(A-squeeze(p(:,indexouter))*squeeze(q(:,indexouter))')))       ;           
           
        end

        



checkqbefore = sum(sum(abs(A-squeeze(p(:,indexouter))*squeeze(q(:,indexouter))')))      ;   
        %computing q
        for index = 1:n 
 c = abs(p(:,indexouter))';
 d = ( A(:,index)./squeeze(p(:,indexouter)) );
 q(index,indexouter) = wmh(n,c,d);
    
%cvx_begin
%variables  qkk(n)
% minimize(sum(sum(abs(A -   squeeze(p(:,indexouter))*qkk')))) 
% subject to 
% for indexdebug = 1:n
%    if indexdebug ~= index
%        qkk(indexdebug) ==  q(indexdebug,indexouter);
%    end
% end
%cvx_end
        
 %              q(index,indexouter) = qkk(index); 
        
        end
  
checkq2 = sum(sum(abs(A-squeeze(p(:,indexouter))*squeeze(q(:,indexouter))')));

    end
    

end

L2 =zeros(n,n) ;
S2 =Ainstorage;
%for indexouter = 1:r
%   
%squeeze(p(:,indexouter))
%squeeze(q(:,indexouter))

%end 
for indexouter = 1:r
S2 = S2 - squeeze(p(:,indexouter))*squeeze(q(:,indexouter))' ;
L2 = L2 +  squeeze(p(:,indexouter))*squeeze(q(:,indexouter))';
end
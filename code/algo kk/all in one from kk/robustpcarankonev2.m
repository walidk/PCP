function [S2, L2] = robustpcarankonev2(n, A)

numberofrun = 20;

p = ones(1,n);
q = ones(1,n);
mu = 1;


for i = 1: numberofrun
    %computing p
    for index = 1:n 
        c = abs(mu*q);
        d = ( A(index,:)./(q*mu) );
        p(index) = wmh(n,c,d);
    end
    
    p = p / norm(p); 
    
    %computing q
    for index = 1:n 
        c = abs(mu*p);
        d = ( A(:,index)./(p*mu)' );
        q(index) = wmh(n,c,d);
    end
  
   q = q / norm(q); 
    
    %compute \mu
    lambda = (1/sqrt(n));
    counter =1;
    cmu(counter) = 1;
    dmn(counter) = 0;
    counter = counter +1;
    
    for index1 = 1:n
        for index2 = 1:n
            cmu(counter) = lambda * abs(p(index1)*q(index2));
            dmu(counter) = A(index1,index2)/(p(index1)*q(index2));
            counter = counter +1;
        end
    end
    
    counter = counter -1;
    
    temp = wmh(counter,cmu,dmu);
    if temp ~= 0
        mu = temp;
    end
end
    

S2 = A - mu*p'*q ; 
L2 = mu*p'*q;
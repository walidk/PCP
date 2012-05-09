% Test Full Reg Path on senator voting record
load senate_voting_data_only.mat
load SenatorTagData.mat
load bills.mat
redindex=find(senparts==0);
blueindex=find(senparts==1);

% Regular PCA
if 0
[pc, zscores, pcvars] = princomp(data');
cumsum(pcvars./sum(pcvars) * 100)
scatter(zscores(:,1),zscores(:,2),'bo');
xlabel('First PC');
ylabel('Second PC');
title('PCA on vote data');
end

S=cov(data')+1e-9*eye(size(data,1));

if 0
spy(sol)
xlabel('Cardinality');
ylabel('Variable');
end

k1=100;k2=10;

if 1
% Sort A w.r.t. diag, take Cholesky of S
[d,ix]=sort(diag(S),'descend');S=S(ix,ix);
A=chol(S);
tic;[subres1,sol1,vars1,rhobreaks1,res1]=FullPathLarge(A,S);toc
sv1=sol1(:,k1);

S2=S;S2(find(sv1),:)=[];S2(:,find(sv1))=[];A2=chol(S2);
tic;[subres2,sol2,vars2,rhobreaks2,res2]=FullPathLarge(A2,S2);toc
sv2=zeros(size(S,1),1);sv2(find(sv1==0))=sol2(:,k2);
end

% Plot results
if 0
subplot(2,2,1);plot(1:size(S,1)-1,vars1,'-o','MarkerSize',3,'LineWidth',1);pbaspect([1,1,1]);hold on;line([k1 k1],[0 max(vars1)]);hold off;
subplot(2,2,2);plot(1:size(S2,1)-1,vars2,'-o','MarkerSize',3,'LineWidth',1);pbaspect([1,1,1]);hold on;line([k2 k2],[0 max(vars2)]);hold off;
subplot(2,2,3);plot(data(:,redindex)'*sv1,data(:,redindex)'*sv2,'ro');pbaspect([1,1,1]);hold on;
plot(data(:,blueindex)'*sv1,data(:,blueindex)'*sv2,'b*');pbaspect([1,1,1]);hold off;
end

if 1
plot(data(:,redindex)'*sv1,data(:,redindex)'*sv2,'ro');pbaspect([1,1,1]);hold on;
plot(data(:,blueindex)'*sv1,data(:,blueindex)'*sv2,'b*');pbaspect([1,1,1]);hold off;
bills(find(sparse(sv1)))
bills(find(sparse(sv2)))
end


% Place text label on outliers (furthest away from center of their camp)
nnames=3;
cred=mean([data(:,redindex)'*sv1,data(:,redindex)'*sv2]);
cblue=mean([data(:,blueindex)'*sv1,data(:,blueindex)'*sv2]);
devred=[data(:,redindex)'*sv1,data(:,redindex)'*sv2]-ones(length(redindex),1)*cred;
devblue=[data(:,blueindex)'*sv1,data(:,blueindex)'*sv2]-ones(length(blueindex),1)*cblue;
devred=sum(devred'.^2);devblue=sum(devblue'.^2);
[m,loutred]=sort(devred,'descend');[m,loutblue]=sort(devblue,'descend');
outblue=blueindex(loutblue(1:nnames));outred=redindex(loutred(1:nnames));
for k=1:nnames
    text(data(:,outblue(k))'*sv1,data(:,outblue(k))'*sv2+0.1,names(outblue(k)),'FontWeight','bold');
    text(data(:,outred(k))'*sv1,data(:,outred(k))'*sv2+0.1,names(outred(k)),'FontWeight','bold');
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
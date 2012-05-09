% this files plots stuff about Senate voting data

% load data
load senate_voting_data_only;
A = data';
[m,n] = size(A); % n bills, m Senators

choice = 4;

% this plots the raw matrix
if choice == 1,
    h=imagesc(A);
    cred = [1 0 0];
    cblue = [0 0 1];
    cwhite = [1 1 1];
    cmp = [ones(31,1)*cred; ones(2,1)*cwhite; ones(31,1)*cblue];
    colormap(cmp);
    h=colorbar;
    ylabel('Senators')
    xlabel('Bills')
    shg
    print -dpng ../../../../html/Images/sym_votemat_raw.png
end

% find averages and plot them
% average across bills
if choice ==2,
    plot(sort(mean(A,2)))
    xlabel('Senators')
    print -dpng ../../../../html/Images/sym_vote_avg_bills.png
end

% average across Senators
if choice == 3,
    plot(sort(mean(A,1)))
    line([0;600],[0;0])
    xlabel('Bills')
    print -dpng ../../../../html/Images/sym_vote_avg_sen.png
end

% plot average across bills on a simple line
if choice == 4,
    alpha = 0.03;  % Size of arrow head relative to the length of the vector
    beta = alpha/100;  % Width of the base of the arrow head relative to the length
%    text(0.95,0.40,'$\mathbf{1}$','Interpreter','latex','Fontsize',18)
    % remove mean from A
    ahat = mean(A,2);
    An = A - ahat*ones(1,n);
    dirproj = (1/sqrt(m))*ones(m,1);
    pts = dirproj'*An;
    h=plot(pts,0*pts,'ko','Markersize',10,'Markerfacecolor','c'); 
    hold on

    amin = min(pts);
    amax = max(pts);
    range = amax-amin;
    amin = amin-.1*range;
    amax = amax+.1*range;
    line([amin;amax],[0;0]);
    
    u = [amax; 0]; 
    v = [u(2); -u(1)];
    ptsax = [(1-alpha)*u+beta*v u (1-alpha)*u-beta*v (1-alpha)*u];
    h=fill(ptsax(1,:),ptsax(2,:),'b');
    %set(h,'Linewidth',1);

    axis([amin-.1*range amax+.1*range -.1 .1])
    axis xy
    %axis off
    
    hold off
    print -dpng ../../../../html/Images/svd_vote_avg_sen_axis.png
end

return

% do some random projection (in the space of bills)
% choose direction
clf
fig1 = figure(1);
N = 3;
txt = cell(N,1);
dirprojmat = randn(m,N);
for i = 1:N,
    dirproj = dirprojmat(:,i);
    dirproj = dirproj/norm(dirproj,2);
    pts = dirproj'*data;
    z = zeros(1,n);
    h=plot(pts,z+3*i,'o','MarkerFaceColor','b','Markersize',5);
    hold on
    txt{i} = sprintf('Dir %d',i);
end
axis([-3 3 0 N+1]);
%ax1 = axes;
%set(ax1,'YTick',1:N,'YTickLabel',txt);

hold off

return

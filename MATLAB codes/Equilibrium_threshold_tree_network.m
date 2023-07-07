clc
clear

%% EQUILIBRIUM THRESHOLDS FOR A TREE NETWORK

% This script shows the equilibrium threshold for a tree network of type
% (2)<--(1)-->(3) with the following parameters:

R=20;                     % reward
mu=[1 2 3];               % vector of service rates
v=[0 1 1];                % vector of vertices and edges
p_2=linspace(0,1,101);    % probability of being routed to queue 2
C_2=linspace(0,12,7);   % cost for sojourn time at queue 2

% Then we set C_1=1 and C_3=12-C_2 such that C_1+C_2+C_3=13, and p_1=1 and
% p_3=1-p_2 suche that p_2+p_3=1.

K=zeros(length(p_2),length(C_2));
for i=1:length(p_2)
    for j=1:length(C_2)
        p=[1 p_2(i) 1-p_2(i)];
        C=[1 C_2(j) 12-C_2(j)];
        K(i,j)=threshold(R,v,p,mu,C);
    end
end

figure
for i=1:length(C_2)
    plot(p_2,K(:,i),'LineWidth',2);
    hold on
end
xlabel('p_{12}');
ylabel('K      ',"Rotation",0);
legend("C_2= " + C_2(1),"C_2= " + C_2(2),"C_2= " + C_2(3), ...
        "C_2= " + C_2(4), "C_2= " + C_2(5),"C_2= " + C_2(6), ...
        "C_2= " + C_2(7), 'Location','southwest');
title('Equilibrium threshold for a tree network - 2D plot');
grid on
x0=800;
y0=200;
width=600;
height=500;
set(gcf,'position',[x0,y0,width,height]);

figure
surf(p_2,C_2,K');
xlabel('p_{12}');
ylabel('C_2');
zlabel('K      ',"Rotation",0);
% colorbar;
title('Equilibrium threshold for a tree network - 3D plot');
grid on
x0=100;
y0=200;
width=600;
height=500;
set(gcf,'position',[x0,y0,width,height]);

% The function threshold gives the equilibrium threshold of a tree network
% with parameters R,v,p,mu,C.

function y=threshold(R,v,p,mu,C)
k=0;
while P_tree_network(k,R,v,p,mu,C)>=0
    k=k+1;
end
y=k;
end
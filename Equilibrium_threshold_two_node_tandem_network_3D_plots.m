clc
clear

%% EQUILIBRIUM THRESHOLDS FOR A TWO-NODE TANDEM NETWORK - 3D PLOTS

% This script gives the equilibrium threshold for a two-node tandem network
% as the service rates mu_1 and mu_2 vary in [1:70] in three different
% cases: C1=1 and C2=2, C1=2 and C2=1, C1=1.5 and C2=1.5.

C1=[1 2 1.5];
C2=[2 1 1.5];
x=[100 550 1000];
for k=1:3
R=6;         % reward
C_1=C1(k);   % cost for staying at node 1 per unit of time
C_2=C2(k);   % cost for staying at node 2 per unit of time
l=70;
mu_1=1:l;    % service rate at queue 1
mu_2=1:l;    % service rate at queue 2
K=zeros(length(mu_1),length(mu_2));
for i=1:length(mu_1)
    for j=1:length(mu_2)
        K(i,j)=threshold(mu_1(i),mu_2(j),R,C_1,C_2);
    end
end

figure
surf(K);
xlabel('\mu_2');
ylabel('\mu_1');
zlabel('K ',"Rotation",0);
str=sprintf('Equilibrium threshold for C_1=%1.1f and C_2=%1.1f',C_1,C_2);
title(str);
x0=x(k);
y0=300;
width=400;
height=320;
set(gcf,'position',[x0,y0,width,height]);
end

% The function threshold gives the equilibrium threshold of a two-node
% tandem network with parameters mu_1, mu_2, R, C_1 and C_2.

function y=threshold(mu_1,mu_2,R,C_1,C_2)
k=0;
while P_two_node_tandem_network(k,R,mu_1,mu_2,C_1,C_2)>=0
    k=k+1;
end
y=k;
end

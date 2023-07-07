clc
clear

%% EQUILIBRIUM THRESHOLDS FOR A TWO-NODE TANDEM NETWORK - 2D PLOTS

% This script gives the equilibrium threshold for a two-node tandem network
% as the service rates mu_1 and mu_2 vary in from 1 to 70 in three 
% different cases: C1=1 and C2=2, C1=2 and C2=1, C1=1.5 and C2=1.5.

C1=[1 2 1.5];
C2=[2 1 1.5];
for k=1:3
R=6;         % reward
C_1=C1(k);   % cost for staying at node 1 per unit of time
C_2=C2(k);   % cost for staying at node 2 per unit of time
l=70;
mu_1=10:10:l;    % service rate at queue 1
mu_2=0.5:1:l;    % service rate at queue 2
K=zeros(length(mu_1),length(mu_2));
for i=1:length(mu_1)
    for j=1:length(mu_2)
        K(i,j)=threshold(mu_1(i),mu_2(j),R,C_1,C_2);
    end
end

figure
for i=1:length(mu_1)
    plot(mu_2,K(i,:),'LineWidth',2);
    hold on
end
xlabel('\mu_2');
ylabel('K      ',"Rotation",0);
legend("\mu_1= " + mu_1(1),"\mu_1= " + mu_1(2),"\mu_1= " + mu_1(3), ...
        "\mu_1= " + mu_1(4), "\mu_1= " + mu_1(5),"\mu_1= " + mu_1(6), ...
        "\mu_1= " + mu_1(7), 'Location','northwest');
str=sprintf('Equilibrium threshold for C_1=%1.1f and C_2=%1.1f',C_1,C_2);
title(str);
grid on;
x0=350;
y0=100;
width=800;
height=600;
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
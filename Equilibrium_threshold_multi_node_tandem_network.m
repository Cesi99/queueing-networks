clc
clear

%% EQUILIBRIUM THRESHOLDS FOR A THREE-NODE TANDEM NETWORK

% This script shows the equilibrium threshold for a three-node tandem 
% network with the following parameters:

R=9;         % reward
C=[1 1 1];   % costs for sojourn time
l=16;
mu_1=4:4:l;  % service rate at queue 1
mu_2=4:4:l;  % service rate at queue 2
mu_3=1:l;    % service rate at queue 3
K=zeros(length(mu_2),length(mu_3),length(mu_1));
for k=1:length(mu_1)
    for i=1:length(mu_2)
        for j=1:length(mu_3)
            mu=[mu_1(k) mu_2(i) mu_3(j)];
            K(i,j,k)=threshold(R,mu,C);
        end
    end
end

figure
for k=1:length(mu_1)
    subplot(2,2,k);
    plot(mu_3,K(1,:,k))
    hold on
    for i=1:length(mu_2)-1
        plot(mu_3,K(i+1,:,k))
    end
    xlabel('\mu_3');
    ylabel('K    ','rotation',0);
    legend("\mu_2= " + mu_2(1),"\mu_2= " + mu_2(2),"\mu_2= " + mu_2(3), ...
        "\mu_2= " + mu_2(4),'Location','northwest');
    title("for \mu_1= " + mu_1(k));
    ylim([0,max(max(max(K)))+5]);
end
x0=100;
y0=70;
width=1100;
height=700;
set(gcf,'position',[x0,y0,width,height]);

% The function threshold gives the equilibrium threshold of a three-network
% tandem network with parameters mu=[mu_1,mu_2,mu_3], C=[C_1,C_2,C_3], R.

function y=threshold(R,mu,C)
k=0;
while P_multi_node_tandem_network(k,R,mu,C)>=0
    k=k+1;
end
y=k;
end


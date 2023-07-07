clc
clear

%% COMPARISON BETWEEN TANDEM NETWORK AND TREE NETWORK

% In this script we compare two model: model A, which is a two-node tandem 
% network with service rates at queue 1 and queue 2 equal to mu and 2*mu, 
% respectively; model B, which is a tree network with 3 nodes, each of
% which has service rate equal to mu, and the nonzero transition 
% probabilities equal to p_12=1/2 and p_13=1/2

% k is the number of customer in the system that the tagged customer 
% observes at her arrival;
% R is the reward that a customer gets to join the system;
% C is the cost for sojourn time at any queue.

% Figure 1 compare the expected profit functions of the two models as k 
% varies, while Figure 2 compare the equilibrium thresholds of the two
% models as mu varies.

%% EXPECTED PROFIT FUNCTIONS

C=1;
mu=1;
R=6;

% f is the expected profit function of model A and g is the expected
% profit function of g

f=@(k) R-C/mu*(k+1).*(2.*(k+1)+2.^(-(k+1)))./(2*k+2.^(-k));
g=@(k) R-C/mu*(k+1).*(2.^(k+2)-1)./(2.^(k+2)-2);

int=0:10;

figure
scatter(int,f(int),'filled')
hold on
scatter(int,g(int),'filled')
grid on
xlabel('k');
ylabel('P(k)      ',"Rotation",0);
legend('Model A','Model B');
title('Comparison of the expected profit functions');
x0=100;
y0=200;
width=650;
height=500;
set(gcf,'position',[x0,y0,width,height]);

%% EQUILIBRIUM THRESHOLDS

C=1;
R=6;
f=@(k,mu) R-C/mu*(k+1).*(2.*(k+1)+2.^(-(k+1)))./(2*k+2.^(-k));
g=@(k,mu) R-C/mu*(k+1).*(2.^(k+2)-1)./(2.^(k+2)-2);

l=10;
K_A=zeros(1,l);
K_B=zeros(1,l);
for i=1:l
    mu=i;
    k=2;
    kk=2;
    while f(k,mu)>=0
        k=k+1;
    end
    while g(kk,mu)>=0
        kk=kk+1;
    end
    K_A(i)=k;
    K_B(i)=kk;
end

figure
scatter(1:l,K_A,'filled')
hold on
scatter(1:l,K_B,'filled')
grid on
xlabel('\mu');
ylabel('K      ',"Rotation",0);
legend('Model A','Model B','Location','northwest');
title('Comparison of the equilibrium thresholds');
x0=800;
y0=200;
width=650;
height=500;
set(gcf,'position',[x0,y0,width,height]);

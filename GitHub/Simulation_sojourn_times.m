clc
clear

%% SIMULATION OF SOJOURN TIMES IN A TWO-NODE TANDEM NETWORK

% This is a simulation of the sojourn time spent at queue 1, queue 2 and
% at the system, respectively, where the service rate are mu1 and mu2, and 
% the initial state is (n1,n2). We repeat the simulation n times, compute 
% the mean of the sojourn times and compare it with the theoretical result.  

mu1=1;
mu2=2;
n1=10;
n2=5;

n=500;
t1=zeros(1,n);
t2=zeros(1,n);
for i=1:n
    [y1,y2,y3]=Time(mu1,mu2,n1,n2);
    t1(i)=y1;
    t2(i)=y2;
end

mean_t1=mean(t1);
theoretical_t1=n1/mu1;
mean_t2=mean(t2);
theoretical_t2=T_2(n1,n2,mu1,mu2);

figure
plot(t1)
hold on
plot(1:n,mean_t1*ones(1,n))
plot(1:n,theoretical_t1*ones(1,n))
ylim([min(t1)-1,max(t1)+1])
xlabel('Iteration number')
ylabel('Sojourn time')
legend('Simulations','Mean of the simulations','Theoretical result')
title('Sojourn time at queue 1');
x0=100;
y0=200;
width=650;
height=500;
set(gcf,'position',[x0,y0,width,height]);

figure
plot(t2)
hold on
plot(1:n,mean_t2*ones(1,n))
plot(1:n,theoretical_t2*ones(1,n))
ylim([min(t2)-0.5,max(t2)+0.5])
xlabel('Iteration number')
ylabel('Sojourn time')
legend('Simulations','Mean of the simulations','Theoretical result')
title('Sojourn time at queue 2');
x0=800;
y0=200;
width=650;
height=500;
set(gcf,'position',[x0,y0,width,height]);

% The function Time compute the sojourn time spent at queue 1, queue 2 and
% at the system, respectively, given the service rates mu1 and mu2, and the
% initial state (n1,n2).

function [y1,y2,y3]=Time(mu1,mu2,n1,n2)

t=0;
tt=zeros(1,1);
count=1;
v=zeros(2,1);
v(:,1)=[n1;n2];

while n1>0 || n2>0
    b=exprnd(1/mu1);
    c=exprnd(1/mu2);
    if n2==0
        dt=b;
            n1=n1-1;
            n2=n2+1;
    elseif n1==0
        dt=c;
        n2=n2-1;
    else
        dt=min(b,c);
        if b==dt
            n1=n1-1;
            n2=n2+1;
        else
            n2=n2-1;
        end
    end
    t=t+dt;
    count=count+1;
    v(:,count)=[n1;n2];
    tt(1,count)=t;
    if n1==0 && v(1,count-1)>0
        Time1=t;
    end
end

Time_tot=t;
Time2=Time_tot-Time1;
y1=Time1;
y2=Time2;
y3=Time_tot;

end

% The function T_2 represent the theoretical sojourn time at queue 2 for a
% joining customer that observes state (n,m) at her arrival. The service
% rate at queue 1 and queue 2 are mu_1 and mu_2, respectively

function y=T_2(n,m,mu_1,mu_2)

if n==0 
    y=m/mu_2;
elseif m==0
    y=T_2(n-1,1,mu_1,mu_2);
else
    y=(mu_1/(mu_1+mu_2))*T_2(n-1,m+1,mu_1,mu_2)+(mu_2/(mu_1+mu_2))*T_2(n,m-1,mu_1,mu_2);
end

end

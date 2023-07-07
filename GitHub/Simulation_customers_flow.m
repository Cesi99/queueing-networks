clc
clear

%% SIMULATION OF CUSTOMERS'S FLOW IN A TWO-NODE TANDEM NETWORK

% This is a simulation of what happen in a two-node tandem network in a 
% time period T with arrival rate equal to lambda, service rates equal
% to mu1 and mu2 and initial state equal to (n1,n2)

% The graph represents the number of customers at queue 1 and queue 2 at
% each jump of the Markov chain

T=10;
lambda=1;
mu1=1;
mu2=1;
n1=0;
n2=0;
t=0;
tt=zeros(1,1);
count=1;
v=zeros(2,1);
v(:,1)=[n1;n2];
while t<T
    a=exprnd(1/lambda);
    b=exprnd(1/mu1);
    c=exprnd(1/mu2);
    if n1==0 && n2==0
        dt=a;
        n1=n1+1;
    elseif n1==0
        dt=min(a,c);
        if a==dt
            n1=n1+1;
        else
            n2=n2-1;
        end
    elseif n2==0
        dt=min(a,b);
        if a==dt
            n1=n1+1;
        else
            n1=n1-1;
            n2=n2+1;
        end
    else
        dt=min(min(a,b),c);
        if a==dt
            n1=n1+1;
        elseif b==dt
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
end

r=length(v);
v=v(:,1:r-1);
tt=tt(:,1:r-1);

figure
plot(tt,v(1,:),'linestyle','-','marker','.');
hold on
% plot(1:count,v(1,:),'.')
plot(tt,v(2,:),'linestyle','-','marker','.');
% scatter(1:count,v(2,:));
legend('Queue 1','Queue 2');
xlabel('Time');
ylabel('Number of customers');
xlim([0,T]);
ylim([0,max(max(v))+2]);
title('Simulation of customers'' flow in a two-node tandem network');
x0=100;
y0=200;
width=650;
height=500;
set(gcf,'position',[x0,y0,width,height]);


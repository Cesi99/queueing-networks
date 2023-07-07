clc
clear

%% SIMULATION OF CUSTOMER'S SOJOURN IN A TWO-NODE TANDEM NETWORK

% This is a simulation of the sojourn time of a customer, joining the
% system and occupying position (n1,n2). Lambda, mu1 and mu2 are the
% arrival rate, the service rate at queue 1 and service rate at queue 2
% respectively

% The graph represents the position of tagged customer at queue 1 and 
% queue 2 at each jump of the Markov chain

% Time1, Time2 and Time are the sojourn time of the tagged customer at
% queue 1, queue 2 and in the system respectively

lambda=1;
mu1=1;
mu2=2;
n1=6;
n2=12;
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
Time=t;
Time2=Time-Time1;

figure
plot(tt,v(1,:),'linestyle','-','marker','.');
hold on
plot(tt,v(2,:),'linestyle','-','marker','.');
legend('Queue 1','Queue 2');
xlabel('Time');
ylabel('Number of customers');
xlim([0,Time+0.5]);
ylim([0,max(max(v))+2]);
title('Simulation of customer''s sojourn in a two-node tandem network');
x0=100;
y0=200;
width=650;
height=500;
set(gcf,'position',[x0,y0,width,height]);


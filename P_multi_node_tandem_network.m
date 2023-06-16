function y=P_multi_node_tandem_network(k,R,mu,C)

% k is the number of customer in the system that 
% the tagged customer observes at her arrival

% R is the reward that a customer gets to join the system

% mu is the vector of service rates, where 1/mu(i)
% is the expected waiting time at queue i

% C is the vector of costs, where C(i) is the cost
% for unit of sojourn time at queue i

M=length(mu);

d=0;
m=matrix(k+1,M);
for i=1:size(m,2)
    b=C*m(:,i);
    for j=1:M
        b=b*((1/mu(j))^m(j,i));
    end
    d=d+b;
end

e=0;
mm=matrix(k,M);
for i=1:size(mm,2)
    a=1;
    for j=1:M
        a=a*(1/mu(j))^mm(j,i);
    end
    e=e+a;
end

y=R-d/e;

end

function y=matrix(k,M)

y=[];
if M==1
    y=k;
else
    for j=0:k
        m=matrix(k-j,M-1);
        a=size(m,2);
        if j == 0
            aa=0;
        else
            mm=matrix(k-j+1,M-1);
            aa=aa+size(mm,2);
        end
        for i=1:a
            y(:,i+aa)=[m(:,i);j];
        end
    end
end

end

function y=P_tree_network(k,R,v,p,mu,C)

% k is the number of customer in the system that 
% the tagged customer observes at her arrival

% R is the reward that a customer gets to join the system

% v is a vector that describes the tree: the set of 
% vertices is {1,2,3,...,length(v)} and v(i)=j means
% that node j is parent of node i and v(i)=0 means that
% node i is a root node

% p is the vector of routing probabilities associated 
% to edges: p(i) is the probability associated to 
% edge (v(i),i), if v(i)>0, and p(i)=1, if v(i)=0

% mu is the vector of service rates, where 1/mu(i)
% is the expected waiting time at queue i

% C is the vector of costs, where C(i) is the cost
% for unit of sojourn time at queue i

nu=length(v);   % nu is the number of vertices of the tree
q=zeros(1,nu);  % q(i) is the probability of reaching node 
                % i from the root node

for i=1:nu
    q(i)=1;
    j=i;
    while v(j) > 0
        q(i)=q(i)*p(j);
        j=v(j);
    end
end

d=0;
m=matrix(k+1,nu);
for i=1:size(m,2)
    b=C*m(:,i);
    for j=1:nu
        b=b*((q(j)/mu(j))^m(j,i));
    end
    d=d+b;
end

e=0;
mm=matrix(k,nu);
for i=1:size(mm,2)
    a=1;
    for j=1:nu
        a=a*(q(j)/mu(j))^mm(j,i);
    end
    e=e+a;
end

y=R-d/e;

end

% We create a matrix whose columns are all possible 
% vectors of length M, whose sum is equal to k

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

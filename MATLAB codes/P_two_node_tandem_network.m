function y=P_two_node_tandem_network(k,R,mu_1,mu_2,C_1,C_2)

% The function give the expected profit function of a two-node tandem 
% network, where:
% k is the number of customer in the system that the tagged customer 
% observes at her arrival;
% R is the reward that a customer gets to join the system;
% mu_1 and mu_2 are the service rates at queue 1 and 2, respectively;
% C_1 and C_2 are the costs for sojourn time at queue 1 and 2.

y=R-C_1*T(k,mu_1,mu_2)-C_2*T(k,mu_2,mu_1);

end

function y=T(k,mu_1,mu_2)

if mu_1==mu_2
    y=1/mu_1*(1+k/2);
else
    y=1/(mu_1-mu_2)-((k+1)/mu_1)*mu_2^(k+1)/(mu_1^(k+1)-mu_2^(k+1));
end

end

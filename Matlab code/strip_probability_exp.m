function[]=...
    strip_probability_exp(p, q, r, n, k, nrow)
% input function ------------------------------------------ 
%n = dimension of the matrix
%k = power of matrix
%p = forward probability 
%q = backward probabiity 
%r = returning probability 
%nrow = the row of the matrix
%----------------------------------------------------------------

% output function-----------------------------------------
% output answer a normalized probability 
% going from state nrow to all the other state 
% in kth step 
%----------------------------------------------------------------

% sample input  for JMM paper page 10 
%StripProbability_exp (1.2, 2.8, -4, 6, 5, 2) 


% inititalize running sum for standardization
fsum = 0;
% Initialize the array probability
prob_m_to_n = zeros(1,n);

% calculater each column of the array 
for i= 1:n
    % calculating probability for each column
    prob_m_to_n(i) = VB_exp(k, n, nrow, i, p, q, r);  
    % adding the probability to the running sum 
    fsum = fsum + prob_m_to_n(i);
end
% store the normalized probability column
ans_val  = prob_m_to_n / fsum

end
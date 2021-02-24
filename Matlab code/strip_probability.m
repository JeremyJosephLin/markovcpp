function[ans_val] = ...
    strip_probability( p, q, r, n, k, nrow)
% input function ------------------------------------------ 
% n = dimension of the matrix
% k = power of matrix
% p = forward probability 
% q = backward probabiity 
% r = returning probability 
% nrow = the row of the matrix
% ncol = the column of the matrix

% output function-----------------------------------------
% output answer a normalized probability 
% going from state nrow to all the other state 
% in kth step 
%----------------------------------------------------------------

   
% sample input  for JMM paper page 10 
%StripProbability (1/3, 1/2, 1/6,  8, 15, 3) 





% Intialization running sum
fsum=0;
% Initialzied array that store the probability
Prob_m_to_n = zeros(1,n);

for i= 1:n
    % Calculate the probability going from nrow to i 
    Prob_m_to_n(i) = VB(k, n, nrow, i, p, q, r)  ;  
    % Calculate running sum
    fsum = fsum + VB(k, n, nrow, i, p, q, r);
end

% standardize the column 
ans_val = Prob_m_to_n / fsum


end
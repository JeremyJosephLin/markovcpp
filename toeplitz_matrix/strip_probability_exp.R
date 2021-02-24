strip_probability_exp <- function(p, q, r, n, k, nrow){
  # input function ------------------------------------------
  # n = dimension of the matrix
  # k = power of matrix
  # p = forward probability
  # q = backward probabiity
  # r = returning probability
  # nrow = the row of the matrix
  #----------------------------------------------------------------
  
  # output function-----------------------------------------
  # output answer a normalized probability
  # going from state nrow to all the other state
  # in kth step
  #----------------------------------------------------------------
  
  # sample input  for JMM paper page 10
  # strip_probability_exp (1.2, 2.8, -4, 6, 5, 2)
  
  # example output
  # [1] 0.2387995 0.2805093 0.2275883 0.1479728
  # [5] 0.0772029 0.0279272
  
  # inititalize running sum for standardization
  fsum = 0;
  # Initialize the array probability
  prob_m_to_n = rep(0, n);
  
  # calculate each column of the array 
  for (i in 1:n){
    # calculating probability for each column
    prob_m_to_n[i] = VB_exp(k, n, nrow, i, p, q, r);  
    # adding the probability to the running sum 
    fsum = fsum + prob_m_to_n[i];
  }
  # store the normalized probability column
  ans_val  = prob_m_to_n / fsum
  return(ans_val)
}
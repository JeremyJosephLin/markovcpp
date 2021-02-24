VB_exp <- function(k,n,nrow,ncol,p,q,r){
  # This Function calculated the value of element of exponential n by n matrix to the kth power 
  # This is for Markov process exp^{Qt} where Q is nxn matrix
  # n = dimension of the matrix
  # k = power of matrix
  # p = forward probability 
  # q = backward probabiity 
  # r = returning probability 
  # nrow = the row of the matrix
  # ncol = the column of the matrix
  
  # Initialize lambda and A 
  lambda <- rep(0,n)
  A <- rep(0, n)
  
  for (nMatrix in 1:n){
    if ((2 * nMatrix / (n + 1)) %% 2 == 1){
      lambda[nMatrix] = r  
    }
    else{
      lambda[nMatrix] = 
        r + 2 * sqrt(q * p) * cos((pi * nMatrix) / (n+1))      
    } # end else
    
    A[nMatrix] = findAj(nrow, ncol, nMatrix, n, p, q, r)
  } #end for loop
  
  # Initialize running sum
  afSum = 0 ;
  # Calculate the element of the matrix 
  for (nSum in 1:n){
    afSum = A[nSum] * exp(lambda[nSum] * k) + afSum
  } 
return(afSum)
} # end function





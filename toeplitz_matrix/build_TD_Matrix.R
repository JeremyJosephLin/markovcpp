build_TD_Matrix <- function(n, a1, a2, b, c1, c2){
  # This function build a special nxn  tridiagonal matrix 
  #the sub diagonalis a1 and a2 alternately
  # diagonal is b 
  # super diagonal is c1 and c2 alternately 

  # Initialize Matrix A 
  A <- matrix(rep (0, n * n), n, n) 
  
  # fill in rows
  for (i in 1:n){
    # fill in columns 
    for (j in 1:n){
      
      # fill in diagonal 
      if(i == j){
        A[i, j] = b
      }#end if 
      
      # fill in super diagonal
      if (i == (j - 1)){
        if(i %% 2 == 1){
          A[i, j] = c1
        } 
        else{
          A[i, j] = c2
        }
      } # end super diagonal
      
      # fill in sub diagonal 
      if(i == j + 1){
        if(i %% 2 == 0){
          A[i, j] = a1
        }
        else{
          A[i, j] = a2
        }
      }
    }# end j
  }#end i 

  return(A)
}


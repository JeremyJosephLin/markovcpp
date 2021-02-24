findAj <- function(nrow, ncol, nMatrix, n, p, q, r){
  #This function Find the nrow, ncol element of jth matrix coefficient
  if ((nrow*nMatrix) %% (n+1) == 0 | (ncol*nMatrix) %% (n+1) ==0){
    Aj = 0
  }
 else{
   Aj = (2/(n + 1) * 
           (q*p^-1)^((nrow-ncol)/2) *
           sin((nrow * pi * nMatrix)/(n + 1) ) *
           sin( (ncol * pi * nMatrix)/(n + 1) ));
 }
               
}
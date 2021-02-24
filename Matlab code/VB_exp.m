function[afSum]=VB_exp(k,n,nrow,ncol,p,q,r)
%This Function calculated the value of element of exponential n by n matrix to the kth power 
%This is for Markov process exp^{Qt} where Q is nxn matrix
%n = dimension of the matrix
%k = power of matrix
%p = forward probability 
%q = backward probabiity 
%r = returning probability 
%nrow = the row of the matrix
%ncol = the column of the matrix
 for nMatrix = 1:n
       if mod(2*nMatrix/(n+1),2) ==1
        lambda(nMatrix) = r   ; 
       else
         lambda(nMatrix) = r +2*sqrt(q*p)*cos ((pi*nMatrix)/(n+1)) ;     
       end
        
        %fprintf(fid1,'Eigen value $\\lambda = %s $ have Coefficient Matrix :\\\\ \\\\ \n',latex(lambda))
        
              
               A(nMatrix) = findAj(nrow,ncol,nMatrix,n,p,q,r);
 end
       %fprintf(fid1,'\\scalebox{0.8}{ $  %s $ } \\\\ \\\\ \n',latex(simplify(B(:,:,nMatrix)))) 
       %fprintf(fid1,'\\vspace{\\baselineskip} \n')
 
 
 
 afSum = 0 ;
 for nSum = 1:n 
     afSum= A(nSum)*exp(lambda(nSum)*k)+afSum;
 end
 
end   

function[Aj]=findAj(nrow,ncol,nMatrix,n,p,q,r)
%This function Find the nrow, ncol element of jth matrix coefficient
 if mod(nrow*nMatrix,(n+1)) == 0 || mod(ncol*nMatrix,(n+1)) ==0
                Aj = 0;   
                %fprintf('nrow %d, ncol %d  sin value is 0 \n',nrow,ncol);
 else
               Aj = (2/(n+1)*(q*p^-1)^((nrow-ncol)/2)*sin((nrow*pi*nMatrix)/(n+1) )*sin( (ncol*pi*nMatrix)/(n+1) ));
               %fprintf('nrow %d, ncol %d sin value is not 0 \n',nrow,ncol)
 end
               
end
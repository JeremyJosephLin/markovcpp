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
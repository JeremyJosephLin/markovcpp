function[aaafAs] = Perron_v2 (n,aafR,aafLT)
% This function calculated the A_s matrix of 
%eigen value expression using Perron 
%input :
    %n = size of the matrix
    %aafR = nxn matrix, each column is right eigenvector of matrix M
    %aafLT = nxn matrixm each column is right eigenvector of M^T
%output 
    %aaafAs (:,:,s) represent A_s matrix 

%initialize aaafAs 
aaafAs= sym(zeros(n,n,n));
% Calculate the Left eigen value of M
aafL = aafLT' ;% Left eigen vectors
%Normalize LR
    k = diag(aafL*aafR);

    
%Find A matrix 
    for i = 1:n 
        aaafAs(:,:,i) =1/k(i)* aafR(:,i)*aafL(i,:);
        simplify(aaafAs);
    end 

end
function[aaafAs] = Perron (A)
% This function calculated the A_s matrix of 
%eigen value expression using Perron and  
%odd Kouachi method
[afLambda,aafR] =KouachiOdd_2(A);
[n,col] = size(A);
aaafAs= sym(zeros(n,n,n));
[afLeftLambda,aafLT] = KouachiOdd_2(A');
aafL = aafLT' ;% Left eigen vectors
%Normalize LR
    k = diag(aafL*aafR);

    
%Find A matrix 
    for i = 1:n 
        aaafAs(:,:,i) =1/k(i)* aafR(:,i)*aafL(i,:);
        simplify(aaafAs)
    end 

end
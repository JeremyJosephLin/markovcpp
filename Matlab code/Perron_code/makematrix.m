function[A] = makematrix()
%A3 = 3x3 matrix A
%A5 =5x5 matrix A
%aaafA3 [:,:,i] = A_i
t=2
[A3,aaafA3,afLambda3]=Aug_8_2020(3);

fsum = 0 ;
for i =1:3
    fsum = fsum +exp(afLambda3(i)*t)*aaafA3(:,:,i);
end
format short
double(fsum)
double(expm(A3*t))
end
function[A,aaafAs,afLambda] = Aug_8_2020(n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This function use Kouachi and Perron theorem to calculate
%nxn constant coefficient matrix for taking power of Matrix A

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A=[2,1,0;25,2,9;0,16,2]
bcheck = 1 % 1 means run check calculation for power 1
bPrint =0   %1 means print in latex
bNum = 1
%n = 3;   %size of matrix 
if bNum==1
a1= 16; %subdiagonal 1 
a2 = 20; %subdiagonal 2 
b = -21;   %diagonal 
c1= 1;  %superdiagonal 1
c2 = 5; %superdiagonal 2
end
%initialize variable 
if bNum==0 
syms a1 a2 c1 c2 b d1 d2 D1 D2 D3
%assume everything is positive real b/c probability
assume(a1,'positive')
assume(a2,'positive')
assume(c1,'positive')
assume(c2,'positive')
assume(b,'positive')
assume(d1,'positive')
assume(d1,'positive')
end
%build the kouachi matrix 
[A]=buildKMatrix(n,a1,a2,b,c1,c2)


[n,ncol] =size(A);

%apply Kouachi method to find eigen value and eigen vector
[afLambda,aafR] = KouachiOdd_2(A);

%apply Perron theorem to find the Constant matrix for eigen decomp power
%method
[aaafAs] = Perron (A) % each 3d matrix( each page represent  one A matrix
    
%check if it works 
if bcheck ==1
    power = 1;%not taking any power 
    aafSum = zeros(n,n);
        for i = 1:n
            aafSum  = aafSum +aaafAs(:,:,i)*afLambda(i)^power;
        end
    (aafSum)
end
if  bNum ==0
d1^4
assume(d1^2-d1*d2+d2^2,'positive')
aaafAs=simplify(aaafAs);
aaafAs= subs(aaafAs,a1*c1,d1^2);
aaafAs= subs(aaafAs,a2*c2,d2^2);
aaafAs= subs(aaafAs,sqrt(a1)*sqrt(c1),d1);
aaafAs= subs(aaafAs,sqrt(a2)*sqrt(c2),d2);
aaafAs = subs(aaafAs,d1^2+d1*d2+d2^2,D1);
aaafAs = subs(aaafAs,d1^2-d1*d2+d2^2,D2);
aaafAs = subs(aaafAs,d1^4+d1^2*d2^2+d2^4,D3);
aaafAs=simplify(aaafAs);
end

if bPrint==1
    fid1= fopen('check.tex','w+')
    achAuthor = "J"
    achTitle = "Kouachi "
    LatexHeader(achTitle,achAuthor,fid1)
    fprintf(fid1,'$ A = %s \\\\ \n$',latex(A))
    for i = 1 :n
     fprintf(fid1,'$ %s $ \\\\ \n',latex(simplify(afLambda(i))))
     fprintf(fid1,'\\scalebox{0.4}{ $  %s $ } \\\\ \\\\ \n',latex(simplify(aaafAs(:,:,i))));
     fprintf(fid1,'\\vspace{2cm}')
    end
    LatexFooter(fid1)
end

end
clc;
clearvars;
%a=[1 2 0];
%[i,j]=min(a)
%disp(i)
%disp(j)
%----------
%c(1,:)=mat/5;
%c
%{
x=rand(1,3)
y=rand(1,3)
d = sum((x-y).^2)
%}
partnmat=rand(5,3)

partnmat=normalize(partnmat.','norm',1);

partnmat=partnmat.'
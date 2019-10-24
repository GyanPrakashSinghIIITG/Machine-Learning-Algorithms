clc;
clearvars;
a=rand(20);
b=rand(20);
for i=1:20
    b(i)=(7-(5*a(i)))/3;
end   
plot(a,b,'color','r');
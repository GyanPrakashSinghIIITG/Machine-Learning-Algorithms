clc;
clearvars;
a=rand(25,30);
b=max(max(a));
disp(b);
c=min(min(a));
disp(c);
s=mean2(a);
m=s/(25*30);
disp(m);
sumtn=0;
for i=1:25
    for j=1:30
        t=a(i,j)-m;
        sumtn=sumtn+(t*t);
    end
end    
 sumtn=sumtn/(25*30);
 stnd=sqrt(sumtn);
 disp(stnd);
        
        


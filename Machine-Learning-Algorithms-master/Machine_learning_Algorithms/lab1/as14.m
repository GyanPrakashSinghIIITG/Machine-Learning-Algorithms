clc;
clearvars;
pi=3.14;
t=0:0.1:(2*pi);
a=sin(t);
plot(t,a,'color','r');
hold on;
b=cos(t);
plot(t,b,'color','b');
legend(a,b,'Location','northeast');
hold off;
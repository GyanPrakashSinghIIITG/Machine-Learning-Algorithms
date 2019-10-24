clc;
clearvars;
maxitr=1000;
ftr=2;
trnsamp=5;
hx=rand(1,trnsamp);
minerr=.001;
x0=1;             %bias%
a=.0001;          %alpha(learning rate)%
w=(rand(1,ftr+1)*0.3)-0.3;
fprintf('Randomly Assigned weights are \n');
disp(w);
fprintf('Given data file is \n');
Mat=dlmread('input.txt','',1,0);
disp(Mat);
itr=1;
err=1;
while itr <=maxitr && err > minerr
    err=0;
    for j=1:trnsamp
        sum=0;
        for k=1:ftr+1
            sum=sum+(w(1,k)*Mat(j,k));
        end
        hx(1,j)=sum;
        err=err+(.5*power((Mat(j,ftr+1)-hx(1,j)),2));
        %fprintf('hx is\n');
        %disp(hx(1,j));
        if j==trnsamp
            for m=1:ftr+1
                sum1=0;
                for t=1:trnsamp
                    sum1=sum1+((Mat(t,ftr+2)-hx(1,t))*Mat(t,m));
                   % disp(sum1);
                end
                w(1,m)=w(1,m)+(a*sum1);
                %disp(w(1,m));
               %fprintf('updated weight is %d\t',w(1,col));
            end
        end
    end
itr=itr+1;
err=abs(err);
end
%fprintf('error is %f \n',err);
%fprintf('Numbers of iteration taken is %d\n ',itr-1);
fprintf('weights are \n');
disp(w);
fprintf('Equation of line is \n Y= %f x0 + %f x1 + %f x2\n',w(1,1),w(1,2),w(1,3));



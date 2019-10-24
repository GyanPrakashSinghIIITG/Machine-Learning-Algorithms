clear all;
clc;
clearvars;
ftr=4;
cls=3;
alpha=.01;%learning rate
sigma=1;%gaussian neighbourhood
trnsamp=150;
maxsim=3;
mat=dlmread('irisdata.txt',',');
mat=[mat zeros(trnsamp,1)];
%disp(mat);
maxitr=10;
accuracy=0;
for sim=1:maxsim
    w=rand(cls,ftr);
    %fprintf('Randomized weight matrix is\n');
    %disp(w);
    for itr=1:maxitr
        for samp=1:trnsamp
            for i=1:3                  %competition_begin
                sum1=0;
                for j=1:4
                    sum1=sum1+((mat(samp,j)-w(i,j)).^2);
                    
                end
                D(i)=sqrt(sum1);
            end                     
            [melem,mindx]=min(D);
            for i=1:3                   %cooperation_begin
                d(i)=abs(i-mindx);
                t=(d(i).^2)/(2*sigma*sigma);
                h(i)=exp(-t);
            end
            %weight_updation
            for i=1:cls
                for j=1:ftr
                    w(i,j)=w(i,j)+(alpha*h(i)*(mat(samp,j)-w(i,j)));
                end
            end  
        end
    end
    %fprintf('updated weight matrix is\n');
    %disp(w)

    clsum1=0;
    clsum2=0;
    clsum3=0;

    for k=1:trnsamp
        ucld1=sqrt(((mat(k,1)-w(1,1)).^2)+((mat(k,2)-w(1,2)).^2)+((mat(k,3)-w(1,3)).^2)+((mat(k,4)-w(1,4)).^2));
        ucld2=sqrt(((mat(k,1)-w(2,1)).^2)+((mat(k,2)-w(2,2)).^2)+((mat(k,3)-w(2,3)).^2)+((mat(k,4)-w(2,4)).^2));
        ucld3=sqrt(((mat(k,1)-w(3,1)).^2)+((mat(k,2)-w(3,2)).^2)+((mat(k,3)-w(3,3)).^2)+((mat(k,4)-w(3,4)).^2));
        ucld=[ucld1 ucld2 ucld3];
        [ucl,indexat]=min(ucld);
        mat(k,ftr+2)=indexat;
        %mat(k,ftr+1);
    end
    C=confusionmat(mat(:,ftr+2),mat(:,ftr+1));
    acc=sum(max(C))*100/trnsamp;
    accuracy=accuracy+acc;
    %fprintf('\nAccuracy for %dth simulartion is %f %:\n',sim,acc);
end  
fprintf('\nfinal simulation Confusion matrix is:\n'); 
C
fprintf('\nAccuracy is %f %:\n',accuracy/maxsim); 
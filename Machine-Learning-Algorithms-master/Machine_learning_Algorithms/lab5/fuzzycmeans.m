clc;
clearvars;
m=2;%amout of fuzzification
cls=3;%number of clusters to be made
trnsamp=150;
maxitr=10;
mat=dlmread('irisdata.txt',',');
partnmat=rand(trnsamp,cls);
partnmat=normalize(partnmat.','norm',1);
partnmat=partnmat.';%normalized to 1 matrix
%disp(partnmat);
for itr=1:maxitr
    for samp=1:trnsamp        %for each pattern
        for j=1:cls
            sum1=0;
            sum2=0;
            for s=1:trnsamp
                sum1=sum1+((partnmat(s,j).^m)*mat(s,1:4));
                sum2=sum2+(partnmat(s,j).^m);
            end
            c(j,:)=sum1/sum2; %cluster centers calculation
        end
        for k=1:cls
            sum3=0;
            for k1=1:cls
                num=sum((mat(samp,1:4)-c(k,:)).^2).^0.5;
                denom=sum((mat(samp,1:4)-c(k1,:)).^2).^0.5;
                sum3=sum3+((num/denom).^(2/(m-1)));
            end
            partnmat(samp,k)=1/sum3;
        end
        partnmat(samp,:)=normalize(partnmat(samp,:),'norm',1);
    end
end
%fprintf('updated partition matrix is:\n');
%disp(partnmat);
for i=1:150
    [elem,maxindx(i,1)]=max(partnmat(i,:));
end
%disp(maxindx);
Conf=confusionmat(mat(:,5),maxindx);
fprintf('CONFUSION MATRIX is :\n');
disp(Conf);
acc=sum(max(Conf))*100/trnsamp;
fprintf('Accuracy is %f:\n',acc);
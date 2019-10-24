clc;
clearvars;
data=load('irisdata.txt');
[n,features]=size(data);
%data=data(randperm(150,150),:);
Y=data(:,features);
X=data(:,1:features-1);
k=3;
idx = kmeans(X,k);
C=confusionmat(Y,idx);
disp('K means accuracy is');
accuracy=0;
for i=1:k
    [m1,i1]=max(C(i,:));
    accuracy=accuracy+m1;
    C(i,:)=0;
    C(:,i1)=0;
end
disp(accuracy*100/n);
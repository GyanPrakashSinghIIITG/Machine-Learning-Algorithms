clc;
clearvars;
data=load('irisdata.txt');
[n,features]=size(data);
Y=data(:,features);
X=data(:,1:features-1);
k=3;
A=randperm(50,1);
A=[A 50+randperm(50,1);];
A=[A 100+randperm(50,1);];
assign=zeros(n,1);
centers=X(A,:);
prev=centers;
prev(1,1)=0;

while sum(sum(prev~=centers))
    c_no=zeros(k,1);
    clustersum=zeros(k,features-1);
    for i=1:n
        min=99999;
        for j=1:size(centers)
            d=sqrt(sum((X(i,:) - centers(j,:)) .^ 2));
            if d<min
                index=j;
                min=d;
            end    
        end
        %[m,index]=min(d);
        c_no(index)=c_no(index)+1;
        clustersum(index,:)=clustersum(index,:)+X(i,:);
        assign(i)=index;
    end 
    prev=centers;
    centers=clustersum./c_no;
end 
C=confusionmat(Y,assign)

accuracy=0;
for i=1:k
    [m1,i1]=max(C(i,:));
    accuracy=accuracy+m1;
    C(i,:)=0;
    C(:,i1)=0;
end
fprintf('Accuracy is :\n');
disp(accuracy*100/n);
clc;
load irisdata.txt 
DataSet=irisdata;
x=DataSet;
k=3;
n=150;
idx=randperm(150,k);
me=x(idx,:);
a=zeros(150,2);
for i=1:150
    d1=((x(i)-me(1))^2);
    d2=((x(i)-me(2))^2);
    d3=((x(i)-me(3))^2);
    if(d1<d2&&d1<d3)
        a(i,1)=1;
        a(i,2)=d1;
    elseif (d2<d1&&d2<d3)
        a(i,1)=2;
        a(i,2)=d2;
    else
        a(i,1)=3;
        a(i,2)=d3;
    end    
end
prevcost=1000000000;
cost=0;
for i=1:150
cost=cost+a(i,2);
end
%disp(cost)
itr=0;
prevcost=cost;
while( itr < 1 )
    for i1=1:k
       for j1=1:150
           prevcost=cost;
           temp=me(i1);
           me(i1)=x(j1);
            for i=1:150
                d1=((x(i)-me(1))^2);
                d2=((x(i)-me(2))^2);
                d3=((x(i)-me(3))^2);
                if(d1<d2&&d1<d3)
                    a(i,1)=1;
                    a(i,2)=d1;
                elseif (d2<d1&&d2<d3)
                    a(i,1)=2;
                    a(i,2)=d2;
                else
                    a(i,1)=3;
                    a(i,2)=d3;
                end    
            end
            cost=0;
            for i=1:n
            cost=cost+a(i,2);
            end
            %disp(oldcost);
            
            if(cost>prevcost)
                me(i1)=temp;
                cost=prevcost;                          
            end    
            disp(cost);
       end    
    end    
    itr=itr+1;
    
end 
disp(itr);
disp('Group1');
c1=0;
c2=0;
c3=0;
for i=1:150
    if(a(i,1)==1)
        disp(x(i,:));
        c1=c1+1;
    end    
end    
disp('Group2');
for i=1:150
    if(a(i,1)==2)
        disp(x(i,:));
        c2=c2+1;
    end    
end    
disp('Group3');
for i=1:150
    if(a(i,1)==3)
        disp(x(i,:));
        c3=c3+1;
    end    
end    
%disp(c1);
%disp(c2);
%disp(c3);

y=zeros(150,1);
for i=1:50
    y(i,1)=1;
end    
for j=51:100
    y(j,1)=2;
end
for j=101:150
    y(j,1)=3;
end    
%disp(y);
%disp(a);
%
conf=confusionmat(y,a(:,1));
disp(conf);
sums=0;
for i=1:3
    [c1,ind]=max(conf(i,:));
    sums=sums+c1;
    %disp(ind);
    %disp(' predicted class ');
    %disp(i);
    %disp('');
    for j=1:3
    conf(i,j)=-1;
    conf(j,ind)=-1;
    end
end
acc=sums*100/150;
fprintf('Acuuracy is \n');
disp(acc);



clc;
clearvars;

data = load('irisdata.txt');
x=data(:,1:4);
y=data(:,5);

trnprn=50; 
tstprn=100-trnprn;
trnsamp=size(x);
trnsamp_percls=(trnsamp(1)/3)*(trnprn/100);

for i=1:(trnsamp(1)/3)
    train_indices_1=randperm(trnsamp(1)/3,trnsamp_percls);
end
for i=((trnsamp(1)/3)+1):(2*(trnsamp(1)/3))
    train_indices_2=randperm(trnsamp(1)/3,trnsamp_percls);
end
train_indices_2=(trnsamp(1)/3)+train_indices_2;
for i=((2*(trnsamp(1)/3))+1):(3*(trnsamp(1)/3))
    train_indices_3=randperm(trnsamp(1)/3,trnsamp_percls);
end
train_indices_3=(2*(trnsamp(1)/3))+train_indices_3;
train_dataset=zeros(3*trnsamp_percls,trnsamp(2));
for i=1:trnsamp_percls
    train_dataset(i,:)=data(train_indices_1(i),1:4);
end
for i=1:trnsamp_percls
    train_dataset(trnsamp_percls+i,:)=data(train_indices_2(i),1:4);
end
for i=1:trnsamp_percls
    train_dataset((2*trnsamp_percls)+i,:)=data(train_indices_3(i),1:4);
end
%train_dataset
train_dataset_labels=zeros(3*trnsamp_percls,1);
for i=1:trnsamp_percls
    train_dataset_labels(i,1)=1;
end
for i=1:trnsamp_percls
    train_dataset_labels(trnsamp_percls+i,1)=2;
end
for i=1:trnsamp_percls
    train_dataset_labels((2*trnsamp_percls)+i,1)=3;
end
%train_dataset_labels

test_dataset=zeros(trnsamp(1)-3*trnsamp_percls,trnsamp(2));
train_indices=[train_indices_1 train_indices_2 train_indices_3];
t=1;
for i=1:trnsamp(1)
    flag=0;
    for j=1:3*trnsamp_percls
        if i== train_indices(j)
            flag=1;
        end
    end
    if flag==0
        test_dataset(t,:)=data(i,1:4);
        t=t+1;
    end
end

test_dataset_labels=zeros(trnsamp(1)-3*trnsamp_percls,1);
for i=1: (trnsamp(1)-(3*trnsamp_percls))/3
    test_dataset_labels(i)=1;
end
for i=((trnsamp(1)-(3*trnsamp_percls))/3)+1: 2*((trnsamp(1)-(3*trnsamp_percls))/3)
    test_dataset_labels(i)=2;
end
for i=2*((trnsamp(1)-(3*trnsamp_percls))/3)+1: 3*((trnsamp(1)-(3*trnsamp_percls))/3)
    test_dataset_labels(i)=3;
end
%test_dataset_labels
k1=train_dataset(1:trnsamp_percls,:);
probdist11= fitdist(k1(:,1),'Normal');
probdist12= fitdist(k1(:,2),'Normal');
probdist13= fitdist(k1(:,3),'Normal');
probdist14= fitdist(k1(:,4),'Normal');

k2=train_dataset(trnsamp_percls+1:2*trnsamp_percls,:);
probdist21= fitdist(k2(:,1),'Normal');
probdist22= fitdist(k2(:,2),'Normal');
probdist23= fitdist(k2(:,3),'Normal');
probdist24= fitdist(k2(:,4),'Normal');

k3=train_dataset(2*trnsamp_percls+1:3*trnsamp_percls,:);
probdist31= fitdist(k3(:,1),'Normal');
probdist32= fitdist(k3(:,2),'Normal');
probdist33= fitdist(k3(:,3),'Normal');
probdist34= fitdist(k3(:,4),'Normal');

labels=zeros(trnsamp(1)-3*trnsamp_percls,1);
for i=1:(trnsamp(1)-3*trnsamp_percls)
    
    n11= exp(  (-1/2) * ( (test_dataset(i,1)-probdist11.mu)*(test_dataset(i,1)-probdist11.mu)/((probdist11.sigma)*(probdist11.sigma)) ) )   ;
    d11= sqrt(2*3.14*(probdist11.sigma)*(probdist11.sigma));
    p11=n11/d11;
    n12= exp(  (-1/2) * ( (test_dataset(i,2)-probdist12.mu)*(test_dataset(i,2)-probdist12.mu)/((probdist12.sigma)*(probdist12.sigma)) ) )   ;
    d12= sqrt(2*3.14*(probdist12.sigma)*(probdist12.sigma));
    p12=n12/d12;
    n13= exp(  (-1/2) * ( (test_dataset(i,3)-probdist13.mu)*(test_dataset(i,3)-probdist13.mu)/((probdist13.sigma)*(probdist13.sigma)) ) )   ;
    d13= sqrt(2*3.14*(probdist13.sigma)*(probdist13.sigma));
    p13=n13/d13;
    n14= exp(  (-1/2) * ( (test_dataset(i,4)-probdist14.mu)*(test_dataset(i,4)-probdist14.mu)/((probdist14.sigma)*(probdist14.sigma)) ) )   ;
    d14= sqrt(2*3.14*(probdist14.sigma)*(probdist14.sigma));
    p14=n14/d14;
    
    n21= exp(  (-1/2) * ( (test_dataset(i,1)-probdist21.mu)*(test_dataset(i,1)-probdist21.mu)/((probdist21.sigma)*(probdist21.sigma)) ) )   ;
    d21= sqrt(2*3.14*(probdist21.sigma)*(probdist21.sigma));
    p21=n21/d21;
    n22= exp(  (-1/2) * ( (test_dataset(i,2)-probdist22.mu)*(test_dataset(i,2)-probdist22.mu)/((probdist22.sigma)*(probdist22.sigma)) ) )   ;
    d22= sqrt(2*3.14*(probdist22.sigma)*(probdist22.sigma));
    p22=n22/d22;
    n23= exp(  (-1/2) * ( (test_dataset(i,3)-probdist23.mu)*(test_dataset(i,3)-probdist23.mu)/((probdist23.sigma)*(probdist23.sigma)) ) )   ;
    d23= sqrt(2*3.14*(probdist23.sigma)*(probdist23.sigma));
    p23=n23/d23;
    n24= exp(  (-1/2) * ( (test_dataset(i,4)-probdist24.mu)*(test_dataset(i,4)-probdist24.mu)/((probdist24.sigma)*(probdist24.sigma)) ) )   ;
    d24= sqrt(2*3.14*(probdist24.sigma)*(probdist24.sigma));
    p24=n24/d24;
    
    n31= exp(  (-1/2) * ( (test_dataset(i,1)-probdist31.mu)*(test_dataset(i,1)-probdist31.mu)/((probdist31.sigma)*(probdist31.sigma)) ) )   ;
    d31= sqrt(2*3.14*(probdist31.sigma)*(probdist31.sigma));
    p31=n31/d31;
    n32= exp(  (-1/2) * ( (test_dataset(i,2)-probdist32.mu)*(test_dataset(i,2)-probdist32.mu)/((probdist32.sigma)*(probdist32.sigma)) ) )   ;
    d32= sqrt(2*3.14*(probdist32.sigma)*(probdist32.sigma));
    p32=n32/d32;
    n33= exp(  (-1/2) * ( (test_dataset(i,3)-probdist33.mu)*(test_dataset(i,3)-probdist33.mu)/((probdist33.sigma)*(probdist33.sigma)) ) )   ;
    d33= sqrt(2*3.14*(probdist33.sigma)*(probdist33.sigma));
    p33=n33/d33;
    n34= exp(  (-1/2) * ( (test_dataset(i,4)-probdist34.mu)*(test_dataset(i,4)-probdist34.mu)/((probdist34.sigma)*(probdist34.sigma)) ) )   ;
    d34= sqrt(2*3.14*(probdist34.sigma)*(probdist34.sigma));
    p34=n34/d34;
    
    p1=p11*p12*p13*p14;
    p2=p21*p22*p23*p24;
    p3=p31*p32*p33*p34;
    prob=[p1 p2 p3];
    [p,ind]=max(prob);
    labels(i,1)=ind;
end
%labels
conf=confusionmat(test_dataset_labels,labels);
conf
accuracy=(sum(max(conf))/sum(sum(conf)))*100;
fprintf('Accuracy is :\n');
disp(accuracy);
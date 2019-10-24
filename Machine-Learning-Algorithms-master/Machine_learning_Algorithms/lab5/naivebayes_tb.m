clc;
clearvars;
ftr=4;
trnsamp=150;
matrix=dlmread('irisdata.txt',',');
mat=matrix(:,1:ftr);
actlabel=matrix(:,ftr+1);
Mdl = fitcnb(mat,actlabel);

for i=1:trnsamp
    label(i,1)= predict(Mdl,mat(i,:));
end    
conf=confusionmat(actlabel,label(:,1))
accuracy=(sum(max(conf))*100)/trnsamp


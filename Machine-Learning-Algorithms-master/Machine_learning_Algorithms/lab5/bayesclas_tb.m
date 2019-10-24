clc;
clearvars;
ftr=4;
trnsamp=150;
matrix=dlmread('irisdatamod.txt',',',1);
features=matrix(:,1:ftr);
actlabel=matrix(:,ftr+1);
pd = fitdist(actlabel,'normal',irisdatamod.txt.x1,matrix(:,1));

%{
for i=1:trnsamp
    label(i,1)= predict(Mdl,mat(i,:));
end    
conf=confusionmat(actlabel,label(:,1))
accuracy=(sum(max(conf))*100)/trnsamp

%}
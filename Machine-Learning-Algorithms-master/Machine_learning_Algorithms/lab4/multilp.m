clc;
clearvars;
data1 = load('irisdata.txt');
x = data1(:, 1:4);    
y = data1(:, 5);

train_Y= full(ind2vec(data1(:,5)'));

data = [x, train_Y'];
simulation = 9;
itr = 1000;
learning_rate = 0.01;

mat = zeros(9,3);

for i =1:simulation

cv = cvpartition(size(data,1),'HoldOut',i/10);
id = cv.test;
dataTest = data(~id,:);
dataTrain = data(id,:);

dataTrain = dataTrain(randperm(size(dataTrain,1)),:);
dataTest = dataTest(randperm(size(dataTest,1)),:);

data_train_x = (dataTrain(:,1:4))';
data_train_y  = (dataTrain(:,5:7))';
data_test_x = (dataTest(:,1:4))';
data_test_y  = (dataTest(:,5:7))';


    
    
net = feedforwardnet(10,'traingd');
net.trainParam.lr = learning_rate;
net.trainParam.epochs = itr;
net.divideFcn='';
net = train(net,data_train_x,data_train_y);


pred = round(net(data_test_x));
pred1 = round(net(data_train_x));


count_train=0;

for j=1:length(pred1)
    if(pred1(j) == data_train_y(j) )
        count_train = count_train+1;
    end
end
acc = 100*(count_train/size((dataTrain),1));

mat(i,2) = acc;

count_test=0;

for j=1:length(pred)
    if(pred(j) == data_test_y(j) )
        count_test = count_test+1;
    end
end
acc1 = 100*(count_test/size((dataTest),1));

mat(i,3) = acc1;
mat(i,1) = i*0.1;

end

plot(mat(:,1),mat(:,(2:3)));

legend('Training Accuracy','Testing Accuracy','Location','SouthEast')
xlabel('Amount of randomly selected data')
ylabel('Accuracy')
mean_train = mean(mat(:,2))
mean_test = mean(mat(:,3))


function change = transformer(vector)
    index = 1;
    l = length(vector);
    change = [];
    while index<=l
        if vector(index)==1
            change = [change; 1, 0, 0];
        elseif vector(index)==2
            change = [change; 0, 1, 0];
        else
            change = [change; 0, 0, 1]; 
        end
        index=index+1;
    end
end

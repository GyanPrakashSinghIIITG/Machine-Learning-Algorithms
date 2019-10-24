clc;
clearvars;
data = load('iris_data.txt');
[m,n] = size(data);
features = data(:,1:n-1);
class = data(:,end);
mean_accuracy = [];
table = [];
for k = 1:3
     acc = [];
     accuracy = [];
     for simulations = 1:2
          r1 = randperm(50);
          r2 = 50 + randperm(50);
          r3 = 100 + randperm(50);
          train = [];
          test = [];

          for i = 1:5*k
               a = data(r1(i),:);
               train = [train;a];
          end


          for i = 1:5*k
               a = data(r2(i),:);
               train = [train;a];
          end


          for i = 1:5*k
               a = data(r3(i),:);
               train = [train;a];
          end

          for i = 5*k+1:50
               a = data(r1(i),:);
               test = [test;a];
          end

          for i = 5*k+1:50
               a = data(r2(i),:);
               test = [test;a];
          end

          for i = 5*k+1:50
               a = data(r3(i),:);
               test = [test;a];
          end
     %disp(train);
     %disp(test);
          ab = ones(15*k,1);
          bc = ones(150-(15*k),1);
          train = horzcat(ab,train);
          test = horzcat(bc,test);

%disp(size(train));
%disp(size(test));

          w = ones(5,3);
          w = w*0.1;
          counter = 0;
          test_counter = 0;
          total = 0;
          test_total = 0;
          cl = ones(15*k,3);
          test_cl = ones(150-(15*k),3);
          dl = ones(15*k,3);
          test_dl = ones(150-(15*k),3);
          temp = zeros(5,3);
          per = 5;
          classes = 3;

          for i=1:15*k
               if(train(i,6)==1)
                    cl(i,2) = 0;
                    cl(i,3) = 0;
               end
               if(train(i,6)==2)
                    cl(i,1) = 0;
                    cl(i,3) = 0;
               end
               if(train(i,6)==3)
                    cl(i,2) = 0;
                    cl(i,1) = 0;
               end
          end

          train = train(:,1:end-1);


          alpha = 0.1;

          for j= 1:1000
               for i = 1:15*k
                    hx = train * w;
                    g = zeros(size(hx));
                    g = 1.0 ./ ( 1.0 + 2.72.^(-hx));
                    gx = cl - g;
                    temp(:,1) = w(:,1) + ((alpha * (1/(15*k)) * gx(i,1)) .* train(i,:))';
                    temp(:,2) = w(:,2) + ((alpha * (1/(15*k)) * gx(i,2)) .* train(i,:))';
                    temp(:,3) = w(:,3) + ((alpha * (1/(15*k)) * gx(i,3)) .* train(i,:))';
                    w = temp;
               end
          end

          variable = train * w;
          for i = 1:15*k
               for j = 1:3
                    if (variable(i,j)>=0)
                         dl(i,j) = 1;
                    end
                    if (variable(i,j)<=0)
                         dl(i,j) = 0;
                    end
               end
          end

          for i = 1:15*k
               for j = 1:3
                    if (cl(i,j)==dl(i,j))
                         counter = counter + 1;
                    end
               total = total + 1;
               end
          end

          train_accuracy = (counter/total)*100;
     %disp(train_accuracy);
%disp(size(test));
%disp(test);
          for i=1:150-(15*k)
               if(test(i,6)==1)
                    test_cl(i,2) = 0;
                    test_cl(i,3) = 0;
               end
               if(test(i,6)==2)
                    test_cl(i,1) = 0;
                    test_cl(i,3) = 0;
               end
               if(test(i,6)==3)
                    test_cl(i,2) = 0;
                    test_cl(i,1) = 0;
               end
          end

          test = test(:,1:end-1);

          test_variable = test * w;

          for i = 1:150-(15*k)
               for j = 1:3
                    if (test_variable(i,j)>=0)
                         test_dl(i,j) = 1;
                    end
                    if (test_variable(i,j)<=0)
                         test_dl(i,j) = 0;
                    end
               end
          end
          for i = 1:150-(15*k)
               for j = 1:3
                    if (test_cl(i,j)==test_dl(i,j))
                         test_counter = test_counter + 1;
                    end
                    test_total = test_total + 1;
               end
          end

          test_accuracy = (test_counter/test_total)*100;
     %disp(test_accuracy);
     
          acc = [train_accuracy,test_accuracy];
          accuracy = [accuracy;acc];
     end

     mean_accuracy = [10*k,mean(accuracy)];
     table = [table;mean_accuracy];
     %disp(mean_accuracy);
end

%disp(size(table));
disp(table);
          
x = table(:,1);
y1 = table(:,2);
plot(x,y1,'r')
hold on
y2 = table(:,3);
plot(x,y2,'b')
legend('Training Accuracy','Testing Accuracy')
xlabel('Amount of randomly selected training data')
ylabel('Accuracy')
hold off
csvwrite('myFile.txt',table)
type('myFile.txt')
                   
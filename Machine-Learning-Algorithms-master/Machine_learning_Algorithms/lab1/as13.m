clc;
clearvars;
a=rand(4,6);
norm_a=a/max(max(a));
for i=1:4
    for j=1:6
        if (norm_a(i,j)< 0.2)
            norm_a(i,j)=0;
        elseif (norm_a(i,j)> 0.8)
                  norm_a(i,j)=1;
        end
     end
end   
disp(norm_a);

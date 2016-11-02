function [cidx,value] = pca(data)

[M,N] = size(data);
m2 = mean(data,2);
data = data - repmat(m2,1,N); %减去均值
covariance = 1 / (N-1) *data * data'; %求方差矩阵
[eigenvector,value] = eig(covariance); %方差矩阵的本征向量
value = diag(value);
[~,rindices] = sort(-1*value);%对本征向量进行排序，大的排前面
value = value(rindices);%同上
figure
plot(value);%观察本征值由大到小的变化状况

var = zeros(10,10);%横轴代表此时分类的聚类数目，纵轴代表PCA主特征

for class =1:1:10 %不同的聚类数目
%     figure;
    for remaindem =class:1:10 %选择不同数目的主特征
        remain = rindices(1:remaindem)';
        eigen = eigenvector(:,remain);
        newdata = (eigen' * data)';%得到变换后的数据
        [cidx,ctrs,distance,d] = kmeans(newdata,class,'Distance','cosine');%对变换后的数据进行Kmeans
        var(class,remaindem) = sum(distance);%计算每个类别与其中心点的距离
        
 if(remaindem ==5 && class == 3) %如果想要保留5个dimension 分两类，调整这里，并设断点，就可以考察结果。
     figure
         scatter3(newdata(cidx ==1,1),newdata(cidx ==1,2),newdata(cidx==1,3),'r');hold on;
         scatter3(newdata(cidx ==2,1),newdata(cidx ==2,2),newdata(cidx==2,3),'g');
         scatter3(newdata(cidx ==3,1),newdata(cidx ==3,3),newdata(cidx==3,3),'c');
         hold off;
end
    end
        
end

figure
for i =1:10 % 的主成分表示上，用C 均值方法对全部样本进行聚类分析，试验C=2、3、4、5、6 几种情况，这里我分析了1——10 的情况
    subplot(2,5,i);
    plot(var(:,i));
%plot(1:10,var);
end

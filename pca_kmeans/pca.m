function [cidx,value] = pca(data)

[M,N] = size(data);
m2 = mean(data,2);
data = data - repmat(m2,1,N); %��ȥ��ֵ
covariance = 1 / (N-1) *data * data'; %�󷽲����
[eigenvector,value] = eig(covariance); %�������ı�������
value = diag(value);
[~,rindices] = sort(-1*value);%�Ա��������������򣬴����ǰ��
value = value(rindices);%ͬ��
figure
plot(value);%�۲챾��ֵ�ɴ�С�ı仯״��

var = zeros(10,10);%��������ʱ����ľ�����Ŀ���������PCA������

for class =1:1:10 %��ͬ�ľ�����Ŀ
%     figure;
    for remaindem =class:1:10 %ѡ��ͬ��Ŀ��������
        remain = rindices(1:remaindem)';
        eigen = eigenvector(:,remain);
        newdata = (eigen' * data)';%�õ��任�������
        [cidx,ctrs,distance,d] = kmeans(newdata,class,'Distance','cosine');%�Ա任������ݽ���Kmeans
        var(class,remaindem) = sum(distance);%����ÿ������������ĵ�ľ���
        
 if(remaindem ==5 && class == 3) %�����Ҫ����5��dimension �����࣬�����������ϵ㣬�Ϳ��Կ�������
     figure
         scatter3(newdata(cidx ==1,1),newdata(cidx ==1,2),newdata(cidx==1,3),'r');hold on;
         scatter3(newdata(cidx ==2,1),newdata(cidx ==2,2),newdata(cidx==2,3),'g');
         scatter3(newdata(cidx ==3,1),newdata(cidx ==3,3),newdata(cidx==3,3),'c');
         hold off;
end
    end
        
end

figure
for i =1:10 % �����ɷֱ�ʾ�ϣ���C ��ֵ������ȫ���������о������������C=2��3��4��5��6 ��������������ҷ�����1����10 �����
    subplot(2,5,i);
    plot(var(:,i));
%plot(1:10,var);
end


%贝叶斯分类器
%trainr 和testr 分别代表训练正确率和测试正确率

function [trainr,testr] = bayesian_e(dem,womenset,menset,testset,testwomen,testmen,label,tlabel)

demn = size(dem,2); %表示使用几组特征
nclass = 2;%一共需要分几类
p = [0.5,0.5];
% 
D{1} = womenset(:,dem);
D{2} = menset(:,dem);
%womenset(nw,:)
%menset(nm,:)

%计算每个类别的均值和协方差
[aver,covo] = findpara(D,demn);

traindata = D{1};
traindata = [traindata;D{2}];

testingdata = testwomen(:,dem);
testingdata = [testingdata;testmen(:,dem)];

%归一化因子
for i =1:1:nclass
    f(i) = 1/((2* pi)^(demn/2)* sqrt(det(covo{i})));
end


%得到正态分布，并计算每个样本属于的类别，进行测试（训练集）
right = 0;
for i=1:1:size(traindata,1)
    for k =1:1:nclass
        ip(k) =p(k) * f(k)*exp(-0.5*(traindata(i,:)-aver{k}) *pinv(covo{k})...
            *(traindata(i,:)-aver{k})');
    end;
    [x,pre] = max(ip);
     if(pre == label(i))
         right = right +1;
     end
end
 testr = 1-right / size(traindata,1);
 fprintf('bayesian_e %d class, %d demension,the right rate is %d\n',nclass,demn,testr);
 
 %测试集测试
 tright = 0;
for i=1:1:size(testset,1)
    for k =1:1:nclass
        ip(k) =p(k) * f(k)*exp(-0.5*(testset(i,dem)-aver{k}) *pinv(covo{k})...
            *(testset(i,dem)-aver{k})');
    end;
    [x,pre] = max(ip);
     if(pre == tlabel(i))
         tright = tright +1;
     end
end
 trainr = 1- tright / size(testset,1);
 fprintf('bayesian_e %d class, %d demension,the right rate is %d\n',nclass,demn,trainr);
 
end
 
 
 
 

function errorrate=BP_learn()
ex=importdata('dataset3.txt');   %读入数据
vecnum=size(ex);
totalnum=vecnum(1);              %得到总人数
[X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,sort]=textread('dataset3.txt','%f%f%f%f%f%f%f%f%f%f%s',totalnum);
[input,minI,maxI]=premnmx([X1,X2,X3,X4,X5,X6,X7,X8,X9,X10]');
s=totalnum;
output=zeros(s,1);   %创立输出矩阵
for i=1:s
    if strcmp(sort(i),'M')   %确定预期输出值，男生的预期输出为1，女生的预期输出为0
        output(i)=1;
    else
        output(i)=0;
    end
        
end
net=newff(minmax(input),[5,1],{ 'logsig','logsig' },'traingdx') ; 
%设置训练参数
net.trainparam.show = 50 ;          
net.trainparam.epochs = 500;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;
net= train(net,input,output') ;   %训练net
[T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,SORT] = textread('dataset4.txt' , '%f%f%f%f%f%f%f%f%f%f%s',328);
testInput=tramnmx([T1,T2,T3,T4,T5,T6,T7,T8,T9,T10]', minI, maxI ) ;  %测试集数据的归一化（注意最大最小值矩阵利用的是样本的最大最小值矩阵）
Y= sim(net,testInput);  %Y为输出结果
[s1,s2]=size(SORT);
num= 0 ;
for i = 1:s1
     if strcmp(SORT(i),'M')
        if Y(i)>0.5
        num = num + 1 ; 
        else
        end
     else
         if Y(i)<0.5
           num= num + 1 ;
         else
         end
     end
    end

errorrate=1-num/s1;
end
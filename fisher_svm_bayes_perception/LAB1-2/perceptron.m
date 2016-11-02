X = dataset;
totalnum=size(A,1);              %得到总人数
[X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,sort]=textread('dataset3.txt','%f%f%f%f%f%f%f%f%f%f%s',totalnum);

%特征值归一化
[input,minI,maxI] = premnmx( [X1,X2,X3,X4,X5,X6,X7,X8,X9,X10 ]')  ;

%构造输出矩阵
s = length( class ) ;
output = zeros( s , 3  ) ;
for i = 1 : s 
   output( i , class( i )  ) = 1 ;
end

%创建神经网络
net = newff( minmax(input) , [10 3] , { 'logsig' 'purelin' } , 'traingdx' ) ; 

%设置训练参数
net.trainparam.show = 50 ;
net.trainparam.epochs = 500 ;
net.trainparam.goal = 0.01 ;
net.trainParam.lr = 0.01 ;

%开始训练
net = train( net, input , output' ) ;

%读取测试数据
[T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,SORT] = textread('dataset4.txt' , '%f%f%f%f%f%f%f%f%f%f%s',328);
[input,minI,maxI] = premnmx( [T1,T2,T3,T4,T5,T6,T7,T8,T9,T1 ]')  ;

%测试数据归一化
testInput = tramnmx ( [T1,T2,T3,T4,T5,T6,T7,T8,T9,T10]' , minI, maxI ) ;

%仿真
Y = sim( net , testInput ) 

%统计识别正确率
[s1 , s2] = size( Y ) ;
hitNum = 0 ;
for i = 1 : s2
    [m , Index] = max( Y( : ,  i ) ) ;
    if( Index  == c(i)   ) 
        hitNum = hitNum + 1 ; 
    end
end
sprintf('识别率是 %3.3f%%',100 * hitNum / s2 )


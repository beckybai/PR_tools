A = importdata('dataset3.txt');
datatrans % get the dataset,manset,womenset,label
%%
%f 可以变，不同的f表示保留的不同的特征数目。目前为3，筛选出3个最好的特征。
%不需要输入参数，直接运行即可。
%%
%归一化
dataseto = dataset ./ repmat(max(dataset),size(dataset,1),1);
menseto = menset ./ repmat(max(menset),size(menset,1),1);
womenseto = womenset ./repmat(max(womenset),size(womenset,1),1);

A = importdata('dataset4.txt');
testtrans% get the testset, testwomenset, testmenset,tlabel
testseto = testset ./ repmat(max(testset),size(testset,1),1);
testmeno = testmen ./ repmat(max(testmen),size(testmen,1),1);
testwomeno = testwomen ./repmat(max(testwomen),size(testwomen,1),1);


n = size(dataset,1);%total traning number
f = 3;% feature numbers

loss = zeros(1,10);


%calculate the judgement criterion
for i = 1:10
    %判据一："距离“
    loss(1,i) = innate_dist(menset,womenset,dataset,i);
    %判据二：”概率“
    loss2(1,i) = probility_dist(menset,womenset,dataset,i);
end

%get the best f features;
[s_loss,s_rank] = sort(loss);
[s_loss2,s_rank2] = sort(loss2,'descend');

s_rank(1:f) %输出”距离“特征组合数
right = bayesian_e(s_rank(1:f),womenset,menset,testset,testwomen,testmen,label,tlabel);
 fisher2(s_rank(1:f),womenset,menset,dataset,testset,testwomen,testmen,label,tlabel);
s_rank2(1:f)%输出”概率“特征组合数
right2 = bayesian_e(s_rank2(1:f),womenset,menset,testset,testwomen,testmen,label,tlabel);
 fisher2(s_rank2(1:f),womenset,menset,dataset,testset,testwomen,testmen,label,tlabel);




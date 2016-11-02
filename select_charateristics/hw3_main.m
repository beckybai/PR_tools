A = importdata('dataset3.txt');
datatrans % get the dataset,manset,womenset,label
%%
%f ���Ա䣬��ͬ��f��ʾ�����Ĳ�ͬ��������Ŀ��ĿǰΪ3��ɸѡ��3����õ�������
%����Ҫ���������ֱ�����м��ɡ�
%%
%��һ��
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
    %�о�һ��"���롰
    loss(1,i) = innate_dist(menset,womenset,dataset,i);
    %�оݶ��������ʡ�
    loss2(1,i) = probility_dist(menset,womenset,dataset,i);
end

%get the best f features;
[s_loss,s_rank] = sort(loss);
[s_loss2,s_rank2] = sort(loss2,'descend');

s_rank(1:f) %��������롰���������
right = bayesian_e(s_rank(1:f),womenset,menset,testset,testwomen,testmen,label,tlabel);
 fisher2(s_rank(1:f),womenset,menset,dataset,testset,testwomen,testmen,label,tlabel);
s_rank2(1:f)%��������ʡ����������
right2 = bayesian_e(s_rank2(1:f),womenset,menset,testset,testwomen,testmen,label,tlabel);
 fisher2(s_rank2(1:f),womenset,menset,dataset,testset,testwomen,testmen,label,tlabel);




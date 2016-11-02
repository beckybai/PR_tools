%s_rank
%一个用于测试的，暴力搜索。直接对若干种组合计算其正确率。直接运行即可（非实验要求）
f = 2;
c_rank = zeros(3,0);
eorign = s_rank(1,1);

for i = 1:1:f
    right = zeros(10,0);
    for j = i:10
        right(10-j+1,1) = bayesian_e([orign,x(1,j)],womenset,menset,testset,testwomen,testmen,label,tlabel);
    end
    [cx,cy]  = sort(right);
    orign = [orign,s_rank(cy(1))]; 
end

bayesian_e(orign,womenset,menset,testset,testwomen,testmen,label,tlabel);

%SBS
%直接运行即可，
%需要更改的f决定了最后剩下几个特征
%两种判据，目前是“基于散度”，如果要查看“基于间距”，将：%###：内容注释掉，并打开用%注释的。

f = 3;
c_rank = zeros(3,0);
eorign = [];
orign = zeros(f,1);

for i = 1:1:f
    right = zeros(10,0);
    orign = eorign;
    for j = i:10
        if(sum(orign == j)>0)
            continue
        end
        orign2 = [orign,j];
        right(j,1) = innate_dist(menset,womenset,dataset,orign2);
 %       right(j,1) = probility_dist(menset,womenset,dataset,orign2); %###
    end
     right(right ==0) = inf;
     [cx,cy]  = sort(right);
     eorign = [eorign,cy(1)]; 
%     [cx,cy]  = sort(right,'descend');%###
%     eorign = [eorign,cy(1)];%###
end
eorign 
bayesian_e(eorign,womenset,menset,testset,testwomen,testmen,label,tlabel);
 fisher2(s_rank(1:f),womenset,menset,dataset,testset,testwomen,testmen,label,tlabel);
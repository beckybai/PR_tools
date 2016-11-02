%基于距离的判断
function loss = innate_dist(manset,womenset,dataset,i)

    m = (manset(:,i)-repmat(mean(manset(:,i)),size(manset,1),1)); % 男性的样本减去平均值
    w = (womenset(:,i)-repmat(mean(womenset(:,i)),size(womenset,1),1));%女性样本减去平均值
    S_w =(trace(m * m'))/size(m,1) + (trace(w * w'))/size(w,1);%类内距离
    
    im = (mean(manset(:,i)))-mean(dataset(:,i));
    iw = (mean(womenset(:,i)))-mean(dataset(:,i));
    S_b =  im * im' + iw * iw';%类间距离
    loss = S_w / S_b;%类内距离/类内距离
end
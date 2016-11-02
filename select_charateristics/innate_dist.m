%���ھ�����ж�
function loss = innate_dist(manset,womenset,dataset,i)

    m = (manset(:,i)-repmat(mean(manset(:,i)),size(manset,1),1)); % ���Ե�������ȥƽ��ֵ
    w = (womenset(:,i)-repmat(mean(womenset(:,i)),size(womenset,1),1));%Ů��������ȥƽ��ֵ
    S_w =(trace(m * m'))/size(m,1) + (trace(w * w'))/size(w,1);%���ھ���
    
    im = (mean(manset(:,i)))-mean(dataset(:,i));
    iw = (mean(womenset(:,i)))-mean(dataset(:,i));
    S_b =  im * im' + iw * iw';%������
    loss = S_w / S_b;%���ھ���/���ھ���
end
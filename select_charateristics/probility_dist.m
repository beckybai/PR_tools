%���ڸ���֮ɢ���ж�

function loss = innate_dist(manset,womenset,dataset,i)
D{1} = womenset(:,i);%ѵ����Ů��
D{2} = manset(:,i);%ѵ��������

demn = size(i,1);
[aver,covo] = findpara(D,demn);
%ɢ�Ⱦ���
loss = 0.5 * trace(pinv(covo{1})*covo{2} +pinv(covo{2})*covo{1} - 2 * eye(size(covo{1}*covo{2},1)))...
    +0.5 * (aver{1}-aver{2})* (pinv(covo{1})+pinv(covo{2})) *(aver{1}-aver{2})';
end
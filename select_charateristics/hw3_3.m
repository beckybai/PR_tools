f =3;%��Ҫ��������Ŀ 

[x,y] = rankfeatures(dataset',label);%x��ʾ���������ĺû����е�����˳��x�ĵ�һ��Ԫ���������
w = x((1:f))'
bayesian_e(w,womenset,menset,testset,testwomen,testmen,label,tlabel);%���ñ�Ҷ˹�������Ի����������з���
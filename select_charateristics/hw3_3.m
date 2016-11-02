f =3;%需要特征的数目 

[x,y] = rankfeatures(dataset',label);%x表示根据特征的好坏排列的特征顺序，x的第一个元素性质最好
w = x((1:f))'
bayesian_e(w,womenset,menset,testset,testwomen,testmen,label,tlabel);%利用贝叶斯分类器对基于特征进行分类
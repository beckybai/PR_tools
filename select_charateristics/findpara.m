
%计算每个类别的均值和协方差，被bayesian_e.m使用
function [aver, covo] = findpara(D,demn)
for i=1:1:length(D)
    aver{i} = mean(D{i}(:,1:demn));
    covo{i} = cov(D{i}(:,1:demn));
    end
end
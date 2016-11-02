function [aver, covo] = findpara(D,demn)
for i=1:1:length(D)
    aver{i} = mean(D{i}(:,1:demn));
    covo{i} = cov(D{i}(:,1:demn));
    end
end
%对数据格式进行变换，处理原始读入数据
A = importdata('dataset3.txt');
dataset = zeros(size(A,1),10);
label = zeros(size(A,1),1);
for i =1:1:size(dataset,1)
        S = regexp(char(A(i,:)),'\t','split');
        for j =1:1:10
            dataset(i,j)= str2num(char(S(j)));
        end

        if (char(S(11)) == 'F'|| char(S(11))== 'f')
            label(i)=1;
        else
            label(i) =2;
        end
end

womenset = [];
menset =[];
for i=1:1:size(label,1)
    if(label(i) ==1)
        womenset =[womenset;dataset(i,:)];%女性
    else
        menset = [menset;dataset(i,:)];%男性
    end
    
end

% normlize factor = 2;
for i =1:10
dataset(:,i) = dataset(:,i)./repmat((norm(dataset(:,i),2)),size(dataset,1),1);
end

%normliaze factor =1
% for i =1:10
% dataset(:,i) = dataset(:,i)./repmat((norm(dataset(:,i),1)),size(dataset,1),1);
% end


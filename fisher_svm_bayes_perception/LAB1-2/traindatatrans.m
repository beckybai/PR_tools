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
        womenset =[womenset;dataset(i,:)];
    else
        menset = [menset;dataset(i,:)];
    end
    
end
testset = zeros(size(A,1),10);
tlabel = zeros(size(A,1),1);
for i =1:1:size(testset,1)
        S = regexp(char(A(i,:)),'\t','split');
        for j =1:1:10
            testset(i,j)= str2num(char(S(j)));
        end
        if (char(S(11)) == 'F'|| char(S(11))== 'f')
            tlabel(i)=1;
        else
            tlabel(i) =2;
        end
end

testwomen = [];
testmen =[];
for i=1:1:size(tlabel,1)
    if(tlabel(i) ==1)
        testwomen =[testwomen;testset(i,:)];
    else
        testmen = [testmen;testset(i,:)];
    end
end
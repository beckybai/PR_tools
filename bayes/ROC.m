%{
drawing the ROC line
Becky 10/8/2015
%}

clear;

%nearly the same process as train

%put the test data into a matrix
A = importdata('dataset1.txt');
dataset = zeros( size(A,1),size(A,2));

for i=1:1:size(dataset,1)
    S = regexp(char(A(i,:)),'\t','split');
    dataset(i,1) = str2num(char(S(1)));
    dataset(i,2) = str2num(char(S(2)));
    dataset(i,3) = char(S(3));
end

%Put the train data into a matrix
B = importdata('trainset.txt');
trainset = zeros( size(B,1),size(B,2));

for i=1:1:size(trainset,1)
    Q = regexp(char(B(i,:)),'\t','split');
    trainset(i,1) = str2num(char(Q(1)));
    trainset(i,2) = str2num(char(Q(2)));
    trainset(i,3) = char(Q(3));
end

%{
data pattern example:
(160 50 f
180 70 m
...)
%}

Woh = []; %woman height
Wow = []; %woman weight
Mah = []; %man height
Maw = []; %man weight

for i=1:size(trainset)
    if(char(trainset(i,3)) == 'm')
        Mah = [Mah , trainset(i,1)];
        Maw = [Maw , trainset(i,2)];   
    else
       Woh = [Woh , trainset(i,1)];
       Wow = [Wow , trainset(i,2)]; 
    end
end

pripm = size(Mah,2)/(size(Mah,2)+size(Woh,2));%predictional rate
pripw = 1 - pripm;

averm = [mean(Mah), mean(Maw)]; %average man height/weight
averw = [mean(Woh), mean(Wow)];

%in the following code:m represents the man; w represents the woman.
varim = cov(Mah,Maw); %cov matrix
am = 1/varim(1,1);% 1/variance of man'height
cm = 1/varim(2,2);% 1/variance of man'weight
rm = corrcoef(Mah,Maw);%coefficient of correlation
bm = rm(1,2)*sqrt(am*cm);
AM = sqrt((1-power(rm(1,2),2))*am*cm);%normalized factor

variw = cov(Woh,Wow);
aw = 1/variw(1,1);
cw = 1/variw(2,2);
rw = corrcoef(Woh,Wow);
bw = rw(1,2)*sqrt(aw*cw);
AW = sqrt((1-power(rw(1,2),2))*aw*cw);

px = zeros(1,500);
py = zeros(1,500);
num = 0;

%change the threshold from 0.01 to 5; I discuss this variable throughly in
%the text.
for time=0.01:0.01:5
    num = num +1;
    li=2*time;
    tcorrect = 0;
    TP = 0;
    FP = 0;
    FN = 0;
    TN = 0;

    for i=1:1:size(dataset,1)
        x = (dataset(i,1));
        y = (dataset(i,2));

        mrate = (1./AM)*exp(-1/(2*(1-power(rm(1,2),2)))*(am*power((x-averm(1)),2)-2*bm*(x-averm(1))*(y-averm(2))+cm*power((y-averm(2)),2)));
        wrate = (1./AW)*exp(-1/(2*(1-power(rw(1,2),2)))*(aw*power((x-averw(1)),2)-2*bw*(x-averw(1))*(y-averw(2))+cw*power((y-averw(2)),2)));

         if(mrate/wrate >= li)
            if (char(dataset(i,3))=='m'||char(dataset(i,3))=='M')
                tcorrect = tcorrect + 1;
                TP = TP + 1;
            else
                FP = FP + 1;
            end
        end
        if(mrate/wrate < li) 
            if (char(dataset(i,3))=='f'||char(dataset(i,3))=='F')
                tcorrect = tcorrect + 1;
                FN = FN + 1;
            else
                TN = TN + 1;
            end
        end
    end

    px(num) = FP/(TN+FP);
    py(num) = TP/(TP+FN);
    
end

 plot(px,py);
 axis([0 1,0,1]);






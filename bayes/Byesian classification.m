%{
Byesian classification
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

correct = 0;
for i=1:1:size(trainset,1)
    x = trainset(i,1);
    y = trainset(i,2);
    
    mrate = (1./AM)*exp(-1/(2*(1-power(rm(1,2),2)))*(am*power((x-averm(1)),2)-2*bm*(x-averm(1))*(y-averm(2))+cm*power((y-averm(2)),2)));
    wrate = (1./AW)*exp(-1/(2*(1-power(rw(1,2),2)))*(aw*power((x-averw(1)),2)-2*bw*(x-averw(1))*(y-averw(2))+cw*power((y-averw(2)),2)));
    
    %change the threshold for different situation to fit in your need
    
    %li = pripw/pripm; 
    %example:this the prediction number of woman div the prediction number of man
    
    li=2;
    % girl/boy =1/2=0.5
    
    
    %test the training set.
    if(mrate/wrate >= li)
        if (char(trainset(i,3))=='m')
            correct = correct + 1;
        end
    end
    if(mrate/wrate < li) 
        if (char(trainset(i,3))=='f')
            correct = correct + 1;
        end
    end
end

%plot the pic of two distributions
[x,y]=meshgrid(155:1:190,40:1:80);
z=(1./AM).*exp(-1/(2.*(1-power(rm(1,2),2))).*(am.*power((x-averm(1)),2)-2.*bm.*(x-averm(1)).*(y-averm(2))+cm.*power((y-averm(2)),2)));
z2 = (pripw./AW).*exp(-1/(2.*(1-power(rw(1,2),2))).*(aw.*power((x-averw(1)),2)-2.*bw.*(x-averw(1)).*(y-averw(2))+cw.*power((y-averw(2)),2)));
figure;plot3(x,y,z,'r',x,y,z2,'b');


%test the testing data
corrate1 = correct/size(trainset,1);
tcorrect = 0;
TP = 0;
FP = 0;
FN = 0;
TN = 0;


for i=1:1:size(dataset,1)
    x = (dataset(i,1));
    y = (dataset(i,2));
    
    %2d-guassian function
    mrate = (1./AM)*exp(-1/(2*(1-power(rm(1,2),2)))*(am*power((x-averm(1)),2)-2*bm*(x-averm(1))*(y-averm(2))+cm*power((y-averm(2)),2)));
    wrate = (1./AW)*exp(-1/(2*(1-power(rw(1,2),2)))*(aw*power((x-averw(1)),2)-2*bw*(x-averw(1))*(y-averw(2))+cw*power((y-averw(2)),2)));
 
     if(mrate/wrate >= li)
        if (char(dataset(i,3))=='m'||char(dataset(i,3))=='M')
            tcorrect = tcorrect + 1;
            TP = TP + 1;
        else
            FP = FP + 1;
            %dataset(i,1)
            %dataset(i,2)
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

corrate2 = tcorrect/size(dataset,1);
fprintf('the training correct rate is %f\n',corrate1);
fprintf('the testing correct rate is %f\n',corrate2);
fprintf('TP FP\n %f %f\n FN TN\n%f %f\n T F\n %f %f\n',TP,FP,FN,TN,TP/(TP+FN),FP/(TN+FP));






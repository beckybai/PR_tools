%{
Fisher classification
Becky 11/2/2015
%}

%nearly the same process as train
%put the test data into a matrix

%  nw = randint(1,10,[1,size(womenset,1)]);
%  nm = randint(1,10,[1,size(menset,1)]);
%  %nlabel = label(([nw,nm+size(womenset,1)]))

P_w = 0.5;
P_m = 0.5;

mean_wom = (mean(womenset))';
mean_men = (mean(menset))';

av_wom = repmat(mean(womenset),size(womenset,1),1);
av_men = repmat(mean(menset),size(menset,1),1);

cen_av_wom = womenset - av_wom;
cen_av_men = menset - av_men;

S = cen_av_wom' * cen_av_wom + cen_av_men' * cen_av_men;

w = pinv(S)*(mean_wom - mean_men);

a=[];
figure
for i = 1:1:size(womenset,1)
    a = [a,w' * (womenset(i,1:10))'];
    hold on;
end

scatter(zeros(1,size(a,2)),a,'b');

b=[];
for i = 1:1:size(menset,1)
    b = [b,w' * (menset(i,1:10))'];
    hold on;
end

scatter(zeros(1,size(b,2)),b,'y');

wn = 0; %woman number 
wtn = size(testwomen,1);

hn = 0; %man number
hs = size(testmen,1);

tn = 0; %total right number
ts = wtn +hs;

for i =1:1:size(testset,1)
    outy = w'*(testset(i,:)' - 0.5*mean_wom -0.5*mean_men);
    if outy > 0 
        if tlabel(i) == 1
            wn = wn +1;
            tn = tn +1;
        end
    else
        if outy <= 0
            if tlabel(i) ==2
                hn = hn + 1;
                tn = tn + 1;
            end
        end
    end
end

fprintf('women is %d, men is %d,the total is %d  \n',...
    wn/wtn,hn/hs,tn/ts);


wn = 0; %woman number 
wtn = size(womenset,1);

hn = 0; %man number
hs = size(menset,1);

tn = 0; %total right number
ts = wtn +hs;

for i =1:1:size(dataset,1)
    outy = w'*(dataset(i,:)' - 0.5*mean_wom -0.5*mean_men);
    if outy > 0 
        if label(i) == 1
            wn = wn +1;
            tn = tn +1;
        end
    else
        if outy <= 0
            if label(i) ==2
                hn = hn + 1;
                tn = tn + 1;
            end
        end
    end
end

fprintf('women is %d, men is %d,the total is %d  \n',...
    wn/wtn,hn/hs,tn/ts);




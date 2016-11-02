%{
Fisher classification
Becky 11/2/2015
%}

%nearly the same process as train
%put the test data into a matrix

P_w = 0.5;
P_m = 0.5;
womenset2 = womenset(:,3:2:5);
menset2 = menset(:,3:2:5);
mean_wom = (mean(womenset2))';
mean_men = (mean(menset2))';

av_wom = repmat(mean(womenset2),size(womenset2,1),1);
av_men = repmat(mean(menset2),size(menset2,1),1);

cen_av_wom = womenset2 - av_wom;
cen_av_men = menset2 - av_men;

S = cen_av_wom' * cen_av_wom + cen_av_men' * cen_av_men;

w = pinv(S)*(mean_wom - mean_men);

for i = 1:1:size(womenset2,1)
    a = [0,w' * (womenset2(i,:))'];
    plot(a,'bo','MarkerSize',10);
    hold on;
end

for i = 1:1:size(menset2,1)
    a = [0,w' * (menset2(i,:))'];
    plot(a,'rx','MarkerSize',5);
    hold on;
end

wn = 0; %woman number 
wtn = size(testwomen,1);

hn = 0; %man number
hs = size(testmen,1);

tn = 0; %total right number
ts = wtn +hs;

for i =1:1:size(testset,1)
    outy = w'*(testset(i,3:2:5)' - 0.5*mean_wom -0.5*mean_men);
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
wtn = size(womenset2,1);

hn = 0; %man number
hs = size(menset2,1);

tn = 0; %total right number
ts = wtn +hs;

for i =1:1:size(dataset,1)
    outy = w'*(dataset(i,3:2:5)' - 0.5*mean_wom -0.5*mean_men);
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




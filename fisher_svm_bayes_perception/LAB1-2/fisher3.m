%{
Fisher classification
Becky 11/2/2015
%}

%nearly the same process as train
%put the test data into a matrix

  nw = randint(1,10,[1,size(womenset,1)]);
  nm = randint(1,10,[1,size(menset,1)]);
%  %nlabel = label(([nw,nm+size(womenset3,1)]))
womenset3 = womenset(nw,:);
menset3 = menset(nm,:);
label3 = label([nw,nm+size(womenset,1)],:);
womenset3
menset3

P_w = 0.5;
P_m = 0.5;

mean_wom = (mean(womenset3))';
mean_men = (mean(menset3))';

av_wom = repmat(mean(womenset3),size(womenset3,1),1);
av_men = repmat(mean(menset3),size(menset3,1),1);

cen_av_wom = womenset3 - av_wom;
cen_av_men = menset3 - av_men;

S = cen_av_wom' * cen_av_wom + cen_av_men' * cen_av_men;

w = pinv(S)*(mean_wom - mean_men);

for i = 1:1:size(womenset3,1)
    a = [0,w' * (womenset3(i,:))'];
    plot(a,'bo','MarkerSize',10);
    hold on;
end

for i = 1:1:size(menset3,1)
    a = [0,w' * (menset3(i,:))'];
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
wtn = size(womenset3,1);

hn = 0; %man number
hs = size(menset3,1);

tn = 0; %total right number
ts = wtn +hs;

set =[womenset3;menset3];
for i =1:1:size(set,1)
    outy = w'*(set(i,:)' - 0.5*mean_wom -0.5*mean_men);
    if outy > 0 
        if label3(i) == 1
            wn = wn +1;
            tn = tn +1;
        end
    else
        if outy <= 0
            if label3(i) ==2
                hn = hn + 1;
                tn = tn + 1;
            end
        end
    end
end

fprintf('women is %d, men is %d,the total is %d  \n',...
    wn/wtn,hn/hs,tn/ts);




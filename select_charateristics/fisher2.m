%{
Fisher classification
Becky 11/2/2015
%}

%nearly the same process as train
%put the test data into a matrix
function   fisher2(dem,womenset,menset,dataset,testset,testwomen,testmen,label,tlabel)

P_w = 0.5;
P_m = 0.5;
womenset2 = womenset(:,dem);
menset2 = menset(:,dem);
mean_wom = (mean(womenset2))';
mean_men = (mean(menset2))';

av_wom = repmat(mean(womenset2),size(womenset2,1),1);
av_men = repmat(mean(menset2),size(menset2,1),1);

cen_av_wom = womenset2 - av_wom;
cen_av_men = menset2 - av_men;

S = cen_av_wom' * cen_av_wom + cen_av_men' * cen_av_men;

w = pinv(S)*(mean_wom - mean_men);

wn = 0; %woman number 
wtn = size(testwomen,1);

hn = 0; %man number
hs = size(testmen,1);

tn = 0; %total right number
ts = wtn +hs;

figure
hold on
for i =1:1:size(testset,1)
    outy = w'*(testset(i,dem)' - 0.5*mean_wom -0.5*mean_men);
    if outy > 0 
        if tlabel(i) == 1
             scatter(testset(i,2),testset(i,5),'r')
            wn = wn +1;
            tn = tn +1;
            else
            scatter(testset(i,2),testset(i,5),'y')
        end
    else
        if outy <= 0
            if tlabel(i) ==2
                 scatter(testset(i,2),testset(i,5),'b')
                hn = hn + 1;
                tn = tn + 1;
            else
                scatter(testset(i,2),testset(i,5),'y')
            end
        end
    end
end

fprintf('fisher,the testing rate is %d  \n',...
    1-tn/ts);


wn = 0; %woman number 
wtn = size(womenset2,1);

hn = 0; %man number
hs = size(menset2,1);

tn = 0; %total right number
ts = wtn +hs;

for i =1:1:size(dataset,1)
    outy = w'*(dataset(i,dem)' - 0.5*mean_wom -0.5*mean_men);
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

fprintf('fisher,training rate is %d  \n',...
    1-tn/ts);



end


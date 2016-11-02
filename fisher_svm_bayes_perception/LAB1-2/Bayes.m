
demn = 10; %表示使用几组数据
nclass = 2;%一共需要分几类
p = [0.5,0.5];
% 
  nw = randint(1,10,[1,size(womenset,1)]);
  nm = randint(1,10,[1,size(menset,1)]);
  nlabel = label(([nw,nm+size(womenset,1)]))

%nlabel = label;
D{1} = womenset(nw,:);
D{2} = menset(nm,:);
%D{1} = womenset(nw,2:3:5);
%D{2} = menset(nm,2:3:5);
womenset(nw,:)
menset(nm,:)

% D{3} = w3;
[aver,covo] = findpara(D,demn);
for i =1:1:2
covo{i} = covo{i}/100;
end
traindata = D{1};
traindata = [traindata;D{2}];

testingdata = testwomen(:,:);
testingdata = [testingdata;testmen(:,:)];

% traindata = [traindata;w3(:,1:demn)];
f = zeros(1,3);
% A= [1,2,1;5,3,2;0,0,0;1,0,0];
% for i = 1:1:4
%  for k =1:1:3    
%         HA(i,k) = (A(i,:)-aver{k}) *covo{k}^(-1)...
%             *(A(i,:)-aver{k})';
%  end
% end
for i =1:1:nclass
    f(i) = 1/((2* pi)^(demn/2)* sqrt(det(covo{i})));
end%归一化因子



right = 0;
for i=1:1:size(traindata,1)
    for k =1:1:nclass
        ip(k) =p(k) * f(k)*exp(-0.5*(traindata(i,:)-aver{k}) *covo{k}^(-1)...
            *(traindata(i,:)-aver{k})');
    end;
    [x,pre] = max(ip);
     if(pre == nlabel(i))
         right = right +1;
     end
end
 rightrate = right / size(traindata,1);
 fprintf('ttt %d class, %d demension,the right rate is %d\n',nclass,demn,rightrate);
 
 
 tright = 0;
for i=1:1:size(testset,1)
    for k =1:1:nclass
        ip(k) =p(k) * f(k)*exp(-0.5*(testset(i,:)-aver{k}) *covo{k}^(-1)...
            *(testset(i,:)-aver{k})');
    end;
    [x,pre] = max(ip);
     if(pre == tlabel(i))
         tright = tright +1;
     end
end
 tright = tright / size(testset,1);
 fprintf('ttt %d class, %d demension,the right rate is %d\n',nclass,demn,tright);
 
 
 
 
 
 

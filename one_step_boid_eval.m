df = [];lm = 5:5:60;lm = horzcat(1,lm);le = 62000;ala = 658;

%KL divergence for my approach
for i = 1:13
    %pa = xlsread('yuyu_mar040');
    %pa = ag1;
    %pa = ag1(1:62000,:);
    pa = uy;
    %pa = uy(1:62000,:);
    %pa = pa(1:36001,:);%select just ten hours
    pa = pa(1:le,:);%select just ten hours
    ld = 1:lm(i):length(pa);
    pa = pa(ld,:);
    %pa = diff(pa);%compute_veloity
    
    pa_gd  = csvread('alldata0404.csv');%load ground-truth
    pa_gd = pa_gd(ala:end,:);pa_gd = pa_gd(1:le,1:72);
    pa_gd = pa_gd(ld',:); 
    pa_gd = diff(pa_gd);
    %pa_gd = pa_gd(1:le,:);
    pa_gd = [pa_gd(:,3),pa_gd(:,39)];
    %pa_gd = pa_gd(ld,:); 
    a1 = pa;[a1,~] =    ksdensity(a1);
    a2 = pa_gd;[a2,~] = ksdensity(a2);
    
   
    kl = (a1+eps).* ((a1+eps)-log(a2+eps));
    kl1 = (a2+eps).* ((a2+eps)-log(a1+eps));
    kl = (kl(~isinf(kl)));
    kl = sum(kl(~isnan(kl)));
    kl1 = (kl1(~isinf(kl1)));
    kl1 = sum(kl1(~isnan(kl1)));
    dkl = 0.5*(kl+kl1);
    df = horzcat(df,dkl);
end
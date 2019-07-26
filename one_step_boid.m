%KL divergence for boids
dame=[];
for sheep  = 1:36
df = [];lm = 5:5:60;lm = horzcat(1,lm);da=[];at = sheep;
lm = 1;


for fa = 1:length(lm)
        ag1=[];ag11=[];
        bv = csvread('alldata0401.csv');bv = bv(:,1:72);
        ala = 657;
        le = 62000;
        %le = 10800;
        %ala = 10060;
  
        bv = bv(513:end,:);
        bvx = bv(:,1:36);bvy = bv(:,37:72);
        bg = [bvx(:,at),bvy(:,at)];
        bvx(:,at)=[];bvy(:,at)=[];
        ld = 1:lm(fa):length(bvx);
        bg = bg(ld',:);


        bx = bvx;by = bvy;
        bvx = bvx(1:end,:);bvx1 = bvx(ld',:); %x input
        bvy = bvy(1:end,:);bvy1 = bvy(ld',:); %y input
        bgv = diff(bg);%bgv = bgv(ld,:);  %velocity target
        avg_velox = (diff(bvx));avg_veloy = (diff(bvy));
        bg = bg(1:length(bg)-1,:);
        bvx1 = bvx1(1:length(bvx1)-1,:);
        bvy1 = bvy1(1:length(bvy1)-1,:);

        %avg_x1 = avg_velox(ld',:);avg_y1 = avg_veloy(ld',:);
        %centrox = mean(bvx,2);centroy = mean(bvy,2);
        avg_x1 = avg_velox;avg_y1 = avg_veloy;


        centrox = bvx;centroy = bvy;
        %cx1 = centrox(ld,:);
        %cy1 = centroy(ld,:);
        %bg = bg(2:end,:);bg = bg(ld',:);
        dd = sqrt((bg(:,1)-bvx1).^2 +  (bg(:,2)-bvy1).^2);
        ddg = sort(dd,2);
        ka = [];kad=[];


        for i = 1:length(ddg)
            for j = 1:15
                ka = horzcat(ka, find(dd(i,:)==ddg(i,j)) );
            end
            kad = vertcat(kad,ka(:,1:15));ka=[];
        end

        ccx=[];ccy=[];avx=[];avy=[];

        for i = 1:length(ddg)
            ucx = centrox(i,:);   ucy = centroy(i,:);
            ccx = vertcat(ccx,ucx(kad(i,:)));ccy = vertcat(ccy,ucy(kad(i,:)));
            ucx = avg_x1(i,:);   ucy = avg_y1(i,:);
            avx = vertcat(avx,ucx(kad(i,:)));avy = vertcat(avy,ucy(kad(i,:)));
        end
        
        lax = ccx;lay=ccy;
        ccx = mean(ccx,2);ccy = mean(ccy,2);avx = mean(avx,2);avy = mean(avy,2);
        %bvx = bvx(ld,:);bvy = bvy(ld,:);
        %lada = [];lada = horzcat(lada,  sqrt(bgv(:,1).^2 + bgv(:,2).^2), bg(:,1)-ccx, bg(:,2)-ccy,avx,avy,-avx,-avy);
        ut1 = vertcat(bgv(:,1) , bgv(:,2));ut2 = vertcat(bg(:,1)- ccx ,bg(:,2)-ccy);
        ut3 = vertcat(avx, avy);
        %%%%%%ut4 = vertcat( -(bg(:,1)-lax), -(bg(:,2)-lay) );ut4 = sum(ut4,2);
        %ut4 = vertcat( -(bg(:,1)-lax), -(bg(:,2)-lay) );ut4 = sum(ut4,2);
        ut4 = vertcat( -(bg(:,1)-  centrox(1:length(ddg),:) ), -(bg(:,2)-  centroy(1:length(ddg),:) ) );ut4 = sum(ut4,2);
       
        lada = [];lada = horzcat(lada,  (ut1), (ut2),(ut3), (-ut4));
        %lada = [];lada = horzcat(lada,  (bgv(:,1) + bgv(:,2)), (bg(:,1)-ccx + bg(:,2)-ccy),(avx+avy),(-(bg(:,1)-ccx)-(bg(:,2)-ccy))  );
        weight = lada(:,2:end)\lada(:,1);





        w2 = weight;
        
        %w2 = 0;
        %w2 = horzcat((weight(1:2))',w2);
        pa_gd  = csvread('alldata0404.csv');
        pa_gd = pa_gd(ala:end,:);pa_gd = pa_gd(:,1:72);
        pa_gd = pa_gd(1:le+1,:);ld = 1:lm(fa):length(pa_gd);pa_gd = pa_gd(ld',:);
        dapo = [pa_gd(:,at), pa_gd(:,at+36)];
        ag = [pa_gd(1,at),pa_gd(1,at+36)];
        pa_gd(:,at)=[];pa_gd(:,at+35)=[];
        %pa_gd1 = sqrt( (diff(pa_gd(:,1:36))).^2+ (diff(pa_gd(:,37:72))).^2 );
        %pa_gd1 = sort(pa_gd1,2);pa_gd1 = pa_gd1(:,1:15);
        vv = diff(pa_gd);
        dc=[];d5=[];ag1=[];
        %ag1 = [0,0];
        
        for i = 1:size(pa_gd,1)-1
        %ag1 = vertcat(ag1,ag);
     
        
        %note this addition
        ag = dapo(i,:);
        
        
        
        dc1 = sqrt(  ((ag(1)- pa_gd(i,1:35))).^2  + ((ag(2)-pa_gd(i,36:70))).^ 2 );
        dc2 = sort(dc1,2);   dc2 = dc2(:,1:15);
        for j = 1:15
            dc = horzcat(dc, find(dc1 == dc2(j)) );
        end
        
        d5 = dc(:,1);
        gux = pa_gd(i,1:35);guy = pa_gd(i,36:70);
        fux = vv(i,1:35);fuy = vv(i,36:70);
        l1 =  [ ag(1)-mean(gux(dc)),  ag(2) - mean(guy(dc) )];
        l2 = [mean(fux(dc)) , mean(fuy(dc))];
        
        %l3 = [ sum(ag(1)- gux(dc)), sum(ag(2) - guy(dc)) ];
        %l3 = [ ag(1)- gux(dc), ag(2) - guy(dc) ];
        l3 = [ sum( ag(1)- gux ),  sum( ag(2) - guy ) ];

        ga = [l1,l2,l3];
        ga = [w2(1)*ga(:,1:2), w2(2)*ga(:,3:4) , w2(3)*ga(:,5:6)];
        ga = ga(:,1:2)+ga(:,3:4)-ga(:,5:6);
        ag1 = vertcat(ag1,ga);
        ag = ag+ga;
        ag11 = vertcat(ag11,ag);
        ga = [];dc=[];
        end


        %a1 = diff(ag1);
        a1 = ag1;
        pa_gd  = csvread('alldata0404.csv');
        pa_gd = pa_gd(ala+1:end,:);pa_gd = pa_gd(:,1:72);
        pa_gd = pa_gd(1:le,:);
        ld = 1:lm(fa):length(pa_gd);pa_gd = pa_gd(ld',:);
        ame = [pa_gd(:,at), pa_gd(:,at+36)];
        pa_gd = diff(pa_gd);
        %pa_gd = pa_gd(1:le,:);
        pa_gd = [pa_gd(:,at),pa_gd(:,at+36)];
        %a1 = R(:,1);a2 = R(:,2);
        a2 = pa_gd;
        a22 = a2;
%         [a2,~] = ksdensity(a2);
%         [a1,~] = ksdensity(a1);
%       
%         
%         kl = (a1+eps).* ((a1+eps)-log(a2+eps));
%         kl1 = (a2+eps).* ((a2+eps)-log(a1+eps));
%         kl = (kl(~isinf(kl)));
%         kl = sum(kl(~isnan(kl)));
%         kl1 = (kl1(~isinf(kl1)));
%         kl1 = sum(kl1(~isnan(kl1)));
%         dkl = 0.5*(kl + kl1);
%         df = horzcat(df,dkl);
        da = sqrt( (ame(:,1)-ag11(:,1)).^2+ (ame(:,2)-ag11(:,2)).^2);
        da = sum(da);
end
     dame = vertcat(dame,da);
end

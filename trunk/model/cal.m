% clc
% clear
% close all
% tic
% %%
% ct=2600;
% yield=0;
% timing=0;
% bct=0;
% count=1;
% tz=12
% for zz=2:tz
%     for ww=0.8:0.002:1.1
% t=zeros(1,ct);
% m=t;
% n=t;
% % tic
% for ii=1:ct
%     [t(ii) m(ii) n(ii)]=testtime(zz*2,zz,ww);
% end
% % toc
% aa=histc(t,[0 1.5 500 inf]);
% y=aa(1)/sum(aa);
% % display(y)
% tavg=mean(t);
% 
% yield(count,zz)=y^10;
% timing(count,zz)=tavg;
% bct(count,zz)=max(n);
% count=count+1;
% display(ww)
% display(zz)
%     end
% end
% 
% save data.mat yield timing
% toc
figure(1)
axes('fontsize',20);
hold on
box on 
grid off
color={'.k','.k','dk','dk','^k','^k','*k','xk','xk','*k','*k','xm','xy'};
for zz=2:2:8
    plot(yield(:,zz)*100,timing(:,zz),color{zz-1},'MarkerSize',10);
    zz*2
end
xlim([0 105]);
ylim([0.6 8]);
xlabel('Chip yield (%)');
ylabel('Average test time (cycle)');
legend('4x4 group','8x8 group','12x12 group','16x16 group','Location','best');
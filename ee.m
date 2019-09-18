Ytest = sim(net,Itest);

%WIZUALIZACJA WYNIKOW
figure
plot(Ttest,'bo')
hold on
plot(Ytest,'r+')
axis([450 550 0 1.2])
title('0 - Inne obrazy, 1 - Kana³ w Dol')
xlabel('Numer wzorca')
ylabel('Ksztalt')
legend('prawdziwy ksztalt','rozpoznany ksztalt')

set(gca,'YTick',[0 .15 0.5 .85 1 1.2 ]);
set(gca,'YGrid','on');
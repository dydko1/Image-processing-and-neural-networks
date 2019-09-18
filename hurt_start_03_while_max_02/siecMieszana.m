function [Ttest,Ytest,sprawnosc,net,tr,Itest,rozp,pop,npop,nrozp,L1,L2]=siecMieszana(blad,ResztaObrazow,ZnaneObrazy,DoTestow,MaxObrazow,L1,L2)

%% ResztaObrazow-0, ZnaneObrazy-1
% DoTestow- obrazow do test�w, MaxObrazow- po przekroczeniu zostaje zbior
% pomniejszony do MaxObrazow
% 
%% Liczba neuronow w warstwach L1- wej, ukryta_1, ukryta_2

%%

% OBJASNIENIA PROCEDURY

% Parametry WEJSCIOWE
% 
% blad - parametr zadawnay przez uzytkownika, jest to warto��, kt�rej uzywam
% do obliczenia liczby odpowiedzi poprawnych, niepoprawnych i
% nierozpoznanych - warto�� u�ywana w funkcji "rozpoznanie" - wywolanie na
% koncu tej funkcji
% 
% Kl_1 i Kl_2 - macierze z obrazami
% 
% tr_1, tr_2 - to warto�ci oznaczaj�ce ile obraz�w z wektor�w Kl_1 i K_2 ma
% by� branych jako wzorce ucz�ce. Reszta jest brana jako wzorce testowe, np.
% je�eli w Kl_1 by�o 900 obraz�w, to tr_1 moglo by� 700, co oznacza, �e 700
% obraz�w jest branych jako wzorce uczace, a reszta jako wzorce testowe,
% 
% Parametry WYSCIOWE
% 
% Ttest - warto�ci, kt�re mia�y wyj�� po zastosowaniu nauczonej sieci, -
% parametr zwracany przez funkcje sim,
% 
% Ytest - warto�ci, kt�re wysz�y po zastosowaniu nauczonej sieci,- parametr
% zdefiniowany przez uzytkownika w sekcji "Wzorce testujace"
% 
% sprawnosc - to warto��, kt�ra wyznaczam za pomoca funkcji "ocena" na koncu
% tej funkcji; wartosc oznacza sprawno�� klasyfikatora. 
% 
% net i tr - wartosci wag nauczonej sieci - zwraca funkcja train
% 
% Itest - wektor zawierajacy obrazy uzywane do testowania sieci, wektor jest
% zadawany przez uzytkownika
% 
% CZESC PRZYGOTOWANIA DANYCH
% 
% Kl_1, Kl_2; %przeksztalacanie macierzy do wektorow, klasa 1 ,klasa 2
%%
[y1,x1]=size(ResztaObrazow);
[y2,x2]=size(ZnaneObrazy);
Kl_1=ResztaObrazow(:,randperm(x1)); % Miesza duzy zbior obrazow "ResztaObrazow"
Kl_1=Kl_1(:,1:x2); % Z wymieszanego "ResztaObrazow" wyzej wybiera tyle samo obrazow co znanych "ZnaneObrazy"
Kl_2=ZnaneObrazy(:,randperm(x2));
%%
opis0=['Znanych obrazow ',num2str(x2),' Nieznanych obrazow ',num2str(x1)];
disp(opis0)
%%

if x2>=MaxObrazow
    Kl_1=Kl_1(:,1:MaxObrazow); % z wylosowanych wybiera max obraz�w
    Kl_2=Kl_2(:,1:MaxObrazow); % z wylosowanych wybiera max obraz�w
    x2=MaxObrazow;
end

[yy1,xx1]=size(Kl_1);
[yy2,xx2]=size(Kl_2);
%%
disp('--------------------------------------');
opis1=['Do test�w wybrano po ',num2str(DoTestow),' z klasy (po ', num2str(DoTestow),' ostatnich z klasy, razem ',num2str(2*DoTestow) ')'];
disp (opis1);
disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
opis2=['Wybrano z nieznanych x_1=',num2str(xx1-DoTestow),' do uczenia, Wysokosc (wej�� sieci) y_1=',num2str(yy1)];
disp(opis2);
opis3=['Wybrano z    znanych x_2=',num2str(xx2-DoTestow),' do uczenia, Wysokosc (wej�� sieci) y_2=',num2str(yy2)];
disp(opis3);
disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
disp('--------------------------------------');
%%

tr=x2-DoTestow;

%% Definicja wzorc�w uczace - trenujace - formu�y w nawiasie sa zlozone bo
%% wybieram obrazy zgodnie z wartosciami tr_1 i tr_2 (np. pierwszych 700
%% obrazow)
Itrain = [double(Kl_1(:,1:tr)) double(Kl_2(:,1:tr))];
Ttrain = [zeros(1,tr) ones(1,tr)];
%% Wzorce testujace - tutaj wypisywane sa DoTestow (np. 200 ostatnich
%% obrazow)
Itest = [double(Kl_1(:,tr+1:x2)) double(Kl_2(:,tr+1:x2))]; %obrazy testowe klasa 1 i 2    
Ttest = [zeros(1,length(tr+1:x2)) ones(1,length(tr+1:x2))];

%DEFINICJA SIECI

%%


%% Parametry sieci
net = newff(minmax(Itrain),[L1 L2 1],{'logsig','logsig','logsig'},'trainlm');
%net = newff(minmax(Itrain),[L1 L2 1],{'tansig','tansig','logsig'},'trainlm');
net = init(net); 
net.trainFcn='trainscg'; 
net.trainParam.epochs = 500;
net.performFcn = 'sse';
net.trainParam.goal = 0.01;
% pokazywanie wykresu z treningu
% net.trainParam.show = 250;
% net.performFcn='mse';

% UCZENIE SIECI
[net, tr]= train(net, Itrain, Ttrain);
Ytest = sim(net,Itest);

% %WIZUALIZACJA WYNIKOW
% figure
% plot(Ttest,'bo')
% hold on
% plot(Ytest,'r+')
% axis([0 200 -0.5 1.5])
% title('0 - reszta 1 - znany')
% xlabel('Numer wzorca')
% ylabel('Ksztalt')
% legend('prawdziwy ksztalt','rozpoznany ksztalt')
% set(gca,'YTick',[-0.5 0 blad 1-blad 1 1.5]);
% set(gca,'YGrid','on');

[sprawnosc,rozp]=ocena(Ytest,Ttest,blad); %wyznaczenie sprawnosci klasyfikatora
[pop,npop,nrozp]=rozpoznanie(Ytest,Ttest,blad); %wyznaczenie liczby odpowiedzi poprawnych, niepoprawnych i nierozpoznanych 

disp('----------------------')
disp('----------------------')
statystyczne1=['rozp=',num2str(rozp),', pop=',num2str(pop),', npop=',num2str(npop)];
statystyczne2=['nrozp=',num2str(nrozp),', sprawnosc=',num2str(sprawnosc),'%'];
disp(statystyczne1);
disp(statystyczne2);
disp('----------------------')
disp('----------------------')
% plotperf(tr)
% - w pracy mam dodatkowe fukcje wizualizacji - pokazywalam Panu ostatnio,
% ale to nie jest w tej chwili potrzebne



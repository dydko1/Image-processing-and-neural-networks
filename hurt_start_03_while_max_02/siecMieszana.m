function [Ttest,Ytest,sprawnosc,net,tr,Itest,rozp,pop,npop,nrozp,L1,L2]=siecMieszana(blad,ResztaObrazow,ZnaneObrazy,DoTestow,MaxObrazow,L1,L2)

%% ResztaObrazow-0, ZnaneObrazy-1
% DoTestow- obrazow do testów, MaxObrazow- po przekroczeniu zostaje zbior
% pomniejszony do MaxObrazow
% 
%% Liczba neuronow w warstwach L1- wej, ukryta_1, ukryta_2

%%

% OBJASNIENIA PROCEDURY

% Parametry WEJSCIOWE
% 
% blad - parametr zadawnay przez uzytkownika, jest to wartoœæ, której uzywam
% do obliczenia liczby odpowiedzi poprawnych, niepoprawnych i
% nierozpoznanych - wartoœæ u¿ywana w funkcji "rozpoznanie" - wywolanie na
% koncu tej funkcji
% 
% Kl_1 i Kl_2 - macierze z obrazami
% 
% tr_1, tr_2 - to wartoœci oznaczaj¹ce ile obrazów z wektorów Kl_1 i K_2 ma
% byæ branych jako wzorce ucz¹ce. Reszta jest brana jako wzorce testowe, np.
% je¿eli w Kl_1 by³o 900 obrazów, to tr_1 moglo byæ 700, co oznacza, ¿e 700
% obrazów jest branych jako wzorce uczace, a reszta jako wzorce testowe,
% 
% Parametry WYSCIOWE
% 
% Ttest - wartoœci, które mia³y wyjœæ po zastosowaniu nauczonej sieci, -
% parametr zwracany przez funkcje sim,
% 
% Ytest - wartoœci, które wysz³y po zastosowaniu nauczonej sieci,- parametr
% zdefiniowany przez uzytkownika w sekcji "Wzorce testujace"
% 
% sprawnosc - to wartoœæ, która wyznaczam za pomoca funkcji "ocena" na koncu
% tej funkcji; wartosc oznacza sprawnoœæ klasyfikatora. 
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
    Kl_1=Kl_1(:,1:MaxObrazow); % z wylosowanych wybiera max obrazów
    Kl_2=Kl_2(:,1:MaxObrazow); % z wylosowanych wybiera max obrazów
    x2=MaxObrazow;
end

[yy1,xx1]=size(Kl_1);
[yy2,xx2]=size(Kl_2);
%%
disp('--------------------------------------');
opis1=['Do testów wybrano po ',num2str(DoTestow),' z klasy (po ', num2str(DoTestow),' ostatnich z klasy, razem ',num2str(2*DoTestow) ')'];
disp (opis1);
disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
opis2=['Wybrano z nieznanych x_1=',num2str(xx1-DoTestow),' do uczenia, Wysokosc (wejœæ sieci) y_1=',num2str(yy1)];
disp(opis2);
opis3=['Wybrano z    znanych x_2=',num2str(xx2-DoTestow),' do uczenia, Wysokosc (wejœæ sieci) y_2=',num2str(yy2)];
disp(opis3);
disp('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');
disp('--------------------------------------');
%%

tr=x2-DoTestow;

%% Definicja wzorców uczace - trenujace - formu³y w nawiasie sa zlozone bo
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



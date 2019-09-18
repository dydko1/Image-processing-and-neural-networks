function [Ttest,Ytest,sprawnosc,net,tr,Itest,rozp,pop,npop,nrozp,L1,L2]=siec6(blad,Kl_1,tr_1,Kl_2,tr_2,L1,L2)

%% Liczba neuronow w warstwach L1- wej, ukryta_1, ukryta_2

%%

%OBJASNIENIA PROCEDURY

%Parametry WEJSCIOWE

%blad - parametr zadawnay przez uzytkownika, jest to wartoœæ, której uzywam
%do obliczenia liczby odpowiedzi poprawnych, niepoprawnych i
%nierozpoznanych - wartoœæ u¿ywana w funkcji "rozpoznanie" - wywolanie na
%koncu tej funkcji

%Kl_1 i Kl_2 - macierze z obrazami

%tr_1, tr_2 - to wartoœci oznaczaj¹ce ile obrazów z wektorów Kl_1 i K_2 ma
%byæ branych jako wzorce ucz¹ce. Reszta jest brana jako wzorce testowe, np.
%je¿eli w Kl_1 by³o 900 obrazów, to tr_1 moglo byæ 700, co oznacza, ¿e 700
%obrazów jest branych jako wzorce uczace, a reszta jako wzorce testowe,

%Parametry WYSCIOWE

%Ttest - wartoœci, które mia³y wyjœæ po zastosowaniu nauczonej sieci, -
%parametr zwracany przez funkcje sim,

%Ytest - wartoœci, które wysz³y po zastosowaniu nauczonej sieci,- parametr
%zdefiniowany przez uzytkownika w sekcji "Wzorce testujace"

%sprawnosc - to wartoœæ, która wyznaczam za pomoca funkcji "ocena" na koncu
%tej funkcji; wartosc oznacza sprawnoœæ klasyfikatora. 

%net i tr - wartosci wag nauczonej sieci - zwraca funkcja train

%Itest - wektor zawierajacy obrazy uzywane do testowania sieci, wektor jest
%zadawany przez uzytkownika

%CZESC PRZYGOTOWANIA DANYCH

% Kl_1, Kl_2; %przeksztalacanie macierzy do wektorow, klasa 1 ,klasa 2

[y1,x1]=size(Kl_1)
[y2,x2]=size(Kl_2)

%% Definicja wzorców uczace - trenujace - formu³y w nawiasie sa zlozone bo
%% wybieram obrazy zgodnie z wartosciami tr_1 i tr_2 (np. pierwszych 700
%% obrazow)
Itrain = [double(Kl_1(:,1:tr_1)) double(Kl_2(:,1:tr_2))];
Ttrain = [zeros(1,tr_1) ones(1,tr_2)];
%% Wzorce testujace - tutaj wypisywane sa reszty (np. 200 ostatnich
%% obrazow)
Itest = [double(Kl_1(:,tr_1+1:x1)) double(Kl_2(:,tr_2+1:x2))]; %obrazy testowe klasa 1 i 2    
Ttest = [zeros(1,length(tr_1+1:x1)) ones(1,length(tr_2+1:x2))];

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
%net.performFcn='mse';

%UCZENIE SIECI
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

disp('---------------')
rozp,pop,npop,nrozp,sprawnosc
disp('---------------')
% plotperf(tr)
% - w pracy mam dodatkowe fukcje wizualizacji - pokazywalam Panu ostatnio,
% ale to nie jest w tej chwili potrzebne



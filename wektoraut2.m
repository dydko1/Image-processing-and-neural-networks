%function wektoraut2(granica);
function [macierzodp,Yodpowiedzi,cala,oczekiwana]=wektoraut2(granica);
%%
% macierzodp- macierz odpowiedzi 0 lub 1
% Yodpowiedzi- rzeczywista odpowiedz kazdej sieci
% oczekiwana- to co powinno wyjsc
% cala- cala macierz jak do excela
% granica- wartosc powyzej ktorej otrzymujemy 0 lub 1
%%
%granica=0.8;
if (isequal(exist('granica'),0))
    errordlg('Prosze podac wartosc granicy','Prosze podac wartosc granicy');
    return;
end

%domowy=pwd; %  pobiera sciezke do katalogu domowego
[zrodlowykatalog]=uigetdir;        % wskazanie pliku
%%
if (sum(zrodlowykatalog) ~= 0 )
    zrodlowykatalog=[zrodlowykatalog,'\'];
    % Wymuszenie domyslnego katalogu do zapisu
    % cd (zrodlowykatalog); % proponuje do zapisu wskazny katalog
    % cd (domowy);          % prowrot do katalogu domowgo
    siezkasieci=[zrodlowykatalog,'sieci\'];
    sieci=dir([siezkasieci,'*.mat']);
    sciezkaobrazow=[zrodlowykatalog,'obrazy\'];
    obrazow=dir([sciezkaobrazow,'*.mat']);
    ilesieci=length(sieci);
    ileobrazow=length(obrazow);
%%
    
    for m=1:ileobrazow
        kolejnyobraz=obrazow(m).name;
        plikobrazu=[sciezkaobrazow,kolejnyobraz];
        nazwaobrazow=who('-file',plikobrazu);
        ZmiennychWpliku=length(nazwaobrazow);      
        %
        if (ZmiennychWpliku ~= 1)
            napis=['W pliku `',plikobrazu,'` z obrazami jest wiêcej ni¿ jedna zmienna. Proszê pozostawiæ w pliku tylko jedn¹ zmienn¹.'];
            errordlg(napis,'Prosze skorygowaæ zawartoœæ pliku.');
            return;
        end
        %
        nazwaobrazu=num2str(cell2mat(nazwaobrazow(1)));
        load(plikobrazu,nazwaobrazu);
        obrazy=double(eval(nazwaobrazu));
%%
        logiczna=[{'OdpowiedŸ'}];
        nazwyobr={'nazwa_obrazu'}; 
        nazwysieci=[];
        YmacRz=[];
        naglowek=[];
        nn=[];

        for n=1:ilesieci
%%
            kolejnasiec=sieci(n).name;
            pliksieci=[siezkasieci,kolejnasiec];
            nazwasieci=who('-file',pliksieci);
            ZmiennychWpliku=length(nazwasieci);
            %            
            if (ZmiennychWpliku ~= 1)
                errordlg('W pliku z konfiguracj¹ sieci jest wiêcej ni¿ jedna zmienna. Proszê skorygowaæ zawartoœæ pliku ze struktur¹ sieci.','Prosze skorygowaæ zawartoœæ pliku ze struktur¹ sieci.');
                return;
            end

            if(exist('siec')) % usuwa stare zmienne, na wszelki wypadek
                clear siec macierz cala macierzodp Yodpowiedzi macierz ;                           
            end
            %
%%

            if(strcmp(kolejnyobraz,kolejnasiec))                
                nn=n;                     
                tosamo=kolejnyobraz;
            end
            
            nazwasieci=num2str(cell2mat(nazwasieci(1)));
            nazwakolumny={kolejnasiec(:,1:end-4)};
            load(pliksieci,nazwasieci);
            siec=eval(nazwasieci);              
            Ysim=(sim(siec,obrazy))'; %  z kazdej grupy obrazow jeden dlugi wiersz potem wiersz'            
            naglowek=[naglowek nazwakolumny];
            YmacRz=[YmacRz Ysim];
        end

        [i,j]=size(YmacRz);
        macierz=double((YmacRz>=granica)); % bez double daje PRAWDA | FA£SZ w excel 

%%
        macierzodp=macierz;
        Yodpowiedzi=YmacRz;
%%
                     
        if(~isempty(nn))
            oczekiwana=zeros(i,j);
            oczekiwana(:,nn)=ones(i,1);
            for k=1:i
                nazwyobr=[nazwyobr;{['obraz_',num2str(k)]}];
                if isequal(macierz(k,:),oczekiwana(k,:))
                    logiczna=[logiczna;{'Poprawna'}];
                else
                    logiczna=[logiczna;{'Niepoprawna'}];
                end
            end
            
            for k=1:j
                nazwysieci=[nazwysieci, {['siec_',num2str(k)]}];
            end
            nazwysieci1=[[{''},{'siec'}],nazwysieci,{''}];
            macierz=num2cell(macierz);
            wskazana=[{'Numer obrazu'};repmat({tosamo(:,1:end-4)},i,1)];
            odpowiedz=[nazwyobr,wskazana,[naglowek;macierz],logiczna];
        else
            for k=1:i
                nazwyobr=[nazwyobr;{['obraz_',num2str(k)]}];
            end
            
            for k=1:j
                nazwysieci=[nazwysieci, {['siec_',num2str(k)]}];
            end
            nazwysieci1=[{'siec'},nazwysieci];
            macierz=num2cell(macierz);
            odpowiedz=[nazwyobr,[naglowek;macierz]];
        end                            
        
        Rzeczywista=[naglowek;num2cell(YmacRz)];
        pustych=1;
        przerwa=repmat({''},i+1,pustych);
        nazwysieci=[nazwysieci1,repmat({''},1,pustych),nazwysieci];
        
        cala=[odpowiedz,przerwa,Rzeczywista];
        cala=[nazwysieci;cala];
        plikdozapisu=[plikobrazu(:,1:end-4),'.xls'];

%%
        if ((exist(plikdozapisu))== 2) %&(i<ile)
            nadpisano=['Nadpisano plik ',plikdozapisu];
            disp(nadpisano);
            delete (plikdozapisu);
            xlswrite(plikdozapisu,cala);
        else
            xlswrite(plikdozapisu,cala);
        end        
%%
    end
%%
else
    errordlg('Prosze wskazac katalog z sieciami ','Prosze wskazac katalog');
end
%%
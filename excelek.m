function excelek

%%
% disp('Mozna podac wiecej bledow w [] np [.1,.2,.3]');

%pyt{1} = 'Podaj bledy (.1,.15,.2,.25,.3)';      % tekst przy polu do wprowadzenia zmiennej 1
pyt{1} = 'Podaj bledy (.1,.15,.2,.25,.3)';
pyt{2} = 'Podaj nazwe pliku excela';            % tekst przy polu do wprowadzenia zmiennej 2
tytul  = 'Podaj dane';                          % nazwa okna
dane  = inputdlg(pyt, tytul, 1, {'.1,.15','30x30-'});     % wywolanie okna dialogowego
while (isempty(dane))
    return;
end
bledy=(str2num(cell2mat(dane(1))));     %%
nazwa=num2str(cell2mat(dane(2)));

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [nazwapliku,docelowykatalog] = uiputfile('*.xls','Plik z Wynikami i Zrzuty wykresów','test');
    if (sum(nazwapliku)~=0)&(sum(docelowykatalog)~=0)
        ile=length(bledy);


        katalogi=dir(wskazanykataloG);
        dlugosc=length(katalogi);
%%
        for n=1:dlugosc            
            if (katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..')))
                podkatalogi=katalogi(n).name;
                wskazanypodkatalog=([wskazanykataloG,'\',podkatalogi,'\']);
%%                
                katalogzapisu=[docelowykatalog,podkatalogi,'\'];
%%
                if(isdir(katalogzapisu)==0)
                    mkdir (katalogzapisu);
                end
%%
                zpliku=[];
                wynik=[];
                przerwa=[{'','','','','','',''};{'','','','','','',''};{'','','','','','',''}];
                
                for i=1:ile
                    blad=bledy(i);
                    bledu=num2str(blad*100);
                    zpliku=[wskazanypodkatalog,bledu,'\',nazwa,bledu,'%.xls'];
                    if ((exist(zpliku))== 2)
                        excelowy=num2cell(xlsread(zpliku));
                        wynik=[wynik;excelowy;przerwa];
                    else
                        errordlg('Brak pliku excela w podanym katalogu, usun procedure po else','Brak pliku excela');
                        return;
                    end
  
%                   
                end
%               
                naglowek=[{'pop','rozp','npop','nrozp','sprawnosc','L1','L2'};wynik];
                %wynik=[naglowek;wynik]
       
                plikdozapisu=strcat(docelowykatalog,podkatalogi,'\',nazwapliku);
                if ((exist(plikdozapisu))== 2)
                    delete (plikdozapisu);
                end
                
                xlswrite(plikdozapisu, wynik);
%%
            end
        end
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end

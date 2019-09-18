function wykresik3(bledy)

%%
disp('Mozna podac wiecej bledow w [] np [.1,.2,.3]');
%%
[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [nazwapliku,docelowykatalog] = uiputfile('*.xls','Plik z Wynikami i Zrzuty wykresów','30x30-');
    if (sum(nazwapliku)~=0)&(sum(docelowykatalog)~=0)
        ile=length(bledy);
        for i=1:ile
            blad=bledy(i);
            nazwysieci=[];
            wynik=[];
            katalogi=dir (wskazanykataloG);
            dlugosc=length(katalogi);
            for n=1:dlugosc
                if (katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))) 
                    podkatalogi=katalogi(n).name;
                    wskazanypodkatalog=[wskazanykataloG,'\',podkatalogi,'\'];
                    zlistowane=dir(strcat(wskazanypodkatalog,'\','*siec*')); % listowanie zawartosci katalogu                   
                    docelowypodkatalog=[docelowykatalog,podkatalogi];
                    Nplikow=length(zlistowane); % obliczanie ilosci plikow
                    %%
                    for m = 1:Nplikow
                        nazwyplikow=(zlistowane(m).name);
                        koncowka=nazwyplikow(end-5:end-4);
                        load ([wskazanypodkatalog,'\',nazwyplikow]);
                        %%
                        Ttest=eval(['Ttest_',koncowka]);
                        Ytest=eval(['Ytest_',koncowka]);
                        tr=eval(['tr_',koncowka]);
                        nazwasieci=['   net_',koncowka];
                        %WIZUALIZACJA WYNIKOW
                        figure
                        plot(Ttest,'bo')
                        hold on
                        plot(Ytest,'r+')
                        axis([0 200 -0.5 1.5])
                        title('0 - reszta, 1 - dobry ')
                        xlabel('Numer wzorca')
                        ylabel('Ksztalt')
                        legend('prawdziwy ksztalt','rozpoznany ksztalt')
                        set(gca,'YTick',[-0.5 0 blad 1-blad 1 1.5]);
                        set(gca,'YGrid','on');
                        %%
                        [sprawnosc,rozp]=ocena(Ytest,Ttest,blad);           %wyznaczenie sprawnosci klasyfikatora
                        [pop,npop,nrozp]=rozpoznanie(Ytest,Ttest,blad);     %wyznaczenie liczby odpowiedzi poprawnych, niepoprawnych i nierozpoznanych
                        %%
                        % disp('---------------')
                        % rozp,pop,npop,nrozp,sprawnosc
                        % disp('---------------')
                        %%
                        podkatalog=[docelowypodkatalog,'\',(num2str(blad*100))];
                        if(isdir(podkatalog)==0)
                            mkdir (podkatalog);
                        end
                        nazwa=[podkatalog,'\siec_',koncowka,'.jpg'];
                        saveas(gcf,nazwa);
                        close;
                        %%
                        %%
                        trkatalog=[docelowypodkatalog,'\tr'];
                        if(isdir(trkatalog)==0)
                            mkdir (trkatalog);
                        end

                        trplik=[trkatalog,'\tr_',koncowka,'.jpg'];
                        if((exist(trplik))~= 2)
                            plotperf(tr);
                            % nazwatr=[trkatalog,'tr_',koncowka,'.jpg'];
                            saveas(gcf,trplik);
                            close;
                        end
                        %%
                        %%
                        wynik=[wynik; pop,rozp,npop,nrozp,sprawnosc,L1,L2];
                        nazwysieci=[nazwysieci;nazwasieci]; % uwaga sieci
                    end
                    plikdozapisu=strcat(podkatalog,'\',nazwapliku(1:end-4),'-',num2str(blad*100),'%.xls');
                    if ((exist(plikdozapisu))== 2)
                        delete (plikdozapisu);
                    end
                    naglowek={'pop','rozp','npop','nrozp','sprawnosc','L1','L2'};
                    wyniki=num2cell(wynik);
                    %%
                    [i1,j1]=size(naglowek);
                    [i2,j2]=size(wyniki);
                    [i3,j3]=size(nazwysieci);

                    %%
                    if (j1==j2)&&(i2==i3)
                        nazwysieci=cellstr(nazwysieci);
                        wyniki=[wyniki nazwysieci] ;
                        naglowek=[naglowek,'Nazwa Sieci'];
                        dopliku=[naglowek;wyniki];
                        %%
                        xlswrite(plikdozapisu, dopliku);
                        %%
                    else
                        %%
                        xlswrite(plikdozapisu,wyniki);
                        %%
                    end
                end
            end
            end
            else
                errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
        end
    else
        errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
    end
  
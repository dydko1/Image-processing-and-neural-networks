function kopiuj()

[zrodlowykatalog] = uigetdir;
if (sum(zrodlowykatalog)~=0)
%[docelowykatalog] = uigetdir(zrodlowykatalog); jak ma zaczynac od zrodlowykatalog
    [docelowykatalog] = uigetdir;
    if (sum(docelowykatalog)~=0)
        docelowykatalog=[docelowykatalog,'\'];

        katalogi=dir(zrodlowykatalog);
        dlugosc=length(katalogi);
        %%
        for n=1:dlugosc
            if (katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..')))
                podkatalogi=katalogi(n).name;
                wskazanypodkatalog=([zrodlowykatalog,'\',podkatalogi,'\']);                                
                PlikdoZrodlowy=strcat(wskazanypodkatalog,podkatalogi,'.xls');                 

%%                
                if ((exist(PlikdoZrodlowy))== 2)  
                    DocelowyPlik=[docelowykatalog,podkatalogi,'.xls'];
                    if ((exist(DocelowyPlik))== 2)
                        disp('Usunalem plik w katalogu docelowym')
                        delete(DocelowyPlik);
                    end                   
                        copyfile(PlikdoZrodlowy,docelowykatalog)
                end
%%                
            end
        end
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end
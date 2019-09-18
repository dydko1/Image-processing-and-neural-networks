
katalogi=dir;
dlugosc=length(katalogi);
for n=1:dlugosc
    if (katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..')))
        podkatalog=katalogi(n).name;
        docelowykatalog=[pwd,'\',podkatalog,'\'];
        maly=[docelowykatalog,'duza_macierz.mat'];
        duzy=[docelowykatalog,'mala_macierz.mat'];
        load (maly);
        load (duzy);
        mala=pomieszana;       
        duza=DuzaWymieszana;
        [i,j]=size(mala);
        skrypt;
        clear DuzaWymieszana pomieszana duza mala
    end
end
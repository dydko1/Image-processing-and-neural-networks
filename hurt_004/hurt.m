
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
        
        clear DuzaWymieszana pomieszana
        
        
%%       
%         [i,j]=size(mala);
%         maksymalny=4000;
%         if(j>=maksymalny)
%             mala=mala(:,1:maksymalny);
%             duza=duza(:,1:maksymalny);
%         end
%%
        [i,j]=size(mala);
        j=j/4;
        skrypt;        
        clear duza mala
    end
end
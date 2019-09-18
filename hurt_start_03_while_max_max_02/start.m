% clc ; clear all ;close all;
% autor miroslaw.dyduch@gmail.com
%%
DoTestow=50; % obrazow do testow z konca, na 1 klase
MaxObrazow=100; % maksymalna liczba obrazów ubrana o obrazy testowania (MaxObrazow-DoTestow)
MaxIteracji=5; % Max liczba iteracji, po jej przekroczeniu wychodzi z petli while
%%
katalogi=dir;
dlugosc=length(katalogi);
for n=1:dlugosc
    if (katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..')))
        podkatalog=katalogi(n).name;
        docelowykatalog=[pwd,'\',podkatalog,'\'];
        maly=[docelowykatalog,'duza_macierz.mat'];
        duzy=[docelowykatalog,'mala_macierz.mat'];
%%        
        if isequal(exist(maly),2) & isequal(exist(duzy),2)
            load (maly);
            load (duzy);
            if exist('pomieszana')& exist('DuzaWymieszana')
                mala=pomieszana;
                duza=DuzaWymieszana;
                %%
                clear DuzaWymieszana pomieszana
                % to ponizej ma byc usuniete,
                % pozostawione tylko ze wzgledow historycznych ;]
                % poprawnie zdefioniowane jest w "siecMieszana.m"
                %          [i,j]=size(mala);
                %          maksymalny=3000;
                %          if(j>=maksymalny)
                %              mala=mala(:,1:maksymalny);
                %              duza=duza(:,1:maksymalny);
                %          end
                %%
                [i1,j1]=size(mala);
                [i2,j2]=size(duza);
                mala=mala(:,randperm(j1));
                duza=duza(:,randperm(j2));
                %%
                skrypt;
                clear duza mala
            else
                informacja=[{'Brak zmiennych w pliku  '};{'Brak zmiennej "pomieszana" (mala)'};{'Brak zmiennej "DuzaWymieszana" (duza)'}];
                errordlg(informacja,'Blad')
            end
        else
            informacja=[{'Brak pliku w katalogu .: '};{maly};{duzy}];
            errordlg(informacja,'Blad');
            % return;
        end
%%
    end
end
% clc ; clear all ;close all;
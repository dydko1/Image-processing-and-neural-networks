% Funkcja sluzy do rysowanie prostych linii (pionowych, poziomych lub 
% krzyzowych) w losowych miejscach na calej szerokosci/wysokosci
% obrazu. Rysowane linie moga byc czarne lub o losowym kolorze.  
%  
% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% wprowadzony => imread('obraz.xxx'); lub usun znak "%" przed 
% "wprowadzony=imread(wprowadzony)"
% 
% Dla rodzaj => "pionowa", "pozioma", "pionowa losowy" lub "pozioma losowy" 
% linie(wprowadzony,rodzaj,wartosc1)
% wartosc1- (0<wartosc<=1)
%
% Dla rodzaj => "pionowa i pozioma" lub "pionowa i pozioma losowy"
% linie(wprowadzony,rodzaj,wartosc1,wartosc2)
% wartosc1 i wartosc2 => (0<wartosc<=1)
% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

function[zaszumiony,gestosclinii]=linie(wprowadzony,rodzaj,wartosc1,wartosc2)

switch rodzaj

    case 'pionowa'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % wprowadzony=imread(wprowadzony); % wczytanie wprowadzony
        [YWierszy,XKolumn]=size(wprowadzony);

        if(nargin~=3) % jesli podanano zla ilosc argumentow funkcji
            errordlg('Podano zla ilosc argumentow dla linii pionowej','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        elseif((wartosc1>0)&(wartosc1<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipionowych=round(wartosc1*XKolumn); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipionowych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii jest krotsza niz wysokosci obrazu','Blad');
                zaszumiony=0;                
                gestosclinii=0;
                return;
            end
            linii=randperm(XKolumn);  % miesza wiersze
            Kolumny=linii(1:iloscliniipionowych); % wybiera n linii
            kolor=0; % wartosc koloru
            wprowadzony(:,Kolumny)=kolor;
            zaszumiony=wprowadzony;
            gestosclinii=(iloscliniipionowych/XKolumn);
        elseif(wartosc1==0)
            errordlg('Prosze podac gestosc linii pionowych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case 'pozioma'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % wprowadzony=imread(wprowadzony); % wczytanie wprowadzony
        [YWierszy,XKolumn]=size(wprowadzony);

        if(nargin~=3) % jesli podanano zla ilosc argumentow funkcji
            errordlg('Podano zla ilosc argumentow dla linii poziomej','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        elseif((wartosc1>0)&(wartosc1<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipoziomych=round(wartosc1*YWierszy); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipoziomych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii poziomych jest krotsza niz szerokosc obrazu','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(YWierszy);  % miesza wiersze
            Wiersze=linii(1:iloscliniipoziomych); % wybiera n linii
            kolor=0; % wartosc koloru
            wprowadzony(Wiersze,:)=kolor;
            zaszumiony=wprowadzony;
            gestosclinii=(iloscliniipoziomych/YWierszy);
        elseif(wartosc1==0)
            errordlg('Prosze podac gestosc linii poziomych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case 'pionowa i pozioma'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % wprowadzony=imread(wprowadzony); % wczytanie wprowadzonyu
        [YWierszy,XKolumn]=size(wprowadzony);

        if(nargin~=4) % jesli podanano zla ilosc argumentow funkcji
            errordlg('Podano za mala ilosc argumentow dla linii pionowej i poziomej','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        elseif((wartosc1>0)&(wartosc1<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipionowych=round(wartosc1*XKolumn); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipionowych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii pionowej jest krotsza niz wysokosc obrazu. Do rysowania samych linii pionowych/poziomych sluzy argumnt "pionowa", "pozioma", "pionowa losowy" lub "pozioma losowy"','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(XKolumn);  % miesza wiersze
            Kolumny=linii(1:iloscliniipionowych); % wybiera n linii
            kolor=0; % wartosc koloru
            wprowadzony(:,Kolumny)=kolor;
            % gestoscliniipionowych=(iloscliniipionowych/XKolumn);
            % gestosclinii=gestoscliniipionowych;
        elseif(wartosc1==0)
            errordlg('Prosze podac gestosc linii pionowych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestoscliniipionowych=0;
            gestosclinii=gestoscliniipionowych;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end
        % &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %
        % &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %
        % &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %
        if((wartosc2>0)&(wartosc2<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipoziomych=round(wartosc2*YWierszy); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipoziomych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii poziomych jest krotsza niz szerokosc obrazu. Do rysowania samych linii pionowych/poziomych sluzy argumnt "pionowa", "pozioma", "pionowa losowy" lub "pozioma losowy"','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(YWierszy);  % miesza wiersze
            Wiersze=linii(1:iloscliniipoziomych); % wybiera n linii
            kolor=0; % wartosc koloru
            wprowadzony(Wiersze,:)=kolor;
            zaszumiony=wprowadzony;
            % gestoscliniipoziomych=(iloscliniipoziomych/YWierszy);
            % gestosclinii=gestoscliniipoziomych;
        elseif(wartosc2==0)
            errordlg('Prosze podac gestosc linii poziomych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestoscliniipoziomych=0;
            gestosclinii=gestoscliniipoziomych;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end

        %%%^^^^^^^^^^^%%%
        poleobrazu=XKolumn*YWierszy;
        % iloscliniipionowych
        % iloscliniipoziomych
        polepionowych=YWierszy*iloscliniipionowych; % calkowite pole linii pionowych
        polepoziomych=XKolumn*iloscliniipoziomych;  % calkowite pole linii poziomych
        polelinii=polepionowych+polepoziomych;      % zsumowane pole linii
        % trzeba odjac punkty przeciecia aby otrzymac rzeczywite pole
        % zajmowane przez linie
        iloscpunktowprzeciecia=(iloscliniipionowych*iloscliniipoziomych);
        % rzeczywista gestosc linii
        gestosclinii=((polelinii-iloscpunktowprzeciecia)/poleobrazu);
        %%%^^^^^^^^^^^%%%
        
    case 'pionowa losowy'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %wprowadzony=imread(wprowadzony); % wczytanie wprowadzonyu
        [YWierszy,XKolumn]=size(wprowadzony);

        if(nargin~=3) % jesli podanano zla ilosc argumentow funkcji
            errordlg('Podano zla ilosc argumentow dla linii pionowej','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        elseif((wartosc1>0)&(wartosc1<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipionowych=round(wartosc1*XKolumn); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipionowych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii jest krotsza niz wysokosci obrazu','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(XKolumn);  % miesza wiersze
            Kolumny=linii(1:iloscliniipionowych); % wybiera n linii
            % losowy kolor
            for i=1:iloscliniipionowych
                kolor=(round(rand(1)*255));
                wprowadzony(:,Kolumny(i))=kolor;
            end
            zaszumiony=wprowadzony;
            gestosclinii=(iloscliniipionowych/XKolumn);
        elseif(wartosc1==0)
            errordlg('Prosze podac gestosc linii pionowych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case 'pozioma losowy'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %wprowadzony=imread(wprowadzony); % wczytanie wprowadzonyu
        [YWierszy,XKolumn]=size(wprowadzony);

        if(nargin~=3) % jesli podanano zla ilosc argumentow funkcji
            errordlg('Podano zla ilosc argumentow dla linii poziomej','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        elseif((wartosc1>0)&(wartosc1<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipoziomych=round(wartosc1*YWierszy); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipoziomych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii poziomych jest krotsza niz szerokosc obrazu','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(YWierszy);  % miesza wiersze
            Wiersze=linii(1:iloscliniipoziomych); % wybiera n linii
            % losowy kolor
            for i=1:iloscliniipoziomych
                kolor=(round(rand(1)*255));
                wprowadzony(Wiersze(i),:)=kolor;
            end
            zaszumiony=wprowadzony;
            gestosclinii=(iloscliniipoziomych/YWierszy);
        elseif(wartosc1==0)
            errordlg('Prosze podac gestosc linii poziomych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case 'pionowa i pozioma losowy'
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %wprowadzony=imread(wprowadzony); % wczytanie wprowadzonyu
        [YWierszy,XKolumn]=size(wprowadzony);

        if(nargin~=4) % jesli podanano zla ilosc argumentow funkcji
            errordlg('Podano za mala ilosc argumentow dla linii pionowej i poziomej','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        elseif((wartosc1>0)&(wartosc1<=1))
            % round zaokragla do calkowitej liczby
            iloscliniipionowych=round(wartosc1*XKolumn); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipionowych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii pionowych jest krotsza niz wysokosc obrazu. Do rysowania samych linii pionowych/poziomych sluzy argumnt "pionowa", "pozioma", "pionowa losowy" lub "pozioma losowy"','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(XKolumn);  % miesza wiersze
            Kolumny=linii(1:iloscliniipionowych); % wybiera n linii
            % losowy kolor
            for i=1:iloscliniipionowych
                kolor=(round(rand(1)*255));
                wprowadzony(:,Kolumny(i))=kolor;
            end
            % gestoscliniipionowych=(iloscliniipionowych/XKolumn);
            % gestosclinii=gestoscliniipionowych;
        elseif(wartosc1==0)
            errordlg('Prosze podac gestosc linii pionowych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestoscliniipionowych=0;
            gestosclinii=gestoscliniipionowych;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end
        % &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %
        % &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %
        % &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& %
        if((wartosc2>0)&(wartosc2<=1))
            % round zaokragla do calkowitej liczby            
            iloscliniipoziomych=round(wartosc2*YWierszy); % procent * liczba kolumn, zaokragla w dol
            if(iloscliniipoziomych<1)
                errordlg('Dla podanej gestosci linii, obliczona dlugosc linii poziomych jest krotsza niz szerokosc obrazu. Do rysowania samych linii pionowych/poziomych sluzy argumnt "pionowa", "pozioma", "pionowa losowy" lub "pozioma losowy"','Blad');
                zaszumiony=0;
                gestosclinii=0;
                return;
            end
            linii=randperm(YWierszy);  % miesza wiersze
            Wiersze=linii(1:iloscliniipoziomych); % wybiera n linii            
            % iloscliniipoziomych
            % losowy kolor
            for i=1:iloscliniipoziomych
                kolor=(round(rand(1)*255));
                wprowadzony(Wiersze(i),:)=kolor;
            end
            zaszumiony=wprowadzony;
            % gestoscliniipoziomych=(iloscliniipoziomych/YWierszy);
            % gestosclinii=gestoscliniipoziomych;
        elseif(wartosc2==0)
            errordlg('Prosze podac gestosc linii poziomych (0<linia<=1)','Blad');
            zaszumiony=0;
            gestosclinii=0;
            return;
        else
            errordlg('Wartosc spoza zakresu ','Blad');
            zaszumiony='Wartosc spoza zakresu';
            gestosclinii='Wartosc spoza zakresu';
            return;
        end

        %%%^^^^^^^^^^^%%%
        poleobrazu=XKolumn*YWierszy;
        % iloscliniipionowych
        % iloscliniipoziomych
        polepionowych=YWierszy*iloscliniipionowych; % calkowite pole linii pionowych
        polepoziomych=XKolumn*iloscliniipoziomych;  % calkowite pole linii poziomych
        polelinii=polepionowych+polepoziomych;      % zsumowane pole linii
        % trzeba odjac punkty przeciecia aby otrzymac rzeczywite pole
        % zajmowane przez linie
        iloscpunktowprzeciecia=(iloscliniipionowych*iloscliniipoziomych);
        % rzeczywista gestosc linii
        gestosclinii=((polelinii-iloscpunktowprzeciecia)/poleobrazu);
        %%%^^^^^^^^^^^%%%
    otherwise
        errordlg('Prosze wybrac jako argument funkcji rodzaj linii: "pionowa", "pozioma", "pionowa losowy", "pozioma losowy", "pionowa i pozioma" lub "pionowa i pozioma losowy"','Blad');
        zaszumiony='Wartosc spoza zakresu';
        gestosclinii='Wartosc spoza zakresu';
        return;
end
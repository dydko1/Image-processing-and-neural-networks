function varargout = aplikakacja(varargin)
% APLIKAKACJA M-file for aplikakacja.fig
%      APLIKAKACJA, by itself, creates a new APLIKAKACJA or raises the existing
%      singleton*.
%
%      H = APLIKAKACJA returns the handle to a new APLIKAKACJA or the handle to
%      the existing singleton*.
%
%      APLIKAKACJA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in APLIKAKACJA.M with the given input arguments.
%
%      APLIKAKACJA('Property','Value',...) creates a new APLIKAKACJA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aplikakacja_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aplikakacja_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aplikakacja

% Last Modified by GUIDE v2.5 15-Apr-2007 20:17:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @aplikakacja_OpeningFcn, ...
    'gui_OutputFcn',  @aplikakacja_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before aplikakacja is made visible.
function aplikakacja_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aplikakacja (see VARARGIN)

% Choose default command line output for aplikakacja
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes aplikakacja wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aplikakacja_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%
% Mail autora miroslaw.dyduch@gmail.com
%%
% --- Konwertowanie avi->jpg.
function pushbutton1_Callback(hObject, eventdata, handles)

domowy=pwd; %##% pobiera sciezke do katalogu domowego
[wskazanyplik,wskazanykatalog]=uigetfile('*.avi');        % wskazanie pliku

if ((sum(wskazanyplik) ~= 0) & (sum(wskazanykatalog) ~= 0))
    % Wymuszenie domyslnego katalogu do zapisania plikow "*.jpg"
    % cd (wskazanykatalog); %##% proponuje do zapisu wskazny katalog
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','klatki'); % zapisanie plikow
    % cd (domowy); %##% prowrot do katalogu domowgo
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);                % bez rozszerzenia

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        %%%
        %##% ffmpeg=['ffmpeggui\ffmpeg -i '];
        ffmpeg=[domowy,'\ffmpeggui\ffmpeg -i '];        
        otworz=[ffmpeg,wskazanykatalog,wskazanyplik,' -qscale 1 ',docelowykatalog,docelowanazwa,'%08d.jpg'];
        dos (otworz);        
        %%%
        % okno=['Klatki z filmu znajduja sie w katalogu ',docelowykatalog,docelowanazwa,' ']; msgbox(okno,'Uwaga');
    else
        errordlg('Prosze wskazac katalog do zapisania sekwencji filmu','Prosze wskazac katalog');
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else
    errordlg('Prosze wskazac plik wideo','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Kolorowy->szary->brzegi->rozmiar.
function pushbutton2_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','szary');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';      % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'360','288','10'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                    % do usuniecia brzegu

        % operacje na plikach i obrazach
        for n = 1:Nplikow                % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            obraz=imread(wczytywany);    % wczytanie pliku z listowania
            %figure; imshow (obraz);     % pokazanie obrazu w nowym oknie
            szary=rgb2gray(obraz);       % przetwarzanie kolorowego obrazu jpg na szary

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x]=size(szary);           % rozmiar obrazu
            % do usuwania paska z obrazu (naokolo)
            % Funkcja imcrop przyjmuje za poczatek ukladu punkt 'naokolo,naokolo'.
            % Nastepnie odejmuje sie (2*naokolo-1), gdyz 1*naokolo to brzeg !!

            if (naokolo<0)
                errordlg('Prosze podac wartosc brzegu >= 0','Podaj prawidlowy brzeg');
                return;
            elseif ((x<=2*naokolo) | (y<=2*naokolo))
                errordlg('Zostala podana za duza wartosc brzegu do usuniecia','BLAD');
                return;
            elseif (naokolo==0)
                %%%
                if ((YObrazu>0) & (XObrazu>0))
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    % figure;  imshow(szary);                          % pokazanie obrazu w nowym oknie
                    imwrite(szary,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    % figure;  imshow(szary);                          % pokazanie obrazu w nowym oknie
                    imwrite(szary,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                %%%
                if ((YObrazu > 0) & (XObrazu > 0))
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    [y,x]=size(szary);                                 % rozmiar obrazu
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    % figure;  imshow(szary);                          % pokazanie obrazu w nowym oknie
                    imwrite(szary,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    % figure;  imshow(szary);                          %pokazanie obrazu w nowym oknie
                    imwrite(szary,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Kolorowy->szary->brzegi->rozmiar>odbicie  X.
function pushbutton3_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','odbityX');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';      % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'360','288','10'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                    % do usuniecia brzegu

        % operacje na plikach i obrazach
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku  
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            obraz=imread(wczytywany);         % wczytanie pliku z listowania
            %figure; imshow (obraz);          % pokazanie obrazu w nowym oknie
            szary=rgb2gray(obraz);            % przetwarzanie kolorowego obrazu jpg na szary

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x]=size(szary);           % rozmiar obrazu
            % do usuwania paska z obrazu (naokolo)
            % Funkcja imcrop przyjmuje za poczatek ukladu punkt naokolo,naokolo.
            % Nastepnie odejmuje sie -(2*naokolo-1), gdyz 1*naokolo to brzeg !!

            if (naokolo<0)
                errordlg('Prosze podac wartosc brzegu >= 0','Podaj prawidlowy brzeg');
                return;
            elseif ((x<=2*naokolo) | (y<=2*naokolo))
                errordlg('Zostala podana za duza wartosc brzegu do usuniecia','BLAD');
                return;
            elseif (naokolo==0)
                %%%
                if ((YObrazu>0) & (XObrazu>0))
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityX=flipud(szary);                             % odbicie wzgledem osi poziomej 'X'                    
                    imwrite(odbityX,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityX=flipud(szary);                             % odbicie wzgledem osi poziomej 'X'                    
                    imwrite(odbityX,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                %%%
                if ((YObrazu > 0) & (XObrazu > 0))
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    [y,x]=size(szary);                                 % rozmiar obrazu
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityX=flipud(szary);                             % odbicie wzgledem osi poziomej 'X'                    
                    imwrite(odbityX,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityX=flipud(szary);                             % odbicie wzgledem osi poziomej 'X'                    
                    imwrite(odbityX,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Kolorowy->szary->brzegi->rozmiar->odbicie  Y.
function pushbutton4_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','odbityY');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';      % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'360','288','10'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                    % do usuniecia brzegu

        % operacje na plikach i obrazach
        for n = 1:Nplikow                % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            obraz=imread(wczytywany);    % wczytanie pliku z listowania
            %figure; imshow (obraz);     % pokazanie obrazu w nowym oknie
            szary=rgb2gray(obraz);       % przetwarzanie kolorowego obrazu jpg na szary

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x]=size(szary);           % rozmiar obrazu
            % do usuwania paska z obrazu (naokolo)
            % Funkcja imcrop przyjmuje za poczatek ukladu punkt naokolo,naokolo.
            % Nastepnie odejmuje sie -(2*naokolo-1), gdyz 1*naokolo to brzeg !!

            if (naokolo<0)
                errordlg('Prosze podac wartosc brzegu >= 0','Podaj prawidlowy brzeg');
                return;
            elseif ((x<=2*naokolo) | (y<=2*naokolo))
                errordlg('Zostala podana za duza wartosc brzegu do usuniecia','BLAD');
                return;
            elseif (naokolo==0)
                %%%
                if ((YObrazu>0) & (XObrazu>0))
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityY=fliplr(szary);                             % odbicie wzgledem osi poziomej 'Y'                    
                    imwrite(odbityY,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityY=fliplr(szary);                             % odbicie wzgledem osi poziomej 'Y'                    
                    imwrite(odbityY,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                %%%
                if ((YObrazu > 0) & (XObrazu > 0))
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    [y,x]=size(szary);                                 % rozmiar obrazu
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityY=fliplr(szary);                             % odbicie wzgledem osi poziomej 'Y'                    
                    imwrite(odbityY,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    odbityY=fliplr(szary);                             % odbicie wzgledem osi poziomej 'Y'                    
                    imwrite(odbityY,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end

    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Usuwanie uszkodzonych klatek obrazu szarego.
function pushbutton5_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow

    k=0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
        nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
        wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
        obraz=imread(wczytywany);    % wczytanie pliku z listowania
        %figure; imshow (obraz);     % pokazanie obrazu w nowym oknie

        [y,x]=size(obraz);
        a=[10 20];  % punkty od x1 do x2
        b=[80 80];  % punkty od y1 do y2
        ilex=a(1,2)-a(1);    % roznica po x w lini prostej

        c1=improfile(obraz,a,b); % wyznacza linie w 1 kwadracie
        %linia1=line(a,b,'Color',[1 1 1],'LineWidth',3);   % pokazuje linie,lewa gorna
        c2=improfile(obraz,a,y-b); % wyznacza linie w 1 kwadracie
        %linia2=line(a,y-b,'Color',[1 1 1],'LineWidth',3); % pokazuje linie, lewa dolna
        c3=improfile(obraz,x-a,b); % wyznacza linie w 1 kwadracie
        %linia3=line(x-a,b,'Color',[1 1 1],'LineWidth',3); % pokazuje linie, prawa gorna
        c4=improfile(obraz,x-a,y-b); % wyznacza linie w 1 kwadracie
        %linia4=line(x-a,y-b,'Color',[1 1 1],'LineWidth',3); % pokazuje linie, prawa gorna

        z1=sum(c1);z2=sum(c2);z3=sum(c3);z4=sum(c4);
        if ((z1)==(z2)) & ((z3) == (z4))   % jesli wszystkie punkty sa sobie rowne
            %disp ('Uszkodzona CALA klatka filmu');
            delete (wczytywany);
            k=k+1;
        elseif ((z1)/ilex)==29    % badany obszar c1 klatki
            %disp ('Uszkodzony obszar c1 klatki filmu');
            delete (wczytywany);
            k=k+1;
        elseif ((z2)/ilex)==29    % badany obszar c2 klatki
            %disp ('Uszkodzony obszar c2 klatki filmu');
            delete (wczytywany);
            k=k+1;
        elseif ((z3)/ilex)==29    % badany obszar c3 klatki
            %disp ('Uszkodzony obszar c2 klatki filmu');
            delete (wczytywany);
            k=k+1;
        elseif ((z4)/ilex)==29    % badany obszar c4 klatki
            %disp ('Uszkodzony obszar c4 klatki filmu');
            delete (wczytywany);
            k=k+1;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if k>=1
        msgbox('Zostaly usuniete uszkodzone klatki','Uwaga','warn');
    else
        msgbox('Brak uszkodzonych klatek','Uwaga','warn');
    end

else
    errordlg('Prosze wskazac plik "*.jpg"" w katalogu','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Zmiana rozmiaru obrazu, usuwanie brzegow.
function pushbutton6_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog]=uiputfile('*.jpg','Pliki zapisac pod nazwa','skalowany');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        pyt{1} = 'Szerokosc obrazu';                             % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu';                              % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                         % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'30','30','0'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu

        % operacje na plikach i obrazach
        %%%
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            obraz=imread(wczytywany);    % wczytanie pliku z listowania

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x,pom]=size(obraz); % rozmiar obrazu, % pom gdy kolorowy
            if (((YObrazu <= 0) | (XObrazu <= 0)) | ((YObrazu == y) & (XObrazu == x))) & (naokolo==0)
                errordlg('Podano nieprawidlowy lub ten sam rozmiar obrazu (do przeskalowania)','BLAD');
                return;
            elseif(naokolo<0)
                errordlg('Prosze podac wartosc brzegu >= 0','Podaj prawidlowy brzeg');
                return;
            elseif ((x<=2*naokolo) | (y<=2*naokolo))
                errordlg('Zostala podana za duza wartosc brzegu do usuniecia','BLAD');
                return;
            elseif ((YObrazu > 0) & (XObrazu > 0))
                if(naokolo==0)
                    obraz=imresize(obraz,[YObrazu XObrazu]);           % skalowanie obrazu
                    %figure;  imshow(obraz);                           % pokazanie obrazu w nowym oknie                    
                    imwrite(obraz,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
                elseif(naokolo>0)
                    obraz=imcrop(obraz,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    [y,x,pom]=size(obraz); % pom gdy kolorowy
                    if ((XObrazu ~=x) | (YObrazu ~=y))
                        obraz=imresize(obraz,[YObrazu XObrazu]); % skalowanie obrazu
                    end
                    %figure;  imshow(obraz);                           % pokazanie obrazu w nowym oknie
                    imwrite(obraz,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Zostala podana nieprawidlowa wartosc brzegu do usuniecia','BLAD');
                    return;
                end
            elseif (((YObrazu == 0) & (XObrazu == 0)) & (naokolo>0))
                obraz=imcrop(obraz,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                %figure;  imshow(obraz);                           % pokazanie obrazu w nowym oknie
                imwrite(obraz,plikdozapisu);                       % zapisanie przetworzonego obrazu do pliku
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
        %%%
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Lustrzane odbicie obrazu szarego wzdluz osi  X.
function pushbutton7_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','odbityX');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))

        % operacje na plikach i obrazach
        %%%
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);                        % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            szary=imread(wczytywany);                          % wczytanie pliku z listowania
            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
            odbityX=flipud(szary);                             % odbicie wzgledem osi poziomej 'X'
            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie            
            imwrite(odbityX,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
        end
        %%%
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Lustrzane odbicie obrazu szarego wzdluz osi  Y.
function pushbutton8_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','odbityY');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        % operacje na plikach i obrazach
        %%%
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);                        % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            szary=imread(wczytywany);                          % wczytanie pliku z listowania
            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
            odbityY=fliplr(szary);                             % odbicie wzgledem osi poziomej 'Y'
            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie            
            imwrite(odbityY,plikdozapisu);                     % zapisanie przetworzonego obrazu do pliku
        end
        %%%
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&  POCZ¥TEK  &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&  POCZ¥TEK  &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&  POCZ¥TEK  &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%

% --- Szary->brzegi->rozmiar>szum.
function pushbutton9_Callback(hObject, eventdata, handles)

rodzajszumu = get(handles.popupmenu1,'Value');
switch rodzajszumu

    case 1 % dla szumu impulsowego
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc szumu impulsowego (0-1)';              % tekst przy polu do wprowadzenia zmiennej 4
        tytul  = 'Szum sol i pieprz';                            % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.05'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Wartosc=(str2num(cell2mat(wynik(4))));                   % GestoscSzumu

        if (Wartosc >= 0) & (Wartosc <= 1)  % z zakresu 0 1
            rodzaj='salt & pepper';
            pom1=mat2str(Wartosc,4);pom1(1,2)=','; % w domyslnej nazwie nie moze byc "." !!
            proponowana=['sol&pieprz-GestoscSzumu-',pom1,'-']; % gdyz ucina nazwe za kropka !!
        else
            errordlg('Prosze podac poprana gestsosc szumu (0-1)','Blad');
            return;
        end
        %%%

    case 2 % dla szumu cetkowanego
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Wariacja (0-1)';                               % tekst przy polu do wprowadzenia zmiennej 4
        tytul  = 'Szum typu cetkowanego';                        % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Wartosc=(str2num(cell2mat(wynik(4))));                   % Wariacja

        if (Wartosc >= 0) & (Wartosc <= 1)  % z zakresu 0 1
            rodzaj='speckle';
            pom1=mat2str(Wartosc,4);pom1(1,2)=','; % w domyslnej nazwie nie moze byc "." !!
            proponowana=['cetkowany-Wariacji-',pom1,'-']; % gdyz ucina nazwe za kropka !!
        else
            errordlg('Prosze podac poprana wariacje (0-1)','Blad');
            return;
        end
        %%%

    case 3 % dla bialego szumu Gaussa
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';        % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';         % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';        % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Srednia szumu (0-1)';                             % tekst przy polu do wprowadzenia zmiennej 4
        pyt{5} = 'Wariacja szumu (0-1)';                            % tekst przy polu do wprowadzenia zmiennej 5
        tytul  = 'Bialy szum Gaussa';                               % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0','0.01'}); % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Srednia=(str2num(cell2mat(wynik(4))));                   % srednia szumu
        Wariacja=(str2num(cell2mat(wynik(5))));                  % wariacja szumu

        if (((Srednia >= 0) & (Srednia <= 1)) & ((Wariacja >= 0) & (Wariacja <= 1)))  % z zakresu 0 1
            rodzaj='gaussian';
            pom1=mat2str(Srednia,4);pom1(1,2)=',';  % w domyslnej nazwie nie moze byc "." !!
            pom2=mat2str(Wariacja,4);pom2(1,2)=','; % gdyz ucina nazwe za kropka !!
            proponowana=['Gaussa-Sredniej-',pom1,'-Wariacji-',pom2,'-'];
        else
            errordlg('Prosze podac poprana gestsosc szumu (0-1)','Blad');
            return;
        end
        %%%

    case 4 % dla linii pionowych
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc linii, (0<linia<=1)';                  % tekst przy polu do wprowadzenia zmiennej 4
        tytul  = 'Linie czarne pionowe';                         % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Wartosc=(str2num(cell2mat(wynik(4))));                   % gestosc linii pionowych

        if (Wartosc > 0) & (Wartosc <= 1)  % z zakresu 0 1
            rodzaj='pionowa';
            proponowana=['PionoweCzarnyLinii-Powierzchni-'];
        else
            errordlg('Prosze podac poprana gestosc linii pionowych, (0<linia<=1)','Blad');
            return;
        end
        %%%

    case 5 % dla linii poziomych
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';        % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc linii, (0<linia<=1)';                     % tekst przy polu do wprowadzenia zmiennej 4
        tytul  = 'Linie czarne poziome';                            % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Wartosc=(str2num(cell2mat(wynik(4))));                   % gestosc linii pionowych

        if (Wartosc > 0) & (Wartosc <= 1)                        % z zakresu 0 1
            rodzaj='pozioma';
            proponowana=['PoziomeCzarnyLinii-Powierzchni-'];
        else
            errordlg('Prosze podac poprana gestosc linii poziomych, (0<linia<=1)','Blad');
            return;
        end
        %%%

    case 6 % dla linii pionowych i poziomych
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';        % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc linii pionowych, (0<linia<=1)';           % tekst przy polu do wprowadzenia zmiennej 4
        pyt{5} = 'Gestosc linii poziomych, (0<linia<=1)';           % tekst przy polu do wprowadzenia zmiennej 5
        tytul  = 'Linie czarne pionowe i poziome';                  % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04','0.04'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Pionowa=(str2num(cell2mat(wynik(4))));                   % gestosc linii pionowych
        Pozioma=(str2num(cell2mat(wynik(5))));                   % gestosc linii poziomych

        if ((Pionowa > 0) & (Pionowa <= 1)) & ((Pozioma > 0) & (Pozioma <= 1))  % z zakresu 0 1
            rodzaj='pionowa i pozioma';
            proponowana=['PionoweIPoziomeCzarnyLinii-Powierzchni-'];
        else
            errordlg('Prosze podac poprana gestosc linii pionowych i poziomych, (0<linia<=1)','Blad');
            return;
        end
        %%%
    case 7 % dla linii pionowych
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc linii, (0<linia<=1)';                  % tekst przy polu do wprowadzenia zmiennej 4
        tytul  = 'Linie pionowe o losowym kolorze';                      % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Wartosc=(str2num(cell2mat(wynik(4))));                   % gestosc linii pionowych

        if (Wartosc > 0) & (Wartosc <= 1)  % z zakresu 0 1
            rodzaj='pionowa losowy';
            proponowana=['PionoweLosowyKolorLinii-Powierzchni-'];
        else
            errordlg('Prosze podac poprana gestosc linii pionowych, (0<linia<=1)','Blad');
            return;
        end
        %%%

    case 8 % dla linii poziomych
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc linii, (0<linia<=1)';                  % tekst przy polu do wprowadzenia zmiennej 4
        tytul  = 'Linie poziome o losowym kolorze';              % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Wartosc=(str2num(cell2mat(wynik(4))));                   % gestosc linii pionowych

        if (Wartosc > 0) & (Wartosc <= 1)                        % z zakresu 0 1
            rodzaj='pozioma losowy';
            proponowana=['PoziomeLosowyKolorLinii-Powierzchni-'];
        else
            errordlg('Prosze podac poprana gestosc linii poziomych, (0<linia<=1)','Blad');
            return;
        end
        %%%

    case 9 % dla linii pionowych i poziomych
        %%%
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';     % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Gestosc linii pionowych, (0<linia<=1)';        % tekst przy polu do wprowadzenia zmiennej 4
        pyt{5} = 'Gestosc linii poziomych, (0<linia<=1)';        % tekst przy polu do wprowadzenia zmiennej 5
        tytul  = 'Linie pionowe i poziome o losowym kolorze';            % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.04','0.04'});  % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        Pionowa=(str2num(cell2mat(wynik(4))));                   % gestosc linii pionowych
        Pozioma=(str2num(cell2mat(wynik(5))));                   % gestosc linii poziomych

        if ((Pionowa > 0) & (Pionowa <= 1)) & ((Pozioma > 0) & (Pozioma <= 1))  % z zakresu 0 1
            rodzaj='pionowa i pozioma losowy';
            proponowana=['PionoweIPoziomeLosowyKolorLinii-Powierzchni-'];
        else
            errordlg('Prosze podac poprana gestosc linii pionowych i poziomych, (0<linia<=1)','Blad');
            return;
        end
        %%%    
end

% POLOWA
[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow

    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','W nazwie zostanie dodana obliczona gestosc linii dla "pionowa", "pozioma", "pionowa i pozioma"',proponowana);
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);
    proponowana=docelowanazwa;

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        % operacje na plikach i obrazach
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            % wczytanie pliku z listowania
            szary=imread(strcat(wskazanykatalog,nazwapliku));
            %figure; imshow (szary);     % pokazanie obrazu w nowym oknie

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x]=size(szary);           % rozmiar obrazu
            % do usuwania paska z obrazu (naokolo)
            % Funkcja imcrop przyjmuje za poczatek ukladu punkt naokolo,naokolo.
            % Nastepnie odejmuje sie -(2*naokolo-1), gdyz 1*naokolo to brzeg !!

            if (naokolo<0)
                errordlg('Prosze podac wartosc brzegu >= 0','Podaj prawidlowy brzeg');
                return;
            elseif ((x<=2*naokolo) | (y<=2*naokolo))
                errordlg('Zostala podana za duza wartosc brzegu do usuniecia','BLAD');
                return;
            elseif (naokolo==0)
                %%%
                if ((YObrazu>0) & (XObrazu>0))
                    if ((XObrazu ~=x) | (YObrazu ~=y))                % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);      % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                          % pokazanie obrazu w nowym oknie
                    if ((rodzajszumu==1)|(rodzajszumu==2))
                        zaszumiony=imnoise(szary,rodzaj,Wartosc);
                    elseif (rodzajszumu==3)
                        zaszumiony=imnoise(szary,rodzaj,Srednia,Wariacja);
                    elseif ((rodzajszumu==4)|(rodzajszumu==5)|(rodzajszumu==7)|(rodzajszumu==8))
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Wartosc);                        
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    elseif (rodzajszumu==6|rodzajszumu==9)
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Pionowa,Pozioma);
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    else
                        errordlg('Za duzo wprowdzonych zmiennych, przy wynik, info dla mnie','Blad');
                        return;
                    end
                    plikdozapisu=strcat(docelowykatalog,proponowana,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
                    imwrite(zaszumiony,plikdozapisu);                              % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                            % bez skalowonia
                    %figure;  imshow(szary);                                       % pokazanie obrazu w nowym oknie
                    if ((rodzajszumu==1)|(rodzajszumu==2))
                        zaszumiony=imnoise(szary,rodzaj,Wartosc);
                    elseif (rodzajszumu==3)
                        zaszumiony=imnoise(szary,rodzaj,Srednia,Wariacja);
                    elseif ((rodzajszumu==4)|(rodzajszumu==5)|(rodzajszumu==7)|(rodzajszumu==8))
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Wartosc);                        
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    elseif (rodzajszumu==6|rodzajszumu==9)
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Pionowa,Pozioma);
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    else
                        errordlg('Za duzo wprowdzonych zmiennych, przy wynik, info dla mnie','Blad');
                        return;
                    end
                    plikdozapisu=strcat(docelowykatalog,proponowana,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
                    imwrite(zaszumiony,plikdozapisu);                              % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                %%%
                if ((YObrazu > 0) & (XObrazu > 0))
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    [y,x]=size(szary);                                 % rozmiar obrazu
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    if ((rodzajszumu==1)|(rodzajszumu==2))
                        zaszumiony=imnoise(szary,rodzaj,Wartosc);
                    elseif (rodzajszumu==3)
                        zaszumiony=imnoise(szary,rodzaj,Srednia,Wariacja);
                    elseif ((rodzajszumu==4)|(rodzajszumu==5)|(rodzajszumu==7)|(rodzajszumu==8))
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Wartosc);
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    elseif (rodzajszumu==6|rodzajszumu==9)
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Pionowa,Pozioma);
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    else
                        errordlg('Za duzo wprowdzonych zmiennych, przy wynik, info dla mnie','Blad');
                        return;
                    end
                    plikdozapisu=strcat(docelowykatalog,proponowana,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
                    imwrite(zaszumiony,plikdozapisu);                      % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                      % bez skalowonia
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    if ((rodzajszumu==1)|(rodzajszumu==2))
                        zaszumiony=imnoise(szary,rodzaj,Wartosc);
                    elseif (rodzajszumu==3)
                        zaszumiony=imnoise(szary,rodzaj,Srednia,Wariacja);
                    elseif ((rodzajszumu==4)|(rodzajszumu==5)|(rodzajszumu==7)|(rodzajszumu==8))
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Wartosc);
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    elseif (rodzajszumu==6|rodzajszumu==9)
                        [zaszumiony,gestosclinii]=linie(szary,rodzaj,Pionowa,Pozioma);
                        if(gestosclinii<=0)|(gestosclinii>1)
                            errordlg('Obliczona gestosc linii spoza zakresu','Blad');
                            return;
                        end
                        gestosclinii=mat2str((gestosclinii),4); % W domyslnej nazwie nie moze byc "." !!
                        gestosclinii(1,2)=',';                  % gestosclinii pobiera jako string z funkcji linie.m
                        proponowana=[docelowanazwa,gestosclinii,'-'];   % gdyz ucina nazwe za kropka !!
                    else
                        errordlg('Za duzo wprowdzonych zmiennych, przy wynik, info dla mnie','Blad');
                        return;
                    end
                    plikdozapisu=strcat(docelowykatalog,proponowana,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
                    imwrite(zaszumiony,plikdozapisu);                      % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end

    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&   KONIEC   &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&   KONIEC   &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&   KONIEC   &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%


% --- Szary->brzegi->rozmiar>widmo.
function pushbutton10_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg');  %sciezka
    zlistowane=dir(wskazanepliki);                  % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                     % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa','widmo');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';      % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0'});          % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                    % do usuniecia brzegu

        % operacje na plikach i obrazach
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            szary=imread(wczytywany);    % wczytanie szarego pliku z listowania
            % figure; imshow (obraz);     % pokazanie obrazu w nowym oknie
            % plik z widma musi zostac zapisany jako *.mat, usunac *.jpg i
            % wstawic *.mat
            dlugosc=(length(nazwapliku)-4);
            nazwapliku=[nazwapliku(1:dlugosc),'.jpg'];

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x]=size(szary);           % rozmiar obrazu
            % do usuwania paska z obrazu (naokolo)
            % Funkcja imcrop przyjmuje za poczatek ukladu punkt 'naokolo,naokolo'.
            % Nastepnie odejmuje sie (2*naokolo-1), gdyz 1*naokolo to brzeg !!

            if (naokolo<0)
                errordlg('Prosze podac wartosc brzegu >= 0','Podaj prawidlowy brzeg');
                return;
            elseif ((x<=2*naokolo) | (y<=2*naokolo))
                errordlg('Zostala podana za duza wartosc brzegu do usuniecia','BLAD');
                return;
            elseif (naokolo==0)
                %%%
                if ((YObrazu>0) & (XObrazu>0))
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    amplituda=widmo(szary);                            % wyznaczanie widma obrazu                    
                    imwrite(amplituda,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    amplituda=widmo(szary);                            % wyznaczanie widma obrazu                    
                    imwrite(amplituda,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                %%%
                if ((YObrazu > 0) & (XObrazu > 0))
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    [y,x]=size(szary);                                 % rozmiar obrazu
                    if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                        szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                    end
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    amplituda=widmo(szary);                            % wyznaczanie widma obrazu                    
                    imwrite(amplituda,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                    szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                    %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                    amplituda=widmo(szary);                            % wyznaczanie widma obrazu                    
                    imwrite(amplituda,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                else
                    errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                    return;
                end
                %%%
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        end
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Mieszaj pliki.
function pushbutton11_Callback(hObject, eventdata, handles)

rodzajoperacji = get(handles.popupmenu2,'Value');
switch rodzajoperacji
    case 1
        proponowana='dodany do katalogu';
    case 2
        proponowana='przeniesiony do katalogu';
end

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    wskazanepliki=strcat(wskazanykatalog,'*.jpg');  % sciezka
    zlistowane=dir(wskazanepliki);                  % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                     % obliczanie ilosci plikow w wskazanykatalog

    [docelowanazwa,docelowykatalog] = uiputfile('*.jpg','Pliki zapisac pod nazwa',proponowana);
    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);        

        % Aby unikac konfiktu podczas generowania losowych nazw plikow,
        % nalezy sie upewnic ze program przeniesie pliki do katalogu tmp.
        % Procedura eliminuje problem z nadpisaniem plikow. Zapobiega takze
        % wystepowaniu kilku kopi tych samych pod roznymi nazwami. Gdy np. kopiuje sie
        % plik 00A.jpg na 001.jpg wtedy sa dwa te same pliki w jednym katalogu.
        Lwskazanykatalog=length(wskazanykatalog); % dlugosc sciezki wskazanego katalogu do odczytu plikow
        Ldocelowykatalog=length(docelowykatalog); % dlugosc sciezki wskazanego katalogu do zapisanie plikow
        % Sprawdzenie warunku w/w
        if(Lwskazanykatalog==Ldocelowykatalog) % jesli dlugosc nazwy katalogow jest rowna.
            % Jesli (suma(jedynek)==(Lwskazanykatalog)) i (proponowana == 1),
            % procedura zapobiega kopiowaniu tych samych plikow w tym samym katalogu.
            if(((Lwskazanykatalog)==(sum(wskazanykatalog==docelowykatalog))) & (rodzajoperacji==1)) 
                errordlg('Prosze wybrac inny katalog do zapisania plikow. Kopiowane pliki musza zostac zapisane w innym katalogu niz zrodlowy. Skorzytaj z opcji "przenies do katalogu"','Blad');
                return;
            end
        end

        tmpkatalog=[docelowykatalog,'tmp\'];       % sciezka do katalogu tymczasowego
        [status,wiadomosc]=mkdir(tmpkatalog);      % zaklada katalog /jak w UNIX
        
        % Jesli istnieje starszy tmpkatalog, nalezy go recznie usunac-
        % zabezpiecza to przed nadpisaniem starszych plikow.
        if(length(wiadomosc)~=0)
            infotmp=['Przerwano procedure miesznia plikow. Istnieje poprzedni pomocniczy katalog "tmp" w "',docelowykatalog,'"   Prosze usunac starszy katalog "tmp"'];
            errordlg(infotmp,'Usun katalog tmp');
            return;
        end

        % Kopiuje/Przenosi pliki z katalogu wskazanego (zrodlowego- jesli sa) do tmpkatalog.
        if(Nplikow>0)
            for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
                nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
                zrodlowy=(strcat(wskazanykatalog,nazwapliku));
                plikdozapisu=[sprintf('%08d.jpg',(n))];
                docelowy=[tmpkatalog,plikdozapisu];                
                if(rodzajoperacji==1)
                    copyfile(zrodlowy,docelowy)
                elseif(rodzajoperacji==2)
                    movefile(zrodlowy,docelowy)
                else
                    errordlg('Wybrano z menu nieistniejac¹ procedure','Blad');
                    return;
                end                
            end
        end
        
        % Procedura listowania "docelowykatalog" musi byc po
        % "Kopiuje/Przenosi". W tym miejscu unika sie konfiliktu nazw 
        % gdy "Przenosi" sie nieistniejace pliki z katalogu
        % (wskazanykatalog==docelowykatalog)
        docelowepliki=strcat(docelowykatalog,'*.jpg'); % sciezka
        dolistowane=dir(docelowepliki);                % listowanie zawartosci katalogu
        doplikow=length(dolistowane);                  % obliczanie ilosci plikow w docelowykatalog
        
        % Przenosi pliki (jesli sa) z katalogu docelowego do tmpkatalog
        if(doplikow>0)
            for n = 1:doplikow % operacja na kolejnym pliku *.jpg
                nazwapliku=(dolistowane(n).name);  % nazwa pliku "n" z listowania
                zrodlowy=(strcat(docelowykatalog,nazwapliku));
                plikdozapisu=[sprintf('%08d.jpg',(Nplikow+n))];
                docelowy=[tmpkatalog,plikdozapisu];
                movefile(zrodlowy,docelowy);
            end
        end
        
        % listowanie plikow w katalogu tmpkatalog
        tmppliki=strcat(tmpkatalog,'*.jpg');   % sciezka do katalogu z plikami
        tmplistowane=dir(tmppliki);            % listowanie zawartosci katalogu
        tmpplikow=length(tmplistowane);        % obliczanie ilosci plikow
        
        if((tmpplikow)~=(Nplikow+doplikow))
            infotmp=['Przerwano procedure mieszania plikow. Liczba plikow w katalogu tymczasowym po przeliczeniu jest inna ni¿ (wskazane pliki + docelowe pliki) "',tmpkatalog,'"'];
            errordlg(infotmp,'Nie zgadza sie liczba plikow ');
            return;
        end

        losowe=randperm(tmpplikow);
        for n = 1:tmpplikow    % operacja na kolejnym pliku *.jpg
            nazwapliku=(tmplistowane(losowe(n)).name);  % nazwa pliku "n" z listowania
            tmpplik=(strcat(tmpkatalog,nazwapliku));
            plikdozapisu=[docelowanazwa,sprintf('%08d.jpg',(n))];
            przenoszony=[docelowykatalog,plikdozapisu];
            movefile(tmpplik,przenoszony); % przenosi
        end
        
        pusty=length(dir(tmpkatalog));
        % Jesli zosta³y jakies pliki w tmpkatalog, nalezy je recznie usunac-
        % zabezpiecza to przed ewentualnym usunieciem zawartosci katalogu.
        if(pusty~=2) % Maja byc tylko "." i "..", sa tylko w podkatalogach np. tmp
            infotmp=['W katalogu pomocniczym "',tmpkatalog,'" pozostaly pliki. Procedura usuwanie katalogu "tmp" zostala przerwana.'];
            errordlg(infotmp,'Usun tmp');
            return;
        end
        
        rmdir(tmpkatalog); % usuwa pusty katalog
        
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ %
if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    % ---------------------------------------------------- %
    % Rozmiar kolejnych obrazow musi byc jednakowy, aby zrobic z nich macierz wektorow.
    pierwszy=[wskazanykatalog,wskazanyplik]; % Pobiera sciezka i nazwe wskazanego pliku.
    [Ywzka,Xwzka]=size(imread(pierwszy)); % Rozmiar wskazanego obrazu, bedzie on porownywany z "zlistowane".
    % ---------------------------------------------------- %
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog] = uiputfile('*.mat','Pliki zapisac pod nazwa','kolumny');
    % dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        % ---------------------------------------------------- %
        plikdozapisu=strcat(docelowykatalog,docelowanazwa);   % katlog docelowy + nazwa pliku  
        % ---------------------------------------------------- %
        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2       
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        
        macierzZobrazami=[]; % macierz obrazow
        % operacje na plikach i obrazach
        for n = 1:Nplikow                % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            szary=imread(wczytywany);    % wczytanie pliku z listowania
            
            [y,x]=size(szary);           % rozmiar obrazu
            if((x~=Xwzka) | (y~=Ywzka))
                errordlg('Przynajmniej jeden plikow ma inny rormiar niz pozostale. Przerwano procedure.','Ostrzezenie');
                return;
            end
            % ---------------------------------------------------- %
            if((XObrazu==0) & (YObrazu==0))
                kolumna=szary(:); 
            elseif((XObrazu>0) & (YObrazu>0))
                if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                    szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                end
                kolumna=szary(:);  
            else
                errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                return;
            end
            % ---------------------------------------------------- %
            macierzZobrazami=[macierzZobrazami kolumna];
        end       
        save(plikdozapisu,'macierzZobrazami');
else
    errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
% ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ %


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.mat','Wskaz pliki mat');
if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    % ---------------------------------------------------- %
    [docelowanazwa,docelowykatalog] = uiputfile('*.mat','Pliki zapisac pod nazwa');
    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        % ---------------------------------------------------- %
        wskazanymat=strcat(wskazanykatalog,wskazanyplik);   % sciezka
        plikdozapisu=strcat(docelowykatalog,docelowanazwa); % katlog docelowy + nazwa pliku
        
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        zawartosc=whos('-file',wskazanymat); % listuje zawartosc pliku .mat
        numer=menu('Wybierz zmienna',zawartosc.name); % wybor nr macierzy  
        if(numer==0)
            return;
        end
        wybrana=zawartosc(numer).name; % wybiera wskazana wartosc
        % load(wskazanymat,wybrana);
        load(wskazanymat);
        % wybrana=(eval(sprintf('%s',strcat(wybrana))));    
        wybrana=(eval(wybrana));
        [y,x]=size(wybrana); % szerokosc macierzy
        pomieszana=wybrana(:,(randperm(x))); % miesza kolumny  
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        
        % **************************************************** %
        % jesli jest reszta to j¹ czysci
        reszta=[];
        if (sum(ismember((who('-file',wskazanymat)),'reszta'))==1)
            reszta=struct2array(load(wskazanymat,'reszta'));
            [y x]=size(reszta);
            reszta=reszta(:,(randperm(x)));
        end
        % **************************************************** %
        
        if(isempty(reszta))
            save(plikdozapisu,'pomieszana');
            % save(plikdozapisu,zawartosc.name,'pomieszana'); % % stare + pomieszane
        else
            save(plikdozapisu,'pomieszana','reszta'); % pomieszane + reszta
            % save(plikdozapisu,zawartosc.name,'pomieszana','reszta'); % stare + pomieszane + reszta
        end    
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end





% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.jpg','Wskaz pliki jpg');

if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    % ---------------------------------------------------- %
    % Rozmiar kolejnych obrazow musi byc jednakowy, aby zrobic z nich macierz wektorow.
    pierwszy=[wskazanykatalog,wskazanyplik]; % Pobiera sciezka i nazwe wskazanego pliku.
    pierwszy=imread(pierwszy); % 
    [Ywzka,Xwzka]=size(pierwszy); % Rozmiar wskazanego obrazu, bedzie on porownywany z "zlistowane".
    % ---------------------------------------------------- %
    wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
    zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
    Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
    [docelowanazwa,docelowykatalog]=uiputfile('*.jpg','Pliki zapisac pod nazwa','wyciete');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))

        % ---------------------------------------------------- %
        rodzajoperacji = get(handles.popupmenu3,'Value');
        switch rodzajoperacji
            case 1
                pyt{1} = 'Wytnij- szerokosc obrazu';                       % tekst przy polu do wprowadzenia zmiennej 1
                pyt{2} = 'Wytnij- wysokosc obrazu';                        % tekst przy polu do wprowadzenia zmiennej 2
                tytul  = 'Podaj rozmiar obrazu';                   % nazwa okna
                wynik  = inputdlg(pyt, tytul, 1, {'30','30'});     % wywolanie okna dialogowego
                while (isempty(wynik))
                    return;
                end
                XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
                YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
                while (isempty(XObrazu)|isempty(YObrazu)|(XObrazu<=0|YObrazu<=0)|XObrazu>Xwzka|YObrazu>Ywzka)
                    errordlg('Podaj prawidlowy rozmiar obrazu do wyciecia','BLAD');
                    return;
                end
                SrodekX=Xwzka/2; SrodekY=Ywzka/2; % Srodkowe obrazu
                x1=floor(SrodekX-XObrazu/2); y1=floor(SrodekY-YObrazu/2);
                wspolrzedne=[x1+1 y1+1 XObrazu-1 YObrazu-1];
            
            case 2
                pyt{1} = 'Podaj poczatek X1'; % tekst przy polu do wprowadzenia zmiennej 1
                pyt{2} = 'Podaj poczatek Y1'; % tekst przy polu do wprowadzenia zmiennej 2
                pyt{3} = 'Podaj szerokosc obrazu';
                pyt{4} = 'Podaj wysokosc obrazu';
                tytul  = 'Podaj rozmiar obrazu';                   % nazwa okna
                wynik  = inputdlg(pyt, tytul, 1, {'1','5','1','5'});     % wywolanie okna dialogowego
                while (isempty(wynik))
                    return;
                end
                XObrazu=(str2num(cell2mat(wynik(1))));   
                YObrazu=(str2num(cell2mat(wynik(2))));   
                Szer=(str2num(cell2mat(wynik(3))));
                Wyso=(str2num(cell2mat(wynik(4)))); % wprowadzane
                war1=(isempty(XObrazu)|isempty(YObrazu)|isempty(Szer)|isempty(Wyso));
                war2=(XObrazu>Xwzka)|(YObrazu>Ywzka)|(XObrazu <=0 | Szer<=0)|(YObrazu <=0 | Wyso <=0);
                war3=(XObrazu+Szer>Xwzka+1)|(YObrazu+Wyso>Ywzka+1);
                while (war1==1) |(war2==1) | (war3==1)
                    errordlg('Podaj prawidlowy rozmiar i wspolrzene obrazu do wyciecia','BLAD');
                    return;
                end
                wspolrzedne=[XObrazu YObrazu Szer-1 Wyso-1]; % wtedy ma wprowadzony rozmiar obrazu                 
                
            case 3
                figure
                imshow(pierwszy);
                [tmpobraz,wspolrzedne]=imcrop(pierwszy);
                close;
                if (wspolrzedne(1,3)==0 | wspolrzedne(1,4)==0)
                     errordlg('Prosze nacisnac lewy przycisk myszki i przecignac na obrazie','BLAD');
                     return
                end
        end
        % ---------------------------------------------------- %
        
        % operacje na plikach i obrazach
        %%%
        for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
            nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
            wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
            plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
            szary=imread(wczytywany);    % wczytanie pliku z listowania

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [y,x]=size(szary); % rozmiar obrazu, % pom gdy kolorowy
            if((x~=Xwzka) | (y~=Ywzka))
                errordlg('Przynajmniej jeden plikow ma inny rormiar niz pozostale. Przerwano procedure.','Ostrzezenie');
                return;
            end
            
            wyciety=imcrop(szary,wspolrzedne);
            imwrite(wyciety,plikdozapisu);

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
        %%%
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.jpg"','Prosze wskazac plik');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- wyjscia.
function pushbutton15_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.mat','Wskaz pliki mat');
if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    % ---------------------------------------------------- %
    [docelowanazwa,docelowykatalog] = uiputfile('*.mat','Pliki zapisac pod nazwa');
    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))        
        % ---------------------------------------------------- %
        wskazanymat=strcat(wskazanykatalog,wskazanyplik);   % sciezka
        plikdozapisu=strcat(docelowykatalog,docelowanazwa); % katlog docelowy + nazwa pliku
       
        % ---------------------------------------------------- %        
        %%        
        pyt{1} = 'Wyjscia (0 | 1- ok konczy)';      % tekst przy polu do wprowadzenia zmiennej 1
        tytul  = 'Dodaj wyjscia Buduj';                  % nazwa okna
        wprowadzone = inputdlg(pyt, tytul, 1, {'0'});       % wywolanie okna dialogowego
        while (isempty(wprowadzone))
            return;
        end
        wprowadzone=(str2num(cell2mat(wprowadzone(1))));
        %%%
        while (isempty(wprowadzone))
            errordlg('Wprowadz kolejno  po spacji 0 lub 1, aby wektor mogl byc transponowany.','BLAD');
            return;
        end
        %%%           
        dlugosc=length(wprowadzone);
        for n=1:dlugosc
            if ((wprowadzone(1,n)~=0) & (wprowadzone(1,n)~=1))
                errordlg('W wektorze podano wartosc rozna od 0 lub 1','BLAD');
                return;
            end
        end
        %%
        % ---------------------------------------------------- %
               
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        zawartosc=whos('-file',wskazanymat); % listuje zawartosc pliku .mat
        numer=menu('Wybierz zmienna',zawartosc.name); % wybor nr macierzy
        if(numer==0)
            return;
        end
        wybrana=zawartosc(numer).name; % wybiera wskazana wartosc
        load(wskazanymat,wybrana);
        % load(wskazanymat);
        % wybrana=(eval(sprintf('%s',strcat(wybrana))));
        wybrana=(eval(wybrana));        
        [y,x]=size(wybrana); % szerokosc macierzy
        
        wprowadzone=wprowadzone'; % wprowadzone wyjscia
        wyjscia=[]; 
        if(x>0)           
            for(n=1:x)
                wyjscia=[wyjscia wprowadzone];
            end
            wyjscia=[wybrana ; wyjscia];
        else
            errordlg('Macierz jest pusta','BLAD');
            return;
        end
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %

        save(plikdozapisu,'wyjscia'); % zapisuje wymieszana wartosc w oddzielnym pliku
        %save(plikdozapisu,zawartosc.name,'wyjscia'); % zapisuje wymieszana  wartosc w oddzielnym pliku
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end


% --- buduj mieszaj
function pushbutton16_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.mat','Wskaz pierwszy pliki mat');
if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    [wskazanyplik2,wskazanykatalog2] = uigetfile('*.mat','Wskaz drugi pliki mat');
    if ((sum(wskazanyplik2)~=0) & (sum(wskazanykatalog2)~=0))
        
        % ---------------------------------------------------- %
        [docelowanazwa,docelowykatalog] = uiputfile('*.mat','Pliki zapisac pod nazwa');
        if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
            % ---------------------------------------------------- %
            wskazanymat1=strcat(wskazanykatalog,wskazanyplik);   % sciezka
            wskazanymat2=strcat(wskazanykatalog2,wskazanyplik2); % sciezka 2
            plikdozapisu=strcat(docelowykatalog,docelowanazwa);  % katlog docelowy + nazwa pliku
            
            %%
            % spytac sie promotor ? jak napisac krotko to pl
            pyt{1} = 'Mieszaj kolumny (T/N). UWAGA.: T miesza cala macierz na koncu. Gdy wybrano N (kolumn macierzy1~0 | kolumn macierzy2~0), wtedy wybiera n losowych kolumn z macierz1 | z macierz2 buduje niepomieszana miedzy soba macierz [macierz1 macierz2]';      % tekst przy polu do wprowadzenia zmiennej 1
            pyt{2} = 'Ile wylosowanych kolumn z macierzy 1 (0- wszystkie)';      % tekst przy polu do wprowadzenia zmiennej 2
            pyt{3} = 'Ile reszty kolumn macierzy 1 (0- wszystkie z reszty - jesli pozostana. Zawsze zbudowana macierz z cala miesza (reszta + stara), jesli jest)';
            pyt{4} = 'Ile wylosowanych kolumn z macierzy 2 (0- wszystkie)';      % tekst przy polu do wprowadzenia zmiennej 3            
            pyt{5} = 'Ile reszty kolumn macierzy 2 (0- wszystkie z reszty - jesli pozostana. Zawsze zbudowana macierz z cala miesza (reszta + stara), jesli jest)';
            tytul  = 'Mieszaj kolumny ? / Buduj';                  % nazwa okna
            wynik  = inputdlg(pyt, tytul, 1, {'T','0','0','0','0'});       % wywolanie okna dialogowego
            while (isempty(wynik))
                return;
            end
            
            mieszaj=lower(char(wynik(1))); % tak ma byc ten warunek
            if ((strcmp(mieszaj,'t')|strcmp(mieszaj,'n'))~=1)
                errordlg('Prosze wybrac T/N','BLAD');
                return;
            end
            
            kolumn1=(str2num(cell2mat(wynik(2))));
            resztamac1=(str2num(cell2mat(wynik(3))));
            kolumn2=(str2num(cell2mat(wynik(4)))); % wprowadzane            
            resztamac2=(str2num(cell2mat(wynik(5))));
            while (isempty(kolumn1)|isempty(kolumn2)|isempty(resztamac1)|isempty(resztamac2))
                errordlg('Wprowadz liczbe kolumn dla macierzy trenujacej oraz reszty','BLAD');
                return;
            end

            if((kolumn1==0&(resztamac1>0))|(kolumn2==0&(resztamac2>0))|(kolumn1<0|kolumn2<0|resztamac1<0|resztamac2<0))
                errordlg('Musisz wprowadzic liczbe kolumn dla macierzy trenujacej oraz reszty ~0 | > 0','BLAD');
                return;
            end            
            %%
                                 
            % ---------------------------------------------------- %
            % ---------------------------------------------------- %                                        
            % ************************** %
            % miesza reszty z poprzednich plikow 
            stara1=[];stara2=[];
            if (sum(ismember((who('-file',wskazanymat1)),'reszta'))==1)
                stara1=struct2array(load(wskazanymat1,'reszta'));
                % dac znak komentarza "%" jak ktos juz wie
                msgbox('W pierwszym pliku jest reszta. Reszta zostanie dolozona do macierzy. Linia 1738.','Ostrze¿enia','warn');
            end
            if (sum(ismember((who('-file',wskazanymat2)),'reszta'))==1)
                stara2=struct2array(load(wskazanymat2,'reszta'));
                % dac znak komentarza "%" jak ktos juz wie
                msgbox('W pliku pliku jest reszta. Reszta zostanie dolozona do macierzy. Linia 1742.','Ostrze¿enia','warn');
            end
            
            % sprawdza rozmiar poprzedniej  reszty (do symulowania)
            [yy1 xx1]=size(stara1);[yy2 xx2]=size(stara2);           
            if(isempty(stara1)|isempty(stara2))
                stara=[stara1 stara2];
            elseif(yy1==yy2)
                stara=[stara1 stara2];
            else
                tekst=['Nie zgadza sie liczba z kolumn macierzy 1 i 2 do symulowania (Poprzedniej macierzy). Nie zostania dodane poprzednie macierze do do zbioru testujacego. Zmierzona liczba kolumn1= ',num2str(yy1),', kolumn2= ',num2str(yy2)];
                errordlg(tekst,'Nie zgadza sie liczba kolumn');
                return;
            end
            % ************************** %
            
            zawartosc1=whos('-file',wskazanymat1); % listuje zawartosc pliku .mat
            zawartosc2=whos('-file',wskazanymat2); % listuje zawartosc pliku .mat    
            % zmienna 1
            numer1=menu('Wybierz macierz z pliku 1',zawartosc1.name); % wybor nr macierzy
            if(numer1==0)
                return;
            end
            wybrana1=zawartosc1(numer1).name; % wybiera wskazana wartosc
            nazwa1=wybrana1;
            load(wskazanymat1,wybrana1);
            wybrana1=(eval(wybrana1));
            % zmienna 2
            numer2=menu('Wybierz macierz z pliku 2',zawartosc2.name); % wybor nr macierzy
            if(numer2==0)
                return;
            end
            wybrana2=zawartosc2(numer2).name; % wybiera wskazana wartosc
            nazwa2=wybrana2;
            load(wskazanymat2,wybrana2);
            wybrana2=(eval(wybrana2));
            % ---------------------------------------------------- %
            % ---------------------------------------------------- %

            % ---------------------------------------------------- %
            % Sprawdza czy wybrano ta sama zmienna z tego samego pliku %
            if((strcmp(wskazanymat1,wskazanymat2))&(strcmp(nazwa1,nazwa2)))
                errordlg('Wybrano ta sama zmienna z tego samego pliku','Ta sama zmiennna');
                return;
            end
            % ---------------------------------------------------- %
            
            
            [y1,x1]=size(wybrana1); % wierszy macierzy1
            [y2,x2]=size(wybrana2); % wierszy macierzy2
            
            reszta1=[];reszta2=[];
            %%%%
            % macierz 1
            if((resztamac1>0) & (kolumn1+resztamac1 <=x1))
                do1=kolumn1+1:kolumn1+resztamac1;
            elseif((resztamac1==0)&(kolumn1<x1))
                do1=kolumn1+1:x1;
            elseif(resztamac1==0)
                do1=[];
            else
                errordlg('Podano zdyt duzo kolumn z reszty 1','Nie zgadza sie liczba kolumn');
                return;
            end
            
            if(kolumn1==0)                
                % nic do roboty
            elseif(kolumn1>0 & kolumn1<=x1)
                pomieszana1=wybrana1(:,(randperm(x1))); % miesza kolumny
                wybrana1=pomieszana1(:,1:kolumn1);
                if(kolumn1<x1)
                    reszta1=pomieszana1(:,do1);
                end
            else
                info1=['Nie zgadza sie liczba kolumn macierzy 1. Wprowadzona liczba kolumn ',num2str(kolumn1),', rzeczywista liczba kolumn ',num2str(x1),' macierzy'];
                errordlg(info1,'Nie zgadza sie liczba kolumn');
                return;
            end
            %%%%
            % macierz 2            
            if((resztamac2>0) & (kolumn2+resztamac2 <=x2))
                do2=kolumn2+1:kolumn2+resztamac2;
            elseif((resztamac2==0)&(kolumn2<x2))
                do2=kolumn2+1:x2;
            elseif(resztamac2==0)
                do2=[];
            else
                errordlg('Podano zdyt duzo kolumn z reszty 2','Nie zgadza sie liczba kolumn');
                return;
            end
            
            if(kolumn2==0)  
                % nic do roboty
            elseif(kolumn2>0 & kolumn2<=x2)
                pomieszana2=wybrana2(:,(randperm(x2))); % miesza kolumny
                wybrana2=pomieszana2(:,1:kolumn2);
                if(kolumn2<x2)
                    reszta2=pomieszana2(:,do2);                                       
                end
            else
                info2=['Nie zgadza sie liczba kolumn macierzy 2. Wprowadzona liczba kolumn ',num2str(kolumn2),', rzeczywista liczba kolumn ',num2str(x2),' macierzy'];
                errordlg(info2,'Nie zgadza sie liczba kolumn');
                return;
            end
            %%%%

            %% @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ %%
            [yy1 xx1]=size(reszta1); [yy2 xx2]=size(reszta2);
            if(isempty(reszta1)|isempty(reszta2))
                reszta=[reszta1 reszta2];
            elseif(yy1==yy2)
                reszta=[reszta1 reszta2];
            else
                tekst=['Nie zgadza sie liczba z kolumn macierzy 1 i 2 do symulowania (RESZTY). Nie zostania dodane poprzednie macierze do do zbioru testujacego. Zmierzona liczba kolumn1= ',num2str(yy1),', kolumn2= ',num2str(yy2)];
                errordlg(tekst,'Nie zgadza sie liczba kolumn');
                % return
            end
            % dodaje do budowanej reszty poprzdnia wartosc
            [yy1 xx1]=size(reszta); [yy2 xx2]=size(stara);
            if(isempty(reszta)|isempty(stara))
                reszta=[reszta stara];
                if(~(isempty(reszta)))
                    [y x]=size(reszta);
                    reszta=reszta(:,(randperm(x)));
                end
            elseif(yy1==yy2)
                reszta=[reszta stara];
                [y x]=size(reszta);
                reszta=reszta(:,(randperm(x)));
            else
                tekst=['Nie zgadza sie liczba z kolumn macierzy 1 i 2 do symulowania (Poprzedniej macierzy i RESZTY). Nie zostania dodane poprzednie macierze do do zbioru testujacego. Zmierzona liczba kolumn1= ',num2str(yy1),', kolumn2= ',num2str(yy2)];
                errordlg(tekst,'Nie zgadza sie liczba kolumn');
                return
            end
            % ---------------------------------------------------- %
            % ---------------------------------------------------- %
            
            if(y1==y2)&(mieszaj =='t')
                zbudowana=[wybrana1 wybrana2];
                [y,x]=size(zbudowana);
                zbudowanawymieszana=zbudowana(:,(randperm(x)));
                if(isempty(reszta))
                    save(plikdozapisu,'zbudowanawymieszana'); % zapisuje wymieszana  wartosc w oddzielnym pliku
                else
                    save(plikdozapisu,'zbudowanawymieszana','reszta'); % zapisuje wymieszana  wartosc w oddzielnym pliku
                end
            elseif(y1==y2)&(mieszaj =='n')
                zbudowana=[wybrana1 wybrana2];
                if(isempty(reszta))
                    save(plikdozapisu,'zbudowana'); % zapisuje wymieszana  wartosc w oddzielnym pliku
                else
                    save(plikdozapisu,'zbudowana','reszta'); % zapisuje wymieszana  wartosc w oddzielnym pliku
                end
            else
                errordlg('Macierze maja rozn¹ liczbe wierszy','Nie zgadza sie liczba wierszy');
                return;
            end
            % ---------------------------------------------------- %
            
        else
            errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
        end
    else
        errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end



% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)

[wskazanyplik,wskazanykatalog] = uigetfile('*.mat','Wskaz pliki mat');
if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    % ---------------------------------------------------- %
    [docelowanazwa,docelowykatalog] = uiputfile('*.mat','Pliki zapisac pod nazwa','Dodane_Wygenerowane');
    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        % ---------------------------------------------------- %
        wskazanymat=strcat(wskazanykatalog,wskazanyplik);   % sciezka
        plikdozapisu=strcat(docelowykatalog,docelowanazwa); % katlog docelowy + nazwa pliku
        
        pyt{1} = 'Ile wygenerowac obrazów'; % tekst przy polu do wprowadzenia zmiennej 1
        tytul  = 'Podaj rozmiar obrazu';                   % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'1350'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        Ile=(str2num(cell2mat(wynik(1))));
        
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        zawartosc=whos('-file',wskazanymat); % listuje zawartosc pliku .mat
        numer=menu('Wybierz zmienna',zawartosc.name); % wybor nr macierzy  
        if(numer==0)
            return;
        end
        wybrana=zawartosc(numer).name; % wybiera wskazana wartosc
        % load(wskazanymat,wybrana);
        load(wskazanymat);
        % wybrana=(eval(sprintf('%s',strcat(wybrana))));    
        wybrana=(eval(wybrana));
        [y,x]=size(wybrana); % szerokosc macierzy
        wygenerowane=uint8(rand(y,Ile)*255);
        zwygenerowanymi=[wybrana wygenerowane];
        PomieszanaWygenerowanymi=zwygenerowanymi(:,(randperm(x+Ile))); % miesza kolumny  
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        
        % **************************************************** %
        % jesli jest reszta to j¹ czysci
        reszta=[];
        if (sum(ismember((who('-file',wskazanymat)),'reszta'))==1)
            reszta=struct2array(load(wskazanymat,'reszta'));
            [y x]=size(reszta);
            reszta=reszta(:,(randperm(x)));
        end
        % **************************************************** %
        
        if(isempty(reszta))
            save(plikdozapisu,'PomieszanaWygenerowanymi');
            % save(plikdozapisu,zawartosc.name,'pomieszana'); % % stare + pomieszane
        else
            save(plikdozapisu,'PomieszanaWygenerowanymi','reszta'); % pomieszane + reszta
            % save(plikdozapisu,zawartosc.name,'pomieszana','reszta'); % stare + pomieszane + reszta
        end    
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end




% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
rodzajszumu = get(handles.popupmenu1,'Value');

%%
[wskazanyplik,wskazanykatalog] = uigetfile('*.mat','Wskaz pliki mat');
if ((sum(wskazanyplik)~=0) & (sum(wskazanykatalog)~=0))
    % ---------------------------------------------------- %
    wskazanymat=strcat(wskazanykatalog,wskazanyplik);   % sciezka
    
%%    
    zawartosc=whos('-file',wskazanymat); % listuje zawartosc pliku .mat
    % zmienna 1
    numer=menu('Wybierz macierz z pliku',zawartosc.name); % wybor nr macierzy
    if(numer==0)
        return;
    end
    wybrana=zawartosc(numer).name; % wybiera wskazana wartosc
    nazwa=wybrana;
    load(wskazanymat,wybrana);
    wybrana=(eval(wybrana));
%%      

%%
    switch rodzajszumu
        case 1 % dla szumu impulsowego
            %%%
            pyt{1} = 'Gestosc szumu impulsowego (0-1)';              % tekst przy polu do wprowadzenia zmiennej 4
            tytul  = 'Szum sol i pieprz';                            % nazwa okna
            wynik  = inputdlg(pyt, tytul, 1, {'0.05'});  % wywolanie okna dialogowego
            while (isempty(wynik))
                return;
            end

            Wartosc=(str2num(cell2mat(wynik(1))));                   % GestoscSzumu
            
            pom1=mat2str(Wartosc,4);pom1(1,2)=','; % w domyslnej nazwie nie moze byc "." !!
            proponowana=['sol&pieprz-GestoscSzumu-',pom1,'-']; % gdyz ucina nazwe za kropka !!
            
            if (Wartosc >= 0) & (Wartosc <= 1)  % z zakresu 0 1
                ZaszumionaMacierz=imnoise(wybrana,'salt & pepper',Wartosc);
            else
                errordlg('Prosze podac poprana gestsosc szumu (0-1)','Blad');
                return;
            end
            %%%

        case 2 % dla szumu cetkowanego
            %%%
            pyt{1} = 'Wariacja (0-1)';                               % tekst przy polu do wprowadzenia zmiennej 4
            tytul  = 'Szum typu cetkowanego';                        % nazwa okna
            wynik  = inputdlg(pyt, tytul, 1, {'0.04'});  % wywolanie okna dialogowego
            while (isempty(wynik))
                return;
            end

            Wartosc=(str2num(cell2mat(wynik(1))));

            if (Wartosc >= 0) & (Wartosc <= 1)  % z zakresu 0 1
                ZaszumionaMacierz=imnoise(wybrana,'speckle',Wartosc);
                pom1=mat2str(Wartosc,4);pom1(1,2)=','; % w domyslnej nazwie nie moze byc "." !!
                proponowana=['cetkowany-Wariacji-',pom1,'-']; % gdyz ucina nazwe za kropka !!

            else
                errordlg('Prosze podac poprana wariacje (0-1)','Blad');
                return;
            end
            %%%

        case 3 % dla bialego szumu Gaussa
            %%%

            pyt{1} = 'Srednia szumu (0-1)';                             % tekst przy polu do wprowadzenia zmiennej 4
            pyt{2} = 'Wariacja szumu (0-1)';                            % tekst przy polu do wprowadzenia zmiennej 5
            tytul  = 'Bialy szum Gaussa';                               % nazwa okna
            wynik  = inputdlg(pyt, tytul, 1, {'0','0.01'}); % wywolanie okna dialogowego
            while (isempty(wynik))
                return;
            end

            Srednia=(str2num(cell2mat(wynik(1))));                   % srednia szumu
            Wariacja=(str2num(cell2mat(wynik(2))));                  % wariacja szumu

            if (((Srednia >= 0) & (Srednia <= 1)) & ((Wariacja >= 0) & (Wariacja <= 1)))  % z zakresu 0 1
                ZaszumionaMacierz=imnoise(wybrana,'gaussian',Srednia,Wariacja);
                pom1=mat2str(Srednia,4);pom1(1,2)=',';  % w domyslnej nazwie nie moze byc "." !!
                pom2=mat2str(Wariacja,4);pom2(1,2)=','; % gdyz ucina nazwe za kropka !!
                proponowana=['Gaussa-Sredniej-',pom1,'-Wariacji-',pom2,'-'];
            else
                errordlg('Prosze podac poprana gestsosc szumu (0-1)','Blad');
                return;
            end
            %%%
        otherwise
            errordlg('Tylo 3 pierwsze sa dostepne dla macierzy)','Blad');
            return;
    end

    %%

    [docelowanazwa,docelowykatalog] = uiputfile('*.mat','Pliki zapisac pod nazwa',proponowana);
    if ((sum(docelowanazwa)~=0) & (sum(docelowykatalog)~=0))
        plikdozapisu=strcat(docelowykatalog,docelowanazwa); % katlog docelowy + nazwa pliku
        save(plikdozapisu,'ZaszumionaMacierz');
    
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end

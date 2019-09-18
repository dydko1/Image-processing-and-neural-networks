function varargout = hurtowo(varargin)
% HURTOWO M-file for hurtowo.fig
%      HURTOWO, by itself, creates a new HURTOWO or raises the existing
%      singleton*.
%
%      H = HURTOWO returns the handle to a new HURTOWO or the handle to
%      the existing singleton*.
%
%      HURTOWO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HURTOWO.M with the given input arguments.
%
%      HURTOWO('Property','Value',...) creates a new HURTOWO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hurtowo_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hurtowo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help hurtowo

% Last Modified by GUIDE v2.5 11-Jul-2007 17:09:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @hurtowo_OpeningFcn, ...
    'gui_OutputFcn',  @hurtowo_OutputFcn, ...
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


% --- Executes just before hurtowo is made visible.
function hurtowo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hurtowo (see VARARGIN)

% Choose default command line output for hurtowo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hurtowo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hurtowo_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Konwertowanie avi->jpg.
function pushbutton1_Callback(hObject, eventdata, handles)

% ---
disp('Tu byla funkcja 1'); % ;)
% ---


% --- Kolorowy->szary->brzegi->rozmiar.
function pushbutton2_Callback(hObject, eventdata, handles)



% --- Kolorowy->szary->brzegi->rozmiar>odbicie  X.
function pushbutton3_Callback(hObject, eventdata, handles)



% --- Kolorowy->szary->brzegi->rozmiar->odbicie  Y.
function pushbutton4_Callback(hObject, eventdata, handles)


% --- Usuwanie uszkodzonych klatek obrazu szarego.
function pushbutton5_Callback(hObject, eventdata, handles)

%%
% Mail autora miroslaw.dyduch@gmail.com
%%

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)

    % ---------------------------------------------------- %
    % ---------------------------------------------------- %
    katalogi=dir(wskazanykataloG);
    katalogow=length(katalogi);      
    for n=1:katalogow
        if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
            podkataloG=katalogi(n).name;
            podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');

            wskazanykatalog=podkataloGu;
            % ---------------------------------------------------- %
            % ---------------------------------------------------- %

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

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        end
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end

% --- Zmiana rozmiaru obrazu, usuwanie brzegow.
function pushbutton6_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

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

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(podkataloGu);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='hurtowo';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow

                % ---------------------------------------------------- %
                % ---------------------------------------------------- %

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
            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Lustrzane odbicie obrazu szarego wzdluz osi  X.
function pushbutton7_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(podkataloGu);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='hurtowo';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
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
            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Lustrzane odbicie obrazu szarego wzdluz osi  Y.
function pushbutton8_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(podkataloGu);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='hurtowo';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
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
            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
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
            proponowana=['hurtowa-Sol&pieprz-GestoscSzumu-',pom1,'-']; % gdyz ucina nazwe za kropka !!
            docelowanazwa=proponowana;
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
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.01'});  % wywolanie okna dialogowego
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
            proponowana=['hurtowa-Cetkowany-Wariacji-',pom1,'-']; % gdyz ucina nazwe za kropka !!
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-Gaussa-Sredniej-',pom1,'-Wariacji-',pom2,'-'];
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-PionoweCzarnyLinii-Powierzchni-'];
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-PoziomeCzarnyLinii-Powierzchni-'];
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-PionoweIPoziomeCzarnyLinii-Powierzchni-'];
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-PionoweLosowyKolorLinii-Powierzchni-'];
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-PoziomeLosowyKolorLinii-Powierzchni-'];
            docelowanazwa=proponowana;
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
            proponowana=['hurtowa-PionoweIPoziomeLosowyKolorLinii-Powierzchni-'];
            docelowanazwa=proponowana;
        else
            errordlg('Prosze podac poprana gestosc linii pionowych i poziomych, (0<linia<=1)','Blad');
            return;
        end
        %%%
end

% POLOWA

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);        
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(wskazanykataloG);
                l2=length(docelowypodkataloG);                
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');                        
                        return;
                    end
                end
                                
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow                
                % operacje na plikach i obrazach
                %%%

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

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end

%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&   KONIEC   &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&   KONIEC   &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%
%%%$$$$$$$$$$$$$$$$$$$$$$&&&&&&   KONIEC   &&&&&&$$$$$$$$$$$$$$$$$$$$$$%%%


% --- Szary->brzegi->rozmiar>widmo.
function pushbutton10_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)

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
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(wskazanykataloG);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='HurtowoWidma';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %
                % operacje na plikach i obrazach
                %%%

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

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
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

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)


        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(wskazanykataloG);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='hurtowoPomieszane';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow

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

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



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

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
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
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');

%                 l1=length(podkataloGu);
%                 l2=length(docelowypodkataloG);
%                 if(l2>=l1)
%                     if(strcmp(podkataloGu,docelowypodkataloG))
%                         errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
%                         return;
%                     elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
%                         errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
%                         return;
%                     end
%                 end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
%                 docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='-macierz.mat';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
                % dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);

                pierwszy=[wskazanykatalog,zlistowane(1).name]; % Pobiera sciezka i nazwe wskazanego pliku.
                [Ywzka,Xwzka]=size(imread(pierwszy)); % Rozmiar wskazanego obrazu, bedzie on porownywany z "zlistowane".

                % ---------------------------------------------------- %
                % plikdozapisu=strcat(docelowykatalog,docelowanazwa);   % katlog docelowy + nazwa pliku
                plikdozapisu=strcat(docelowykatalog,podkataloG,docelowanazwa);   % katlog docelowy + nazwa pliku
                % ---------------------------------------------------- %

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

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        %  UWAGA na ta procedure, inaczej zostala pomyslana 
        %  a inaczej ja przerobilem w hurtowo.m
        % 
        % ---------------------------------------------------- %
        
        katalogi1=dir(wskazanykataloG);
        katalogow1=length(katalogi1);
        
        for n=1:katalogow1
            if ((katalogi1(n).isdir)&(~(strcmp(katalogi1(n).name,'.')) & ~(strcmp(katalogi1(n).name,'..'))))
                podkataloG1=katalogi1(n).name;
                podkataloGu1=strcat(wskazanykataloG,'\',podkataloG1,'\obrazy\');
            end
        end
        if(isdir(podkataloGu1)==0)
            errordlg('Nie istnije katalog z plikami','BLAD');
            return;
        end
        
        wskazanykatalog1=podkataloGu1; % ostatni
        wskazanepliki1=strcat(wskazanykatalog1,'*.jpg'); % sciezka        
        zlistowane1=dir(wskazanepliki1);                 % listowanie zawartosci katalogu
        if(isempty(zlistowane1))
            errordlg('Brak plikow w pierwszym zlisotowanym katalogu. Przerwano procedure !!','BLAD');
            return;
        end

        pierwszy=[podkataloGu1,zlistowane1(1).name]; % Pobiera sciezka i nazwe wskazanego pliku.
        pierwszy=imread(pierwszy); %
        [Ywzka,Xwzka]=size(pierwszy); % Rozmiar wskazanego obrazu, bedzie on porownywany z "zlistowane".
        
        
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


        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(podkataloGu);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='hurtowo';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
                % operacje na plikach i obrazach
                %%%

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

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
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



% --- buduj mieszaj
function pushbutton16_Callback(hObject, eventdata, handles)





% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)

    [docelowanazwa,docelowykataloG] = uiputfile('*.mat','Pliki dwa katalogii wyzej!!','mala_macierz');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);
    if ((sum(docelowanazwa)~=0) & (sum(docelowykataloG)~=0))

        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');

%                 l1=length(wskazanykataloG);
%                 l2=length(docelowypodkataloG);
%                 if(l2>=l1)
%                     if(strcmp(podkataloGu,docelowypodkataloG))
%                         errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
%                         return;
%                     elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
%                         errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
%                         return;
%                     end
%                 end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
%                 docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');


                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end
                %

                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;

                % ---------------------------------------------------- %
                wskazanymat=strcat(wskazanykatalog,podkataloG,'-','macierz.mat');   % sciezka
                % plikdozapisu=strcat(docelowypodkataloG,podkataloG,docelowanazwa); % katlog docelowy + nazwa pliku
                plikdozapisu=strcat(docelowypodkataloG,docelowanazwa);
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %
                % load(wskazanymat,wybrana);
                load(wskazanymat);
                [y,x]=size(macierzZobrazami); % szerokosc macierzy
                pomieszana=macierzZobrazami(:,(randperm(x))); % miesza kolumny
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
            end
        end

    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end




% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)

        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';      % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Minimalny poziom szarosci (0-1) ';
        pyt{5} = 'Maksymalny poziom szarosci (0-1)';
        pyt{6} = 'Z normalizacja gamma-modulacja (0=<1 , 1- bez zmian)';
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','0.3','0.7','1'});          % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                    % do usuniecia brzegu
        niska=(str2num(cell2mat(wynik(4)))); 
        wysoka=(str2num(cell2mat(wynik(5)))); 
        gamma=(str2num(cell2mat(wynik(6)))); 
        if (niska<0 | niska >1)|(wysoka<0 | wysoka >1)|(gamma<0 | gamma >1)
            errordlg('Podaj prawidlowe parametry normalizacji','Podaj prawidlowe parametry normalizacji');
            return;
        end
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(wskazanykataloG);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='HurtowoNormalizacja';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %
                % operacje na plikach i obrazach
                %%%

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
                           if gamma==1
                               znormalizowany=imadjust(szary,[niska  wysoka],[]);                                                                                        
                           else
                              znormalizowany=imadjust(szary,[niska  wysoka],[], gamma);
                           end
                           imwrite(znormalizowany,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                        elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                            if gamma==1
                                znormalizowany=imadjust(szary,[niska  wysoka],[]);                                
                            else
                                znormalizowany=imadjust(szary,[niska  wysoka],[], gamma);
                            end
                            imwrite(znormalizowany,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
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
                            if gamma==1
                                znormalizowany=imadjust(szary,[niska  wysoka],[]);
                            else
                                znormalizowany=imadjust(szary,[niska  wysoka],[], gamma);
                            end
                            imwrite(znormalizowany,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                        elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                            szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie
                            if gamma==1
                                znormalizowany=imadjust(szary,[niska  wysoka],[]);
                            else
                                znormalizowany=imadjust(szary,[niska  wysoka],[], gamma);
                            end
                            imwrite(znormalizowany,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
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

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)

%%
[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)

        pyt{1} = 'Szerokosc obrazu (Szer i Wyso-0- bez zmian)';      % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu (Szer i Wyso-0- bez zmian)';       % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';      % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'Szerokosc- czesci';
        pyt{5} = 'Wysokosc- czesci';
        tytul  = 'Podaj rozmiar obrazu';                          % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'0','0','0','2','2'});          % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                    % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                    % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                    % do usuniecia brzegu
        ileX=(str2num(cell2mat(wynik(4))));
        ileY=(str2num(cell2mat(wynik(5))));
        if(ileX<1|ileY<1)
            errordlg('Podaj ilosc czesci>0','czesci>0');
            return;
        end
        cwiartek=ileX*ileY;
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(wskazanykataloG);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');                

                % zaklada docelowy katalog
                for i=1:cwiartek
                    % jak czesci maja byc w podkatalogach
                    % docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\',num2str(i),'\obrazy\');
                    % jak czesci maja byc katalogu
                    docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');
                    if(isdir(docelowypodkataloG)==0)
                        mkdir (docelowypodkataloG);
                    end
                end                
                docelowypodkataloG=[];
                
                docelowanazwa='czesc_';
                wskazanykatalog=podkataloGu;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %
                % operacje na plikach i obrazach
                %%%

                % operacje na plikach i obrazach
                for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
                    nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
                    wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
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
                        elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie                                            % zapisanie przetworzonego obrazu do pliku
                        else
                            errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                            return;
                        end                        
                    elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                        %%%
                        if ((YObrazu > 0) & (XObrazu > 0))
                            szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                            [y,x]=size(szary);                                 % rozmiar obrazu
                            if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                                szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                            end
                        elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                            szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                            %figure;  imshow(szary);
                            %% pokazanie obrazu w nowym oknie                            
                        else
                            errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                            return;
                        end
                    else
                        errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                        return;
                    end
%%
                    t=0;
                    [i,j]=size(szary);
                    Y=i/ileY;
                    X=j/ileX;                    
                    if ((rem(X,1)~=0) | (rem(Y,1)~=0))
                        errordlg('Nie mozna podzieliæ obrazu na czesci, zostaje reszta z dzielenia (nieparzysty rozmiar po podziale na czesci)','Blad dzielenia');
                        return;
                    end          
                    for(m=1:X:j)
                        for (n=1:Y:i)
                            t=t+1;
                            % jak czesci maja byc podkatalogach
                            % docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\',num2str(t),'\','\obrazy\');
                            % jak czesci maja byc katalogu
                            docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');
                            plikdozapisu=strcat(docelowypodkataloG,num2str(t),'_',docelowanazwa,nazwapliku);
                            imwrite(szary(n:n+Y-1,m:m+X-1),plikdozapisu); % zapisanie przetworzonego obrazu do pliku
                        end
                    end
%%                    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end
%%

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)

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
        metoda = 'canny';
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(wskazanykataloG);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='HurtowoKrawe';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %
                % operacje na plikach i obrazach
                %%%

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
                        elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                            %figure;  imshow(szary);                           % pokazanie obrazu w nowym oknie                                            % zapisanie przetworzonego obrazu do pliku
                        else
                            errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                            return;
                        end
                        krawedzie=edge(szary,metoda);
                        imwrite(krawedzie,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                    elseif ((naokolo>0) & ((x>2*naokolo) & (y>2*naokolo)))
                        %%%
                        if ((YObrazu > 0) & (XObrazu > 0))
                            szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                            [y,x]=size(szary);                                 % rozmiar obrazu
                            if ((XObrazu ~=x) | (YObrazu ~=y))                 % jesli podano inny rozmiar obrazu
                                szary=imresize(szary,[YObrazu XObrazu]);       % skalowanie obrazu
                            end
                        elseif((YObrazu == 0) & (XObrazu == 0))                % bez skalowonia
                            szary=imcrop(szary,[naokolo+1 naokolo+1 (x-(2*naokolo)-1) (y-(2*naokolo)-1)]); % do usuwania paska z obrazu (naokolo)
                            %figure;  imshow(szary);
                            %% pokazanie obrazu w nowym oknie                            
                        else
                            errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                            return;
                        end
                        krawedzie=edge(szary,metoda);
                        imwrite(krawedzie,plikdozapisu);                   % zapisanie przetworzonego obrazu do pliku
                    else
                        errordlg('Podaj prawidlowy rozmiar obrazu do przeskalowania','BLAD');
                        return;
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end

            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)

    [docelowanazwa,docelowykataloG] = uiputfile('*.mat','Pliki dwa katalogii wyzej!!','Duza-Wymieszana-macierz');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);
    if ((sum(docelowanazwa)~=0) & (sum(docelowykataloG)~=0))

        duza=[];
        plikdozapisu=[docelowykataloG docelowanazwa];
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);
        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');

                wskazanymat=strcat(wskazanykataloG,'\',podkataloG,'\',podkataloG,'-','macierz.mat');
                % docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');               
                
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %
                % load(wskazanymat,wybrana);
                load(wskazanymat);
                duza=[duza macierzZobrazami];
                % ---------------------------------------------------- %
                % ---------------------------------------------------- %

            end            
        end
        [y,x]=size(duza); % szerokosc macierzy
        Duza_pomieszana=duza(:,(randperm(x))); % miesza kolumny        
        save(plikdozapisu,'Duza_pomieszana');
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        pyt{1} = 'Szerokosc obrazu';                             % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu';                              % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                         % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'360','288','10'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(podkataloGu);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='hurtowo';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow

                % ---------------------------------------------------- %
                % ---------------------------------------------------- %

                % operacje na plikach i obrazach
                %%%
                for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
                    nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
                    wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
                    plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
                    obraz=rgb2gray(imread(wczytywany));    % wczytanie pliku z listowania

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
            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end





% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
%%
[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)

    [docelowanazwa,docelowykataloG] = uiputfile('*.mat','Pliki dwa katalogii wyzej!!','duza_macierz');
    dlugosc=(length(docelowanazwa)-4); docelowanazwa=docelowanazwa(1:dlugosc);
    if ((sum(docelowanazwa)~=0) & (sum(docelowykataloG)~=0))

        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        for n=1:katalogow
            duza=[];
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloGZapisu=katalogi(n).name;
                docelowypodkataloG=strcat(docelowykataloG, podkataloGZapisu);
%%
                for m=1:katalogow
                    if ((katalogi(m).isdir)&(~(strcmp(katalogi(m).name,'.')) & ~(strcmp(katalogi(m).name,'..'))))
                        podkataloG=katalogi(m).name;
                        if(~(strcmp((podkataloG),(podkataloGZapisu))))
                            podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                            wskazanymat=strcat(wskazanykataloG,'\',podkataloG,'\',podkataloG,'-','macierz.mat');
                            % ---------------------------------------------------- %
                            % ---------------------------------------------------- %
                            % load(wskazanymat,wybrana);
                            load(wskazanymat);
%%                          brakuje pamiaêci
%                             [y1,x1]=size(macierzZobrazami);
%                             macierzZobrazami=macierzZobrazami(:,(randperm(x1)));
%                             macierzZobrazami=macierzZobrazami(:,1:round(0.3*x1));                            
%%
                            duza=[duza macierzZobrazami];
                            % ---------------------------------------------------- %
                            % ---------------------------------------------------- %
                        end
                    end
                end
                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end
                %
                plikdozapisu=[docelowypodkataloG,'\', docelowanazwa];
                [y,x]=size(duza); % szerokosc macierzy
                % Nowka=duza(:,(randperm(x))); % miesza kolumny
                % save(plikdozapisu,'Nowka');
                DuzaWymieszana=duza(:,(randperm(x))); % miesza kolumny
                save(plikdozapisu,'DuzaWymieszana');
            end
        end
%%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end




% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)

%pyt{1} = 'Podaj bledy (.1,.15,.2,.25,.3)';      % tekst przy polu do wprowadzenia zmiennej 1
pyt{1} = 'Podaj bledy (.1,.15,.2,.25,.3)';
tytul  = 'Podaj dane';                          % nazwa okna
dane  = inputdlg(pyt, tytul, 1, {'.1,.15,.2,.25,.3'});     % wywolanie okna dialogowego
while (isempty(dane))
    return;
end
bledy=(str2num(cell2mat(dane(1))));     %%

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [nazwapliku,docelowykatalog] = uiputfile('*.xls','Plik z Wynikami i Zrzuty wykresów','30x30-');
    if (sum(nazwapliku)~=0)&(sum(docelowykatalog)~=0)
        ile=length(bledy);
        for i=1:ile
            blad=bledy(i);                        
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
                    wynik=[];
                    nazwysieci=[];
                    for m = 1:Nplikow
                        nazwyplikow=(zlistowane(m).name);
                        koncowka=nazwyplikow(end-5:end-4);
                        load ([wskazanypodkatalog,'\',nazwyplikow]);
                        %%
                        Ttest=eval(['Ttest_',koncowka]);
                        Ytest=eval(['Ytest_',koncowka]);
                        tr=eval(['tr_',koncowka]);
                        nazwasieci=['net_',koncowka];
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
                        set(gca,'YTick',[-0.5 0  blad 1-blad  1 1.5]);
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
                    plikdozapisu=strcat(podkatalog,'\',nazwapliku(1:end-4),num2str(blad*100),'%.xls');
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
                        errordlg('Problem z nazwami sieci','Nazwy sieci');
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
  


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)

%%
% disp('Mozna podac wiecej bledow w [] np [.1,.2,.3]');

%pyt{1} = 'Podaj bledy (.1,.15,.2,.25,.3)';      % tekst przy polu do wprowadzenia zmiennej 1
pyt{1} = 'Podaj bledy (.1,.15,.2,.25,.3)';
pyt{2} = 'Podaj nazwe pliku excela';            % tekst przy polu do wprowadzenia zmiennej 2
tytul  = 'Podaj dane';                          % nazwa okna
dane  = inputdlg(pyt, tytul, 1, {'.1,.15,.2,.25,.3','30x30-'});     % wywolanie okna dialogowego
while (isempty(dane))
    return;
end
bledy=(str2num(cell2mat(dane(1))));     %%
nazwa=num2str(cell2mat(dane(2)));

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [nazwapliku,docelowykatalog] = uiputfile('*.xls','Plik z Wynikami i Zrzuty wykresów','WynikiRazem');
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
                i=1;
                blad=[num2str(bledy(i)*100),'%'];
                
                przerwa=[{'','','','','','','',''};{'','','','','','','',''};{'','','','','','','',''}];
                duza=[];
                
                for i=1:ile
                    blad=bledy(i);
                    bledu=num2str(blad*100);
                    zpliku=[wskazanypodkatalog,bledu,'\',nazwa,bledu,'%.xls'];                    
                    naglowek=[{'B³¹d',[num2str(blad*100),'%'],'','','','','',''};{'pop','rozp','npop','nrozp','sprawnosc','L1','L2','Nazwa Sieci'}];

                    if ((exist(zpliku))== 2) %&(i<ile)
                        [excelowy,headertext]=(xlsread(zpliku));
                        headertext=headertext(2:end,8);
                        excelowy=num2cell(excelowy);
                        wynik=[naglowek;excelowy,headertext;przerwa];
                        duza=[duza;wynik];

                    else
                        errordlg('Brak pliku excela w podanym katalogu, usun procedure po else','Brak pliku excela');
                        return;
                    end
                end

                %plikdozapisu=strcat(docelowykatalog,podkatalogi,'\',nazwapliku);
                plikdozapisu=strcat(docelowykatalog,podkatalogi,'\',podkatalogi,'.xls');

                if ((exist(plikdozapisu))== 2)
                    delete (plikdozapisu);
                end

                xlswrite(plikdozapisu, duza);
%%
            end
        end
    else
        errordlg('Prosze wybrac katalog do zapisania plikow','Brak katalogu');
    end
else
    errordlg('Prosze wskazac plik "*.mat"','Prosze wskazac plik');
end





% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nadpisanie=0;

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
                katalogzapisu=[docelowykatalog,podkatalogi,'\'];
                sieci=dir([wskazanypodkatalog,'siec_*']);
                ilesieci=length(sieci);

                if(isdir(katalogzapisu)==0)
                    mkdir (katalogzapisu);
                end

                for m=1:ilesieci

                    nadpisanie=[nadpisanie+1];
                    if(exist('siec'))
                        clear siec sprawnosc;
                    end

                    nazwasieci=sieci(m).name;
                    plikzdanymi=[wskazanypodkatalog,nazwasieci];
                    koncowka=nazwasieci(:,end-5:end-4);
                    nazwasieci=['net_',koncowka];
                    load(plikzdanymi,nazwasieci);
                    siec=eval(nazwasieci);
                    clear(nazwasieci);
                    
                    sprawnosc=['sprawnosc_',koncowka];
                    load(plikzdanymi,sprawnosc);
                    sprawnosc=num2str(eval(sprawnosc));
                    plikzapisu=[katalogzapisu,'net_',koncowka,'_',podkatalogi,'-',sprawnosc,'.mat'];
                                        
                    if ((exist(plikzapisu))== 2) & isequal(nadpisanie,1) %&(i<ile)
                        baner1=[{'Czy nadpisaæ pliki w podkatalogach ?'};{docelowykatalog}];
                        okno=questdlg(baner1,'Nadpisaæ plik?','Tak','Nie','Tak');
                        if(strcmp('Tak',okno))
                            save(plikzapisu,'siec');                            
                        else
                            return;
                        end
                    else
                        % Jak nie ma pliku
                        save(plikzapisu,'siec');
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



% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir;
if (sum(wskazanykataloG)~=0)
    [docelowykataloG] = uigetdir;
    if (sum(docelowykataloG)~=0)
        % ---------------------------------------------------- %
        % ---------------------------------------------------- %
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        pyt{1} = 'Szerokosc obrazu';                             % tekst przy polu do wprowadzenia zmiennej 1
        pyt{2} = 'Wysokosc obrazu';                              % tekst przy polu do wprowadzenia zmiennej 2
        pyt{3} = 'Obciecie brzegow (0 bez usuwania brzegu)';     % tekst przy polu do wprowadzenia zmiennej 3
        pyt{4} = 'wartoœc koloru + -';     % tekst przy polu do wprowadzenia zmiennej 3
        tytul  = 'Podaj rozmiar obrazu';                         % nazwa okna
        wynik  = inputdlg(pyt, tytul, 1, {'30','30','0','25'});     % wywolanie okna dialogowego
        while (isempty(wynik))
            return;
        end
        XObrazu=(str2num(cell2mat(wynik(1))));                   % kolumn obrazu
        YObrazu=(str2num(cell2mat(wynik(2))));                   % wierszy obrazu
        naokolo=(str2num(cell2mat(wynik(3))));                   % do usuniecia brzegu
        koloru=(str2num(cell2mat(wynik(4))));

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\');
                l1=length(podkataloGu);
                l2=length(docelowypodkataloG);
                if(l2>=l1)
                    if(strcmp(podkataloGu,docelowypodkataloG))
                        errordlg('Wskazano na ten sam katalog zrodlowy i do zapisu. Aby uniknac pomylek zablokowano mozliwosc zapisu w tych samych katalogach, wskaz rozne katalogi.','Wskaz inny katalog');
                        return;
                    elseif(strcmp(wskazanykataloG,docelowypodkataloG(1:l1))&(strcmp('\',docelowypodkataloG(l1+1)))) % dziala dobrze ;)
                        errordlg('Aby uniknac pomylek zablokowano funkcje zapisywania w podkatalogach.','Wskaz inny katalog');
                        return;
                    end
                end

                podkataloGu=strcat(wskazanykataloG,'\',podkataloG,'\obrazy\');
                docelowypodkataloG=strcat(docelowykataloG,'\',podkataloG,'\obrazy\');

                % zaklada docelowy katalog
                if(isdir(docelowypodkataloG)==0)
                    mkdir (docelowypodkataloG);
                end

                docelowanazwa='odcienie';
                wskazanykatalog=podkataloGu;
                docelowykatalog=docelowypodkataloG;
                wskazanepliki=strcat(wskazanykatalog,'*.jpg'); % sciezka
                zlistowane=dir(wskazanepliki);                 % listowanie zawartosci katalogu
                Nplikow=length(zlistowane);                    % obliczanie ilosci plikow

                % ---------------------------------------------------- %
                % ---------------------------------------------------- %

                % operacje na plikach i obrazach
                %%%
                for n = 1:Nplikow % operacja na kolejnym pliku *.jpg
                    nazwapliku=(zlistowane(n).name);  % nazwa pliku "n" z listowania
                    wczytywany=(strcat(wskazanykatalog,nazwapliku)); % sciezka do wczytanego pliku
                    plikdozapisu=strcat(docelowykatalog,docelowanazwa,nazwapliku);   % sciezka docelowa + nowa nazwa pliku  + poprzednia nazwa
                    obraz=imread(wczytywany);    % wczytanie pliku z listowania
                                                          
                    if isequal(round(n/2),n/2);
                        obraz=obraz-(round(rand(1)*koloru));
                    else
                        obraz=obraz-(round(rand(1)*koloru));
                    end
                     
%                     if randn(1)>=0;
%                         obraz=obraz-(round(rand(1)*koloru));
%                     else
%                         obraz=obraz-(round(rand(1)*koloru));
%                     end

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
            end
        end
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end




% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
%%
[wskazanykataloG] = uigetdir('','To co ma byæ do³o¿one');
if (sum(wskazanykataloG)~=0)
    wskazanykataloG=[wskazanykataloG,'\'];
    %    cd (wskazanykataloG);
    [docelowykataloG] = uigetdir('','Tam gdzie ma byæ zapisane, jak co jest to po³¹czy'); % katalog zapisu
    if (sum(docelowykataloG)~=0)
        docelowykataloG=[docelowykataloG,'\'];
        %        cd (domowy)
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                %%
                mala1=[];
                % pomieszana=[];
                KatalogOdczytu=[wskazanykataloG,podkataloG,'\'];
                if isequal(exist(KatalogOdczytu),7)
                    PlikOdczytu=[KatalogOdczytu,'mala_macierz.mat'];
                    if isequal(exist(PlikOdczytu),2)
                        load (PlikOdczytu);
                        mala1=pomieszana;
                    end
                end
                mala2=[];
                % pomieszana=[];
                KatalogZapisu=[docelowykataloG,podkataloG,'\'];
                if isequal(exist(KatalogZapisu),7);
                    PlikZapisu=[KatalogZapisu,'mala_macierz.mat'];
                    if isequal(exist(PlikZapisu),2)
                        load (PlikZapisu);
                        mala2=pomieszana;
                    end
                end

                pomieszana=[mala1 mala2];
                [y,x]=size(pomieszana);
                if x>0
                    if isequal(isdir(KatalogZapisu),0)
                        mkdir (KatalogZapisu)
                    end
                    pomieszana=pomieszana(:,randperm(x));
                    PlikZapisu=[KatalogZapisu,'mala_macierz.mat'];
                    save(PlikZapisu,'pomieszana');
                end
                %%
            end
        end
        %%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end






% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
%%
[wskazanykataloG] = uigetdir('','To co ma byæ do³o¿one');
if (sum(wskazanykataloG)~=0)
    wskazanykataloG=[wskazanykataloG,'\'];
    %    cd (wskazanykataloG);
    [docelowykataloG] = uigetdir('','Tam gdzie ma byæ zapisane, jak co jest to po³¹czy'); % katalog zapisu
    if (sum(docelowykataloG)~=0)
        docelowykataloG=[docelowykataloG,'\'];
        %        cd (domowy)
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                %%
                duza1=[];
                % DuzaWymieszana=[];
                KatalogOdczytu=[wskazanykataloG,podkataloG,'\'];
                if isequal(exist(KatalogOdczytu),7)
                    PlikOdczytu=[KatalogOdczytu,'duza_macierz.mat'];
                    if isequal(exist(PlikOdczytu),2)
                        load (PlikOdczytu);
                        duza1=DuzaWymieszana;
                    end
                end
                duza2=[];
                % DuzaWymieszana=[];
                KatalogZapisu=[docelowykataloG,podkataloG,'\'];
                if isequal(exist(KatalogZapisu),7);
                    PlikZapisu=[KatalogZapisu,'duza_macierz.mat'];
                    if isequal(exist(PlikZapisu),2)
                        load (PlikZapisu);
                        duza2=DuzaWymieszana;
                    end
                end

                DuzaWymieszana =[duza1 duza2];
                [y,x]=size(DuzaWymieszana);
                if x>0
                    if isequal(isdir(KatalogZapisu),0)
                        mkdir (KatalogZapisu)
                    end
                    DuzaWymieszana=DuzaWymieszana(:,randperm(x));
                    PlikZapisu=[KatalogZapisu,'duza_macierz.mat'];
                    save(PlikZapisu,'DuzaWymieszana');
                end
                %%
            end
        end
        %%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end




% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% domowy=pwd;

pyt{1} = 'Ile wygenerowac obrazów'; % tekst przy polu do wprowadzenia zmiennej 1
pyt{2} = 'Ile wygenerowac obrazów (procentowo- z liczby obrazow w macierzy)'; % tekst przy polu do wprowadzenia zmiennej 1
tytul  = 'Podaj rozmiar obrazu';                   % nazwa okna
wynik  = inputdlg(pyt, tytul, 1, {'0','0'});     % wywolanie okna dialogowego
while (isempty(wynik))
    return;
end
Ile1=(str2num(cell2mat(wynik(1))));
Ile2=(str2num(cell2mat(wynik(2))));

if (((Ile1 >0) & (Ile2 >0)) | (Ile1==0 & Ile2==0) | (Ile1<0 | Ile2<0))
    errordlg('Prosze podac iloœc obrazów- Liczbowo lub procentowo','Liczbowo lub procentowo');
    return;
end


[wskazanykataloG] = uigetdir('','Prosze wskazac katalog z Reszt¹ obrazów (tam gdzie s¹ "duza_macierz.mat")');
if (sum(wskazanykataloG)~=0)
    wskazanykataloG=[wskazanykataloG,'\'];
    %    cd (wskazanykataloG);
    [docelowykataloG] = uigetdir('','Tam gdzie ma byæ zapisane'); % katalog zapisu
    if (sum(docelowykataloG)~=0)
        docelowykataloG=[docelowykataloG,'\'];
        %        cd (domowy)
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                %%
                duza=[];
                DuzaWymieszana=[];
                KatalogOdczytu=[wskazanykataloG,podkataloG,'\'];
                if isequal(exist(KatalogOdczytu),7)
                    PlikOdczytu=[KatalogOdczytu,'duza_macierz.mat'];
                    if isequal(exist(PlikOdczytu),2)
                        load (PlikOdczytu);
                        duza=DuzaWymieszana;
                        [y,x]=size(duza);
                        % Ile1-liczbowo
                        % Ile2- %
                        if Ile1>0
                            Ile=Ile1;
                        elseif Ile2>0
                            Ile=round((Ile2/100)*x); % cale zaokragla, by unikanac rounf 0.5 to wynosi 1 !!
                        else
                            errordlg('B³¹d przy obliczniu liczby obrazów','B£¥D');
                            return;
                        end
                        wygenerowane=uint8(rand(y,Ile)*255);
                        DuzaWymieszana =[duza wygenerowane];
                    end
                end
%%                                           
                KatalogZapisu=[docelowykataloG,podkataloG,'\'];                
%%                
                [y2,x2]=size(DuzaWymieszana);
                if x2>0
                    if isequal(isdir(KatalogZapisu),0)
                        mkdir (KatalogZapisu)
                    end
                    DuzaWymieszana=DuzaWymieszana(:,randperm(x2));
                    PlikZapisu=[KatalogZapisu,'duza_macierz.mat'];
                    save(PlikZapisu,'DuzaWymieszana');
                end
                %%
            end
        end
        %%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end




% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)

[wskazanykataloG] = uigetdir('','To co ma byæ do³o¿one');
if (sum(wskazanykataloG)~=0)
    wskazanykataloG=[wskazanykataloG,'\'];
    %    cd (wskazanykataloG);
    [docelowykataloG] = uigetdir('','Tam gdzie ma byæ zapisane, jak co jest to po³¹czy'); % katalog zapisu
    if (sum(docelowykataloG)~=0)
        docelowykataloG=[docelowykataloG,'\'];
        %        cd (domowy)
        katalogi=dir(wskazanykataloG);
        katalogow=length(katalogi);

        for n=1:katalogow
            if ((katalogi(n).isdir)&(~(strcmp(katalogi(n).name,'.')) & ~(strcmp(katalogi(n).name,'..'))))
                podkataloG=katalogi(n).name;
                %%
                mala1=[];
                duza1=[];
                pomieszana=[];
                DuzaWymieszana=[];
%%                
                KatalogOdczytu=[wskazanykataloG,podkataloG,'\'];
                if isequal(exist(KatalogOdczytu),7)
                    PlikOdczytu1=[KatalogOdczytu,'mala_macierz.mat'];
                    PlikOdczytu2=[KatalogOdczytu,'duza_macierz.mat'];                    
                    if (isequal(exist(PlikOdczytu1),2))&(isequal(exist(PlikOdczytu2),2))
                        load (PlikOdczytu1);
                        load (PlikOdczytu2);
                        mala1=pomieszana;
                        duza1=DuzaWymieszana;
                    end
                end
%%                
                mala2=[];
                duza2=[];
                pomieszana=[];
                DuzaWymieszana=[];
                KatalogZapisu=[docelowykataloG,podkataloG,'\'];
                if isequal(exist(KatalogZapisu),7);
                    PlikZapisu1=[KatalogZapisu,'mala_macierz.mat'];
                    PlikZapisu2=[KatalogZapisu,'Duza_macierz.mat'];
                    if (isequal(exist(PlikZapisu1),2)) & (isequal(exist(PlikZapisu2),2))
                        load (PlikZapisu1);
                        load (PlikZapisu2);
                        mala2=pomieszana;
                        duza2=DuzaWymieszana;
                    end
                end

                pomieszana=[mala1 mala2];
                DuzaWymieszana=[duza1 duza2];               
                [y1,x1]=size(pomieszana);
                [y2,x2]=size(DuzaWymieszana);
                if (x1>0) & (x2>0)
                    if isequal(isdir(KatalogZapisu),0)
                        mkdir (KatalogZapisu)
                    end
                    pomieszana=pomieszana(:,randperm(x1));
                    DuzaWymieszana=DuzaWymieszana(:,randperm(x2));
                    PlikZapisu1=[KatalogZapisu,'mala_macierz.mat'];
                    PlikZapisu2=[KatalogZapisu,'duza_macierz.mat'];
                    save(PlikZapisu1,'pomieszana');
                    save(PlikZapisu2,'DuzaWymieszana');
                end
                %%
            end
        end
        %%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end



% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
domowy=pwd; %  tu sie znaduje ffmpeggui google.pl
[wskazanykataloG] = uigetdir('','Wskaza katalog z filmami');
if (sum(wskazanykataloG)~=0)
    wskazanykataloG=[wskazanykataloG,'\'];
    % cd (wskazanykataloG);
    [docelowykataloG] = uigetdir('','Tam gdzie ma byæ zalozonona struktura katalogow'); % katalog zapisu
    if (sum(docelowykataloG)~=0)
        docelowykataloG=[docelowykataloG,'\'];
        % cd (domowy);
        %
        errordlg('Uwaga na nazwy filmow. Procedury zle wskazuja sciezki w DOS - jest inaczej (np.: dlugosc nazw, spacje, polskie znaki)','UWAGA');
        %
        WskazanePliki=[wskazanykataloG,'*.avi'];
        PlikiAvi=dir(WskazanePliki);
        Plikow=length(PlikiAvi);
        for n=1:Plikow
            PlikAvi=PlikiAvi(n).name;
            %%
            PlikOdczytu=[wskazanykataloG,PlikAvi];
            KatalogZapisu=[docelowykataloG,PlikAvi(1:end-4),'\obrazy\'];
            if isequal(isdir(KatalogZapisu),0)
                mkdir (KatalogZapisu);
            end
            %%
            ffmpeg=[domowy,'\ffmpeggui\ffmpeg -i '];
            otworz=[ffmpeg,PlikOdczytu,' -qscale 1 ',KatalogZapisu,'%08d.jpg'];
            dos (otworz);
            %%
        end
        %%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end



% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)

domowy=pwd; %  tu sie znaduje ffmpeggui google.pl
[wskazanykataloG] = uigetdir('','Wskaz katalog z filmami (wyzej)');
if (sum(wskazanykataloG)~=0)
    wskazanykataloG=[wskazanykataloG,'\'];
    % cd (wskazanykataloG);
    [docelowykataloG] = uigetdir('','Tam gdzie ma byæ zalozonona struktura katalogow'); % katalog zapisu
    if (sum(docelowykataloG)~=0)
        docelowykataloG=[docelowykataloG,'\'];
        % cd (domowy);
        %
        errordlg('Uwaga na nazwy filmow. Procedury zle wskazuja sciezki w DOS - jest inaczej (np.: dlugosc nazw, spacje, polskie znaki)','UWAGA');
        %
        Podkatalogi=dir(wskazanykataloG);
        Podkatalogow=length(Podkatalogi);
        for n=1:Podkatalogow;                        
            %%
            if (Podkatalogi(n).isdir)&(~(strcmp(Podkatalogi(n).name,'.')) & ~(strcmp(Podkatalogi(n).name,'..')))
                Podkatalog=Podkatalogi(n).name;
                WskazanePliki=[wskazanykataloG,Podkatalog,'\','*.avi'];
                PlikiAvi=dir(WskazanePliki);
                Plikow=length(PlikiAvi);
                for nn=1:Plikow
                    PlikAvi=PlikiAvi(nn).name;
                    %%
                    PlikOdczytu=[wskazanykataloG,Podkatalog,'\',PlikAvi];
                    KatalogZapisu=[docelowykataloG,Podkatalog,'\obrazy\'];
                    if isequal(isdir(KatalogZapisu),0)
                        mkdir (KatalogZapisu);
                    end
                    %%
                    ffmpeg=[domowy,'\ffmpeggui\ffmpeg -i '];
                    otworz=[ffmpeg,PlikOdczytu,' -qscale 1 ',KatalogZapisu,PlikAvi(1:end-4),'-','%08d.jpg'];
                    dos (otworz);
                    %%
                end
            end
        end
        %%
    else
        errordlg('Prosze wskazac katalog do zapisania','Prosze wskazac katalog');
    end
else
    errordlg('Prosze wskazac katalog z podkatalogami i plikami','Prosze wskazac katalog');
end


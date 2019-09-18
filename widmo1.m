% wyznaczanie amplitudy obrazu cyfrowego
function [amplituda]=widmo(obraz)
obraz=double(obraz);
%B=fftshift(fft2(obraz)); % 2 wymiarowa transformata Fouriera wraz z przesunieciem danych
B=(fft2(obraz));
amplituda=log(abs(B)+1);


minimum=min(min(amplituda)); 
maksimum=max(max(amplituda));
roznica=maksimum-minimum; 
macierz=roznica*amplituda;
amplituda=uint8(macierz);

% colormap(jet)

% http://pcc.imir.agh.edu.pl/poz4/index.htm
% Polecenie fftshift przesuwa sk�adow� sta�� wyniku transformaty z obrazu
% wej�ciowego do centrum F-obrazu.
% Polecenie imshow(log(abs(B)),[]) wy�wietla zlogarytmowan� warto�� modu�u transformaty.
% Logarytmowanie ma na celu rozci�gni�cie warto�ci modu�u transformaty do
% zakresu umo�liwiaj�cego wygodn� wizualizacj� wyniku.
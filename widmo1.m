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
% Polecenie fftshift przesuwa sk³adow¹ sta³¹ wyniku transformaty z obrazu
% wejœciowego do centrum F-obrazu.
% Polecenie imshow(log(abs(B)),[]) wyœwietla zlogarytmowan¹ wartoœæ modu³u transformaty.
% Logarytmowanie ma na celu rozci¹gniêcie wartoœci modu³u transformaty do
% zakresu umo¿liwiaj¹cego wygodn¹ wizualizacjê wyniku.
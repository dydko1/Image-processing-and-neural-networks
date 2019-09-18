function [sprawnosc,rozp]=ocena(Y,T,blad)

roznica=abs(Y-T);
[i,j]=size(Y);
rozp=0;


for liczba_t=1:1:j
%     roznica(liczba_t)
%     blad
    if roznica(liczba_t)<=blad
       rozp=rozp+1;
    end   
end

% j
sprawnosc=(100*rozp)/j;
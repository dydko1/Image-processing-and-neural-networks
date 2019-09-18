function [pop,npop,nrozp]=rozpoznanie(Y,T,blad)

[i,j]=size(Y);
pop=0;
npop=0;
nrozp=0;

for liczba_t=1:1:j
    if T(liczba_t)==0
       if Y(liczba_t)<=0+blad
          pop=pop+1;
       end
       if Y(liczba_t)>0+blad & Y(liczba_t)<1-blad
          nrozp=nrozp+1;
       end
       if Y(liczba_t)>=1-blad
          npop=npop+1;
       end   
    end

    if T(liczba_t)==1
       if Y(liczba_t)>=1-blad
          pop=pop+1;
       end
       if Y(liczba_t)>0+blad & Y(liczba_t)<1-blad
          nrozp=nrozp+1;
       end
       if Y(liczba_t)<=0+blad
          npop=npop+1;
       end   
    end   
end


% (0.2,duza,mala,DoTestow,2,3); (prog,duza,mala,DoTestow,ukrytej_1,ukrytej_2);
%%
sprawnoscZalozona=90; % jak wiecej to wychodzi z petli ;]

%% ----------------------------
sprawnosc_01=0;
nn=0; % licznik na 0
nnn=[]; % bo dodaje do wektora 
while  ((sprawnosc_01 < sprawnoscZalozona) & (nn<MaxIteracji))
    [Ttest_01,Ytest_01,sprawnosc_01,net_01,tr_01,Itest_01,rozp_01,pop_01,npop_01,nrozp_01,L1,L2]=siecMieszana(0.2,duza,mala,DoTestow,MaxObrazow,2,3);
    nn=nn+1;
    %    nnn=[nnn;sprawnosc_01]	
end

siec_01=[docelowykatalog,'siec_01'];
save(siec_01,'Ttest_01','Ytest_01','sprawnosc_01','net_01','tr_01','Itest_01','rozp_01','pop_01','npop_01','nrozp_01','L1','L2');
clear siec_01 Ttest_01 Ytest_01 sprawnosc_01 net_01 tr_01 Itest_01 rozp_01 pop_01 npop_01 nrozp_01 L1 L2;
%% ---------------------------- %%

%% ---------------------------- %%

%% ---------------------------- %%

sprawnosc_02=0;
nn=0; % licznik na 0
nnn=[]; % bo dodaje do wektora 
while ((sprawnosc_02 < sprawnoscZalozona) & (nn<MaxIteracji))
    [Ttest_02,Ytest_02,sprawnosc_02,net_02,tr_02,Itest_02,rozp_02,pop_02,npop_02,nrozp_02,L1,L2]=siecMieszana(0.2,duza,mala,DoTestow,MaxObrazow,2,3);
    nn=nn+1;
    %    nnn=[nnn;sprawnosc_02]
end

siec_02=[docelowykatalog,'siec_02'];
save(siec_02,'Ttest_02','Ytest_02','sprawnosc_02','net_02','tr_02','Itest_02','rozp_02','pop_02','npop_02','nrozp_02','L1','L2');
clear siec_02 Ttest_02 Ytest_02 sprawnosc_02 net_02 tr_02 Itest_02 rozp_02 pop_02 npop_02 nrozp_02 L1 L2;
%% ---------------------------- %%
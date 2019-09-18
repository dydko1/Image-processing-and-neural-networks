% (0.2,duza,mala,DoTestow,2,3); (prog,duza,mala,DoTestow,ukrytej_1,ukrytej_2);
%%
sprawnoscZalozona=95; % jak wiecej to wychodzi z petli ;]

%% ----------------------------
sprawnosc_01=0;
sprawnoscMax=0;
nn=0; % licznik na 0
nnn=[]; % bo dodaje do wektora 
while  ((sprawnosc_01 < sprawnoscZalozona) & (nn<MaxIteracji))
    [Ttest_01,Ytest_01,sprawnosc_01,net_01,tr_01,Itest_01,rozp_01,pop_01,npop_01,nrozp_01,L1,L2]=siecMieszana(0.2,duza,mala,DoTestow,MaxObrazow,2,3);
    nn=nn+1;
    % wybiera siec z max sprawnoœcia
    if sprawnosc_01>=sprawnoscMax
        Tmp_Ttest_01=Ttest_01;  Tmp_Ytest_01=Ytest_01;  
        Tmp_sprawnosc_01=sprawnosc_01;  Tmp_net_01=net_01;
        Tmp_tr_01=tr_01;  Tmp_Itest_01=Itest_01;   Tmp_rozp_01=rozp_01;
        Tmp_pop_01=pop_01; Tmp_npop_01=npop_01; Tmp_nrozp_01=nrozp_01;
        sprawnoscMax=sprawnosc_01;
    end    
    nnn=[nnn;sprawnosc_01];
end
nn_01=nnn;
%% ---------------------------- %%
clear siec_01 Ttest_01 Ytest_01 sprawnosc_01 net_01 tr_01 Itest_01 rozp_01 pop_01 npop_01 nrozp_01;
Ttest_01=Tmp_Ttest_01;  Ytest_01=Tmp_Ytest_01;
sprawnosc_01=Tmp_sprawnosc_01;  net_01=Tmp_net_01;
tr_01=Tmp_tr_01;  Itest_01=Tmp_Itest_01;   rozp_01=Tmp_rozp_01;
pop_01=Tmp_pop_01; npop_01=Tmp_npop_01; nrozp_01=Tmp_nrozp_01;
clear Tmp_siec_01 Tmp_Ttest_01 Tmp_Ytest_01 Tmp_sprawnosc_01 Tmp_net_01 Tmp_tr_01 Tmp_Itest_01 Tmp_rozp_01 Tmp_pop_01 Tmp_npop_01 Tmp_nrozp_01;
%        
siec_01=[docelowykatalog,'siec_01'];
save(siec_01,'Ttest_01','Ytest_01','sprawnosc_01','net_01','tr_01','Itest_01','rozp_01','pop_01','npop_01','nrozp_01','L1','L2','nn_01');
clear siec_01 Ttest_01 Ytest_01 sprawnosc_01 net_01 tr_01 Itest_01 rozp_01 pop_01 npop_01 nrozp_01 L1 L2;
%% ---------------------------- %%



%% ----------------------------
sprawnosc_02=0;
sprawnoscMax=0;
nn=0; % licznik na 0
nnn=[]; % bo dodaje do wektora 
while  ((sprawnosc_02 < sprawnoscZalozona) & (nn<MaxIteracji))
    [Ttest_02,Ytest_02,sprawnosc_02,net_02,tr_02,Itest_02,rozp_02,pop_02,npop_02,nrozp_02,L1,L2]=siecMieszana(0.2,duza,mala,DoTestow,MaxObrazow,2,3);
    nn=nn+1;
    % wybiera siec z max sprawnoœcia
    if sprawnosc_02>=sprawnoscMax
        Tmp_Ttest_02=Ttest_02;  Tmp_Ytest_02=Ytest_02;  
        Tmp_sprawnosc_02=sprawnosc_02;  Tmp_net_02=net_02;
        Tmp_tr_02=tr_02;  Tmp_Itest_02=Itest_02;   Tmp_rozp_02=rozp_02;
        Tmp_pop_02=pop_02; Tmp_npop_02=npop_02; Tmp_nrozp_02=nrozp_02;
        sprawnoscMax=sprawnosc_02;
    end    
    nnn=[nnn;sprawnosc_02];
end
nn_02=nnn;
%% ---------------------------- %%
clear siec_02 Ttest_02 Ytest_02 sprawnosc_02 net_02 tr_02 Itest_02 rozp_02 pop_02 npop_02 nrozp_02;
Ttest_02=Tmp_Ttest_02;  Ytest_02=Tmp_Ytest_02;
sprawnosc_02=Tmp_sprawnosc_02;  net_02=Tmp_net_02;
tr_02=Tmp_tr_02;  Itest_02=Tmp_Itest_02;   rozp_02=Tmp_rozp_02;
pop_02=Tmp_pop_02; npop_02=Tmp_npop_02; nrozp_02=Tmp_nrozp_02;
clear Tmp_siec_02 Tmp_Ttest_02 Tmp_Ytest_02 Tmp_sprawnosc_02 Tmp_net_02 Tmp_tr_02 Tmp_Itest_02 Tmp_rozp_02 Tmp_pop_02 Tmp_npop_02 Tmp_nrozp_02;
%        
siec_02=[docelowykatalog,'siec_02'];
save(siec_02,'Ttest_02','Ytest_02','sprawnosc_02','net_02','tr_02','Itest_02','rozp_02','pop_02','npop_02','nrozp_02','L1','L2','nn_02');
clear siec_02 Ttest_02 Ytest_02 sprawnosc_02 net_02 tr_02 Itest_02 rozp_02 pop_02 npop_02 nrozp_02 L1 L2;
%% ---------------------------- %%
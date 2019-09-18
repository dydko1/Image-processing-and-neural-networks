katalogiii=dir;
dlugoscii=length(katalogiii);
for nn=1:dlugoscii
    if (katalogiii(nn).isdir)&(~(strcmp(katalogiii(nn).name,'.')) & ~(strcmp(katalogiii(nn).name,'..')))
        podkatalogii=katalogiii(nn).name
        cd (podkatalogii);
        hurt;
        cd ../
    end
end
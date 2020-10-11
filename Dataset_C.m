clc
close all
clear all
mainfile = 'C:\Users\'; %% Dataset file
Destfile = 'C:\Users\'; %% Destination file 
Parts = dir(mainfile);
Partslist = {Parts.name};
Partlist = Partslist(3:end);

for j=1:3
    Partnum = Partlist{j};
    Partfile = sprintf('%s%s%s',mainfile,'\',Partnum);
    PartDestfile = sprintf('%s%s%s',Destfile,'\',Partnum);
    Files = dir(Partfile);
    filelist = {Files.name};
    filelist = filelist(3:end);
    for z=1:260  
        fileN = filelist{z};
        filename = sprintf('%s%s%s',Partfile,'\',fileN);
        filenameDest = sprintf('%s%s%s',PartDestfile,'\',fileN);
        alldata = importdata(filename);
        out = 20;
        slot = 614;
        B = zeros(out,16);
        for i=1:16
            C = alldata(:,i);
            u=1;
            for e=1:out
                if e<out
                   B(e,i) = mean(C(u:slot+u));
            elseif e==out
                   B(e,i) = mean(C(u:end));
                end   
            u=u+slot/2;
            end
        end
        filesave = sprintf('%s',filenameDest);
        writematrix(B,filesave)   
   end
end

clc
close all
clear all
mainfile = 'C:\Users\';
Destfile = 'C:\Users\';
Parts = dir(mainfile);
Partslist = {Parts.name};
Partlist = Partslist(3:end);
ST = zeros(64,768);
ED = zeros(64,768);
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
        data = alldata (:,2:end);
        fire = -1;
        for p= 1:30000
            if fire > 0
                break
            end
            for k = 1:16
                if data(p,k)<1.62 || data(p,k)>1.68
                fire = p;
                break;
                end
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
        if fire > 50
            start = fire - 50;
        elseif fire < 50
            start = 1;
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        image=data(start:end,:);
        [ImR,ImC] = size(image);
        ST(j,z) = start;
        ed = -1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        for p= ImR:-1:1
            if ed > 0
                break
            end
            for k = 1:16
                if image(p,k)<1.62 || image(p,k)>1.68
                ed = p;
                break;
                end
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
        if start > 23856
          take = 29999;
          start = 23856;
        elseif ed-start < 6143
            take = ed + (6143-(ed-start)); 
        elseif ed-start > 6143
            take = start+6143;          
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        image=data(start:take,:);
%       size(image)
        Fig=image;
        finalDest = erase(filenameDest,'.lvm');
        filesave = sprintf('%s%s',finalDest,'.txt');
        writematrix(Fig,filesave);
    end
end


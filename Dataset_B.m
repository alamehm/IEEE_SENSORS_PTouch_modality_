clc
close all
mainfile = 'C:\Users\yahya.abbass\Desktop\yahya\PHD\first year\Deep learning\Extension (IEEE sensors)\TactileDataset\TactileDataset\cleand (6144)\Average in time\output=256\Dataset';
Destfile = 'C:\Users\yahya.abbass\Desktop\yahya\PHD\first year\Deep learning\Extension (IEEE sensors)\TactileDataset\TactileDataset\cleand (6144)\Average in time\output=256\Images (RGB)';
Parts = dir(mainfile);
Partlist = {Parts.name};
Partlist = Partlist(3:end);
for j=1:3
    Partnum = Partlist{j};
    Partfile = sprintf('%s%s%s',mainfile,'\',Partnum);
    PartDestfile = sprintf('%s%s%s',Destfile,'\',Partnum);
    Files = dir(Partfile);
    filelist = {Files.name};
    filelist = filelist(3:end);
    B = zeros(4,4);
    A = zeros(64,64);
    for z=1:260  
        fileN = filelist{z};
        filenameDest = sprintf('%s%s%s',PartDestfile,'\',fileN);
        filename = sprintf('%s%s%s',Partfile,'\',fileN);
        data = importdata(filename);
        n=0;x=0;u=0;l=1;o=0;
        B = zeros(4,4);
        A = zeros(64,64);
        for i=1:256
            C = data(i,:);
            for e=1:4
                B(e,:) = C(e*4-3:e*4);
            end
            o=o+1;
            A(l*4-3:l*4,o*4-3:o*4)= B;
            if rem(i,16)==0
                l=l+1;
                o=0;
            end
        end
        finalDest = erase(filenameDest,'.txt');
        filesave = sprintf('%s%s',finalDest,'.bmp');
        Im = uint8(((A-min(min(A)))/(max(max(A))-min(min(A))))*256);
        rgbimage = cat(3, Im, Im, Im);
%         GrayImage = mat2gray(A,[min(min(data)) max(max(data))]);
%         imshow(GrayImage);
        imwrite(rgbimage,filesave);
     end
end


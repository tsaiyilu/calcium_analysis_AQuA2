[file,path] = uigetfile('*.mat');
Fullname = fullfile(path, file);
load(Fullname);

w = res.opts.sz(1); %movie width
h = res.opts.sz(2); %movie height
f = res.opts.sz(4); %the number of frames
n = size(res.evtSelectedList1, 1); %No. of events
frameRate = res.opts.frameRate;
Max_Projection = zeros(w, h); %Prepare the canvas
sz = [w h];

for i = 1:n
    [row, col] = ind2sub(sz, res.fts1.loc.xSpa{1, res.evtSelectedList1(i)});
    
    L = size(row, 1); %subscript length
  
    for j = 1: L
        Max_Projection(row(j), col(j)) = Max_Projection(row(j), col(j)) + 1;
    end
end

length = (f-1) * frameRate/60; %movie length in minutes
Max_Projectionf = Max_Projection/length; %event frequency in # of events/min

figure;
colormap(jet);
clims = [0 3];
imagesc(Max_Projectionf, clims);
yticks ([]);
xticks ([]);


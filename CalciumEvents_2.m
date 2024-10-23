close all;
clear;
[file,path] = uigetfile('*.mat');
Fullname = fullfile(path, file);
load(Fullname);
[filepath, name, ext] = fileparts(file);

f = res.opts.sz(3); %the number of frames
frameRate = res.opts.frameRate; %seconds per frame
t = (f-1)*frameRate; %total time (sec)
N = size(res.ftsFilter.loc.t0, 2); %number of all events
t0 = transpose(res.ftsFilter.loc.t0); %onset FRAMES for all events
%t0 = (t0-1)*frameRate; %convert frames to time
tMax = transpose(res.ftsFilter.curve.dffMaxFrame); %Peaked(Maxdff)FRAME
Maxdff = transpose(res.ftsFilter.curve.dffMax2);
Time = (0:f-1)*frameRate;
area = transpose(res.ftsFilter.basic.area);
dff2 = res.dffMatFilter(:,:,2);
tBegin_frame = transpose(res.ftsFilter.curve.tBegin);
tEnd_frame = transpose(res.ftsFilter.curve.tEnd);
duration = transpose(res.ftsFilter.curve.duration);
sorted = sortrows([t0 tMax tBegin_frame tEnd_frame dff2], 1);

basics = [t0 tMax Maxdff area duration];
basics = sortrows(basics, 1);

dff2_alongtime = zeros(N, f);

for i = 1: N
    dff2_alongtime(i,sorted(i, 3):sorted(i, 4)) = sorted(i, sorted(i, 3)+4:sorted(i, 4)+4);
end

figure;
colormap(jet);
clims = [0 1];
imagesc(dff2_alongtime(:,:), clims);




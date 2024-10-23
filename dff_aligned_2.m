close all;
clear;
[file,path] = uigetfile('*.mat');
Fullname = fullfile(path, file);
load(Fullname);
[filepath, name, ext] = fileparts(file);

f = res.opts.sz(4); %the number of frames
frameRate = res.opts.frameRate; %seconds per frame
t = (f-1)*frameRate; %total time (sec)
N = size(res.evtSelectedList1, 1); %number of all events
t0 = transpose(res.fts1.loc.t0(res.evtSelectedList1)); %onset FRAMES for all events
%t0 = (t0-1)*frameRate; %convert frames to time
tMax = transpose(res.fts1.curve.dffMaxFrame(res.evtSelectedList1)); %Peaked(Maxdff)Frame
Maxdff = transpose(res.fts1.curve.dffMax2(res.evtSelectedList1));
Time = (0:f-1)*frameRate;
%area = transpose(res.ftsFilter.basic.area);
dff2 = res.dffMat1(res.evtSelectedList1,:,2);
tBegin_frame = transpose(res.fts1.curve.tBegin(res.evtSelectedList1));
tEnd_frame = transpose(res.fts1.curve.tEnd(res.evtSelectedList1));
%duration = transpose(res.ftsFilter.curve.duration);
sorted = [t0 tMax tBegin_frame tEnd_frame dff2];
sorted = sortrows(sorted, 1);

dff2_alongtime = zeros(N, f);

for i = 1: N
    dff2_alongtime(i,sorted(i, 3):sorted(i, 4)) = sorted(i, sorted(i, 3)+4:sorted(i, 4)+4);
end

tMax_aligned = zeros(N, 41);

for i = 1: N
    tBegin = sorted(i,2)-20;
    if tBegin > 0
        tEnd = sorted(i,2)+20;
        if tEnd < 721
            tMax_aligned(i,:) = dff2_alongtime(i, tBegin:tEnd);
        else
            continue
        end
    else
        tMax_aligned(i,:) = 0;
    continue
    end 
end

combine = sortrows([sorted(:,2) tMax_aligned], 1);
imagesc(combine(:,2:end));
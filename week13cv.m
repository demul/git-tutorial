%set frame_num
frame_num = 127;
%set model window (H:81, W:35)
winy=80;
winx=80;
winh=30;
winw=30;

img_frames={};
for i = 1:frame_num
    current_frame_name = sprintf('img\\%04d.jpg',i);
    img_frames=[img_frames; imread(current_frame_name)];
end

gray_frames={};
for i = 1:frame_num
    tmp_img=rgb2gray(img_frames{i});
    gray_frames=[gray_frames; tmp_img];
end

%set model image
model_img=gray_frames{1};
[h,w]=size(model_img);

% win_center=[winy+(winh-1)/2,winx+(winw-1)/2];
model_window=model_img(winy:winy+winh-1, winx:winx+winw-1);

%get model histogram
model_hist=imhist(model_window,256)/(winh*winw);
%get back-projection-matrix
BPmatrix=zeros([h,w]);
BPmat_arr={};
for frame= 1 : frame_num
    for i = 1:h
        for j = 1:w
            this_frame=gray_frames{frame};
            BPmatrix(i,j)=model_hist(this_frame(i,j)+1);
        end
    end
    BPmat_arr=[BPmat_arr, BPmatrix];
end

for frame_idx=2:frame_num
    tmpi=double(gray_frames{frame_idx});
    tmpBPmat=BPmat_arr{frame_idx};
    [winy,winx]=updateFunc(tmpi, tmpBPmat, model_hist,winy, winx, winh, winw, 0.4);
    %intecsity, backprojection, window y, window, x, window height,
    %window width, exception threshold
    
    imshow(img_frames{frame_idx});
    hold on;
    drawBox(winy, winx, winh, winw);
    frames(frame_idx-1) = getframe;
    hold off; 
end

%write Video
v=VideoWriter('result.avi');
v.FrameRate = 30;
open(v);
writeVideo(v,frames);
close(v);
function [ winy, winx ] = updateFunc(img ,back_projection_matrix, model_hist, winy, winx , winh, winw, threshold)
%UPDATEFUNC 이 함수의 요약 설명 위치
%   자세한 설명 위치
    %undating loop
%get size
[h,w]=size(img);
%get x-idx,y-idx matrix
yidx=[1:winh];
yidx=yidx';
yidxmat=repmat(yidx,1,winw); %repmat 좆나 유용한 함수임(늘릴 행렬, 세로로 반복할 칸, 가로로 반복할 칸)
xidx=[1:winw];
xidxmat=repmat(xidx,winh,1); %repmat 좆나 유용한 함수임(늘릴 행렬, 세로로 반복할 칸, 가로로 반복할 칸)

%get center of weight
%%use Gaussian
G=fspecial('gaussian',max(winh,winw),4.5);
G=G(:,1+(winh-winw)/2:winh-(winh-winw)/2);

%루프수(디버그용) 
iter=0;
    
while true
    nowi=img(winy:winy+winh-1, winx:winx+winw-1);

    %nowhist : 각 위치에 대한 히스토그램(weight)
    %이를 이용해 무게중심을 구한다.
    tmphist=back_projection_matrix/sum(sum(back_projection_matrix));         %일반화를 계속 해줘야 함
    nowhist=tmphist(winy:winy+winh-1, winx:winx+winw-1);
%     nowhist=tmphist(winy:winy+winh-1, winx:winx+winw-1).*G; %커널 생략함(생략하니까 더 잘나옴)
    nowhist=nowhist/sum(sum(nowhist));                   % 일반화를 계속 해줘야 함

    newx=sum(sum(nowhist.*xidxmat));
    newy=sum(sum(nowhist.*yidxmat));


    %get phase(dy, dx)
    phase=[round((winh+1)/2)-round(newy),round((winw+1)/2)-round(newx)];

    %shift model window  (H:81, W:35)
    winy=winy+phase(1);
    winx=winx+phase(2);
    %%preventing index out of range
    winy=max(1,winy);
    winx=max(1,winx);
    winy=min(h,winy);
    winx=min(w,winx);

    %계산 : 바타차리아 계수(히스토그램의 유사성을 비교)
    %%새로운 윈도우의 히스토그램
    old_hist=histcounts(nowi,256);
    old_hist=old_hist/sum(sum(old_hist)); %generalize
    new_hist=histcounts(img(winy:winy+winh-1, winx:winx+winw-1),256);
    new_hist=new_hist/sum(sum(new_hist)); %generalize
    H_old = sum(sqrt(old_hist.*model_hist'));
    H_new = sum(sqrt(new_hist.*model_hist'));
    
    
    %예외처리 (바타차리아 계수가 너무 작을경우)
    if(H_new<threshold)
        %탐색영역(탐색윈도우)를 일시적으로 3배 더 크게 만든다.
        %%%%%%%%preventing index out of range !!!!!!!!!!!!!!
        y1=max(1,winy-winh);
        y2=min(h,winy+2*winh-1);
        x1=max(1, winx-winw);
        x2=min(w,winx+2*winw-1);
       %%%%%%%%%
       
        nowhist=tmphist(y1:y2, x1:x2);
        nowhist=nowhist/sum(sum(nowhist));
        
        %인덱스 함수 크기도 5배로 생성.
        wh=y2-y1+1;
        ww=x2-x1+1;
        tmpyidx=[1:wh];
        tmpyidx=tmpyidx';
        tmpyidxmat=repmat(tmpyidx,1,ww);
        tmpxidx=[1:ww];
        tmpxidxmat=repmat(tmpxidx,wh,1);
        
        newx=sum(sum(nowhist.*tmpxidxmat));
        newy=sum(sum(nowhist.*tmpyidxmat));
        
        %확장된 바운드박스 크기가 h,w보다 클 경우
        %(ww+1),(wh+1)이 홀수가 될수도 있다.
        %그러면(ww+1)/2, (wh+1)/2가 소수(XX.5000)가 되어 클남
        %그래서 바운드박스를 확장하는 여기서는 round를 씌워줘야 한다. 
        phase=[round((wh+1)/2)-round(newy),round((ww+1)/2)-round(newx)];
        
        winy=winy+phase(1);
        winx=winx+phase(2);
        %%preventing index out of range
        winy=max(1,winy);
        winx=max(1,winx);
        winy=min(h,winy);
        winx=min(w,winx);
        
        new_hist=histcounts(img(winy:winy+winh-1, winx:winx+winw-1),256);
        new_hist=new_hist/sum(sum(new_hist));
        H_new = sum(sqrt(new_hist.*model_hist'));
    end
    
    
    if(H_old>=H_new)
       break
    end
    iter=iter+1;
end

end


function [ winy, winx ] = updateFunc(img ,back_projection_matrix, model_hist, winy, winx , winh, winw, threshold)
%UPDATEFUNC �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
    %undating loop
%get size
[h,w]=size(img);
%get x-idx,y-idx matrix
yidx=[1:winh];
yidx=yidx';
yidxmat=repmat(yidx,1,winw); %repmat ���� ������ �Լ���(�ø� ���, ���η� �ݺ��� ĭ, ���η� �ݺ��� ĭ)
xidx=[1:winw];
xidxmat=repmat(xidx,winh,1); %repmat ���� ������ �Լ���(�ø� ���, ���η� �ݺ��� ĭ, ���η� �ݺ��� ĭ)

%get center of weight
%%use Gaussian
G=fspecial('gaussian',max(winh,winw),4.5);
G=G(:,1+(winh-winw)/2:winh-(winh-winw)/2);

%������(����׿�) 
iter=0;
    
while true
    nowi=img(winy:winy+winh-1, winx:winx+winw-1);

    %nowhist : �� ��ġ�� ���� ������׷�(weight)
    %�̸� �̿��� �����߽��� ���Ѵ�.
    tmphist=back_projection_matrix/sum(sum(back_projection_matrix));         %�Ϲ�ȭ�� ��� ����� ��
    nowhist=tmphist(winy:winy+winh-1, winx:winx+winw-1);
%     nowhist=tmphist(winy:winy+winh-1, winx:winx+winw-1).*G; %Ŀ�� ������(�����ϴϱ� �� �߳���)
    nowhist=nowhist/sum(sum(nowhist));                   % �Ϲ�ȭ�� ��� ����� ��

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

    %��� : ��Ÿ������ ���(������׷��� ���缺�� ��)
    %%���ο� �������� ������׷�
    old_hist=histcounts(nowi,256);
    old_hist=old_hist/sum(sum(old_hist)); %generalize
    new_hist=histcounts(img(winy:winy+winh-1, winx:winx+winw-1),256);
    new_hist=new_hist/sum(sum(new_hist)); %generalize
    H_old = sum(sqrt(old_hist.*model_hist'));
    H_new = sum(sqrt(new_hist.*model_hist'));
    
    
    %����ó�� (��Ÿ������ ����� �ʹ� �������)
    if(H_new<threshold)
        %Ž������(Ž��������)�� �Ͻ������� 3�� �� ũ�� �����.
        %%%%%%%%preventing index out of range !!!!!!!!!!!!!!
        y1=max(1,winy-winh);
        y2=min(h,winy+2*winh-1);
        x1=max(1, winx-winw);
        x2=min(w,winx+2*winw-1);
       %%%%%%%%%
       
        nowhist=tmphist(y1:y2, x1:x2);
        nowhist=nowhist/sum(sum(nowhist));
        
        %�ε��� �Լ� ũ�⵵ 5��� ����.
        wh=y2-y1+1;
        ww=x2-x1+1;
        tmpyidx=[1:wh];
        tmpyidx=tmpyidx';
        tmpyidxmat=repmat(tmpyidx,1,ww);
        tmpxidx=[1:ww];
        tmpxidxmat=repmat(tmpxidx,wh,1);
        
        newx=sum(sum(nowhist.*tmpxidxmat));
        newy=sum(sum(nowhist.*tmpyidxmat));
        
        %Ȯ��� �ٿ��ڽ� ũ�Ⱑ h,w���� Ŭ ���
        %(ww+1),(wh+1)�� Ȧ���� �ɼ��� �ִ�.
        %�׷���(ww+1)/2, (wh+1)/2�� �Ҽ�(XX.5000)�� �Ǿ� Ŭ��
        %�׷��� �ٿ��ڽ��� Ȯ���ϴ� ���⼭�� round�� ������� �Ѵ�. 
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


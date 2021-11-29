%NSMatlabExamples(4);
NSMU = NSMatlabUtilities();

NSMU.Open('E:\Third year\EEE380\Example AFM Data\PR0137.0_00000.spm');
%[deflSens, deflSensUnits] = NSMU.GetDeflectionSensitivity(NSMU, true);

%numChan = NSMU.GetNumberOfChannels();
    
    %f = figure();
    %movegui(f, 'north');
    %pos = get(f, 'Position');
    %set(f, 'Position', pos + [-150 0 300 0]);
    
    %-------------------------------------------

    
    %get number of image pixels & number of force curves in each scan line
   %[imagePixel, forVolPixel] = NSMU.GetForceVolumeScanLinePixels();
    %NumberOfCurves = NSMU.GetNumberOfForceCurves();
    
    %---------------------------------
    %Display image
    %figure();
    %movegui(f, 'northwest');
%M=imread('E:\大三\EEE380\Example AFM Data\PR0137.0_00000.spm');   %Read the image location 
%threshold = graythresh(M);     %automatically thresholding
%(value for threshold can also be calculated or manually adjusted (from 0 to 255) to personal preferences)
%I = im2bw(M,threshold);       %Binaralization

%figure(1);
%imshow(M);    
%figure(2);
%imshow(I); 

SE = strel('sphere', 1);
figure;
isosurface(SE.Neighborhood);

M=imread('E:\Third year\EEE380\Example AFM Data\PR0137.0_00002_1_corped.spm.jpg');
I = im2bw(M,0.1);
M2 = rgb2gray (M);
figure(1);
imshow (I);
figure(2);
imshow (M);

BW = edge(M2,'canny'); 
figure(3);
imshow (BW);


%生成负片
g1=imadjust(M,[0,1],[1,0]);
 
%将0.5到0.75之间的灰度扩展到0-1之间
g2=imadjust(M,[0.5,0.75],[0,1]);
 
%gamma=2时
g3=imadjust(M,[],[],2);
 
%绘图
subplot(221),imshow(M)
title('原片')
subplot(222),imshow(g1)
title('负片')
subplot(223),imshow(g2)
title('0.5-0.75')
subplot(224),imshow(g3)
title('gamma=2')

img = M;
function[circlefind]=findcircle(img,minr,maxr,stepr,stepa,percent)
r=round((maxr-minr)/stepr)+1;%可增长的步长个数
angle=round(2*pi/stepa);
[m,n]=size(img);
houghspace=zeros(m,n,r);%霍夫空间
[m1,n1]=find(img);%返回二值化边缘检测图像Img中非零点的坐标，m1存放横坐标，n1存放纵坐标
num=size(m1,1);%非零点个数
%霍夫空间，统计相同圆 点的个数
%a = x-r*cos(angle), b = y-r*sin(angle)
for i=1:num
    for j=1:r
        for k=1:angle
            a=round(m1(i)-(minr+(j-1)*stepr)*cos(k*stepa));
            b=round(n1(i)-(minr+(j-1)*stepr)*sin(k*stepa));
            if(a>0&&a<=m&&b>0&&b<=n)
                houghspace(a,b,j)=houghspace(a,b,j)+1;
            end
        end
    end
end
%以阈值来检测圆
par=max(max(max(houghspace)));%找出个数最多的圆的数量作为阈值
par2=par*percent;%百分比percent阈值调整
[m2,n2,r2]=size(houghspace);
circlefind=[];%存储大于阈值的圆的圆心坐标及半径
for i=1:m2
    for j=1:n2
        for k=1:r2
            if (houghspace(i,j,k)>=par2)
                a=[i,j,minr+k*stepr];
                circlefind=[circlefind;a];
            end
        end
    end
end
end



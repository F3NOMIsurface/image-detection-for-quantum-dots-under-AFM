clear;
clc;
M=imread('E:\Third year\EEE380\Example AFM Data\Nice3.0_PR0137.0_00002_1_512x512.png');   %Read the image location 
%threshold = graythresh(M);     %automatically thresholding
%(value for threshold can also be calculated or manually adjusted (from 0 to 1) to personal preferences)
%gray scaling:

K=stretchlim(M);  %获取最佳区间
M2=imadjust(M,K,[]);  %调整灰度范围

%increase strenghth of bright dots
%F = imadjust(M,[0.1 0.9], [0 1]);
%figure, imshow (F)

%blur

%erode
SE = strel('sphere', 2);
I2 = imerode(M,SE);
se = strel('line',6,6);
I2 = imerode(I2,se);
%threshold = graythresh(M);     %automatically thresholding
%(value for threshold can also be calculated or manually adjusted (from 0 to 1) to personal preferences)
I = im2bw(I2,0.3);       %#ok<IM2BW> %Binaralization
%SE = strel('disk', 1);
%I2 = imerode(I2,SE);
%[labeled, numObjects]=bwlabel(I, 8); %* finding the number of area of white sections, only works when the graph is binalized

f=I;

[L,n]= bwlabel(f);

figure(1);
imshow(M2)
figure(2);
imshow(M);    
figure(3);
imshow(I);
figure(4);
imshow(I2);
figure(5); 
imshow(f); title ('finding all the quantum dots');
hold on    % later plotting commands will plot on this image.
% use r (row) and c (column) with mean function to find the center of  mass for the white areas

for k = 1:n % for loop switching from 1 to nth number of the white section

[r,c]= find(L == k); % L stands for Label matrix

rbar = mean(r);

cbar = mean(c);

%plot(cbar,rbar,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);

plot(cbar,rbar,'Marker','*','MarkerEdgeColor','b','MarkerSize',5);     % marking

%text(cbar,rbar,num2str(k),'Color','red','FontSize',10); 

end

%figure,imshow(f);title('标注标号');

%hold on    % So later plotting commands plot on top of the image.

%I = im2bw(M,0.1);

close all
clear;
clc;
M=imread('E:\Third year\EEE380\Example AFM Data\PR0137.0_00002_1_corped.spm_521x521.jpg');   %Read the image location 
figure,imshow(M), title ('original graph');
%threshold = graythresh(M);     %automatically thresholding
%(value for threshold can also be calculated or manually adjusted (from 0 to 1) to personal preferences)

%gray scaling:
%K=stretchlim(M);  %获取最佳区间
%M2=imadjust(M,K,[]);  %调整灰度范围

%increase strenghth of bright dots
%F = imadjust(M,[0.01 0.8], [0 1]);
%figure, imshow (F), title('F');
M2=rgb2gray(M);
figure, imshow (M2), title('grayscaled image');
G1 = adapthisteq(M2,'NumTiles',[115 115],'ClipLimit',0.011); %use function adapthisteq to complete the grayscale histogram equalization processing
figure, imshow (G1), title('image after grayscale histergram equalization');
% %increase strenghth of bright dots
% F2 = imadjust(G1,[0.1 0.80], [0 1]);
% figure, imshow (F2), title('F2');

%anti-blur

%increase strenghth of bright dots
%F2 = imadjust(G1,[0.15 0.95], [0 1]);
%figure, imshow (F2), title('F2');

%erode
SE = strel('Ball',2,2);
I2 = imerode(G1,SE);
figure,imshow(I2), title ('eroded image');
% se = strel('line',6,6);
% I2 = imerode(I2,se);
threshold = graythresh(I2);     %automatically thresholding
%(value for threshold can also be calculated or manually adjusted (from 0 to 1) to personal preferences)
I = im2bw(I2,0.5);       %#ok<IM2BW> %Binaralization
figure,imshow(I), title ('thresholded eroded image');

%cutoff the edges
% BWnobord = imclearborder(I);
% figure, imshow(BWnobord),title('Cleared Border Image');
%SE = strel('disk', 1);
%I2 = imerode(I2,SE);
%[labeled, numObjects]=bwlabel(I, 8); %* finding the number of area of white sections, only works when the graph is binalized

f=I;

[L,n]= bwlabel(f);

%figure,imshow(M2)    
figure, imshow(f); title ('finding all the quantum dots');
hold on    % later plotting commands will plot on this image.
% use r (row) and c (column) with mean function to find the center of  mass for the white areas
x = zeros(n,1);
y = zeros(n,1); 

for k = 1:n  % for loop switching from 1 to nth number of the white section

[r,c]= find(L == k); % L stands for Label matrix

rbar = mean(r);

cbar = mean(c);

plot(cbar,rbar,'Marker','*','MarkerEdgeColor','b','MarkerSize',5);  
%text(cbar,rbar,num2str(k),'Color','red','FontSize',10);


x(k) = rbar;
y(k) = cbar;



end

Centres = [x,y];

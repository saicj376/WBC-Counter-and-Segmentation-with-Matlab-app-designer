clc;clear;
clc;
clear;
[file,path] = uigetfile('*.jpg');
file=strcat(path,file);
figure(1)
a=imread(file);
subplot(1,3,1);imshow(a);
a1=rgb2gray(a);
subplot(1,3,2);imshow(a1);
J = adapthisteq(a1,'clipLimit',0.02,'Distribution','rayleigh');
subplot(1,3,3);imshow(J);
level=graythresh(J);
bw=im2bw(J,level);
figure(2)
subplot(1,3,1);imshow(bw);
k=~bw;
bw4 = imfill(k,'holes');
subplot(1,3,2);imshow(bw4);
bw5 = medfilt2(bw4);
subplot(1,3,3);imshow(bw5);
figure(3)
bw6=bwareaopen(bw5,500);
subplot(1,3,1);imshow(bw6);
bw7 = imfill(bw6,'holes');        
subplot(1,3,2);imshow(bw7);
se = strel('cube',3)
I = imerode(bw7,se);
subplot(1,3,3);
imshow(I);
label=bwlabel(I);
stats=regionprops(label,'Solidity','Area');
density=[stats.Solidity];
area=[stats.Area];
high_dense_area=density>0.5;
max_area=max(area(high_dense_area));
t_label=find(area==max_area);
t=ismember(label,t_label);
se=strel('square',5);
t=imdilate(t,se);
figure(4)
subplot(1,3,1);imshow(t);
h = bwperim(t);
subplot(1,3,2);imshow(h);
CC = bwconncomp(h);
K=CC.NumObjects;
disp(K)
R1=(I-t);
subplot(1,3,3);imshow(R1);
figure(5)
J1=imfill(R1);
subplot(1,3,1);imshow(J1);
h1 = bwperim(J1);
subplot(1,3,2);imshow(h1);
CC2 = bwconncomp(h1);
K1=CC2.NumObjects;
disp(K1)

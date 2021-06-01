clc;
clear;
[file,path] = uigetfile('*.jpg');
file=strcat(path,file);
figure(1)
a=imread(file);
subplot(1,3,1);imshow(a);
a1=rgb2gray(a);
subplot(1,3,2);imshow(a1);
g = a(:, :, 2);
a = zeros(size(a1, 1), size(a1, 2));
just_green = cat(3, a, g, a);
subplot(1,3,3); 
imshow(just_green);
g = just_green(:, :, 2);
figure(2)
subplot(1,3,1);
imshow(g);
B = imlocalbrighten(g );
subplot(1,3,2);
imshow(B)
figure(3)
L=imadjust(B);
subplot(1,3,1);
imshow(L);
H = histeq(B);
subplot(1,3,2);
imshow(H);
R1=imadd(L,H);
subplot(1,3,3);
imshow(R1);
figure(4)
R2 = imsubtract(R1,H);
subplot(1,4,1);
imshow(R2);
R3=imadd(R1,R2);
subplot(1,4,2);
imshow(R3);
R4=imadd(R3,H);
subplot(1,4,3);
imshow(R4);
for i=1:3
    R5=ordfilt2(R4,1,ones(3,3));
end
subplot(1,4,4);
imshow(R5);
figure(5)
level=graythresh(R5);
bw=im2bw(R5,level);
subplot(1,3,1);
imshow(bw);
se = strel('cube',3)
I = imerode(bw,se);
subplot(1,3,2);
imshow(I);

filterStart=tic;
d= strel('disk',9);
bw=imopen(I,d);

out_mask = bw;
    cells = bwconncomp(bw);
    no_of_WBCs=cells.NumObjects;    
    a2 = a1;
    for j=1:no_of_WBCs
        %return the coordinates for the pixels in object j
        [r, c] = find(bwlabel(bw)==j);
        rc = [r c];
        %marking the location of the nuclei of white blood cells by a white
        %colour
        for i=1:max(size(rc))
            a2(rc(i,1),rc(i,2),:)=uint8(a1(rc(i,1),rc(i,2),:)*1.5);
        end
    end
    figure(7);
    bw1 = imcomplement(bw);
    amask = a;
    amask(bw1) = 255;
    subplot(1,3,1);imshow(amask);
    

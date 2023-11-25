close all;
clear all;

im = imread('lena.png');

figure, imshow(im);

height = size(im,1);
width = size(im,2);

#imMedia = im;


%Media
#for i = 2 : height-1
    #for j = 2 : width-1
    # viz = im(i-1:i+1, j-1:j+1,:);
        #imMedia(i,j, 1) = ((sum(sum(sum(viz(:,:,1)))))/9);
       # imMedia(i,j, 2) = (sum((sum(sum(viz(:,:,2)))))/9);
       # imMedia(i,j, 3) = (sum((sum(sum(viz(:,:,3)))))/9);
   # endfor
#endfor

#figure, imshow(imMedia);

#Sobel vertical
#EE = double([-1, 0, 1;  -1,0, 2;  -1, 0, 1]);
#Sobel Horizontal
#EE =  double([-1, -1, -1;  -1, 8, -1;  -1, -1, -1]);
#EE  =  double([-1,-1,-1;0,0,0; 1,2,1]);
#Laplece
EE = double([0,1,0;1,-4,1;0,1,0]);
#Prewitt Vertical
#EE = double([-1,0,1;-1,0,1;-1,0,1]);
# Prewitt Horizontal
#EE = double([-1,-1,-1;0,0,0;1,1,1]);
#Filtro de Sharpening 
#EE = double([0,-1,0;-1,5,-1;0,-1,0]);
#Filtro de Emboss 
#EE = double([-2,-1,0;-1,1,1;0,1,2]);

imSaida = im;

for i = 2  :height-1
   for j = 2 : width-1
        viz = (double(im(i-1:i+1, j-1:j+1))).*EE;
        imSaida(i,j) = sum(sum(viz));
    endfor
endfor

figure, imshow(imSaida);

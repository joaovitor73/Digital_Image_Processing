close all;
clear all;

im = imread('ruido.png');

figure, imshow(im);

height = size(im,1);
width = size(im,2);
im = rgb2gray(im);
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
#Media
EE = [1/9,1/9,1/9;1/9,1/9,1/9; 1/9,1/9,1/9];
#Sobel vertical
#EE = double([-1, 0, 1;  -1,0, 1;  -1, 0, 1]);
#Sobel Horizontal
#EE =  double([-1, -1, -1;  0,0,0;  1,1,1]);
#EE  =  double([-1,-1,-1;0,0,0; 1,2,1]);
#Laplece
#EE = double([0,1,0;1,-4,1;0,1,0]);
#Prewitt Vertical
#EE = double([-1,0,1;-1,0,1;-1,0,1]);
# Prewitt Horizontal
#EE = double([-1,-1,-1;0,0,0;1,1,1]);
#Filtro de Sharpening
#EE = double([0,-1,0;-1,5,-1;0,-1,0]);
#Filtro de Emboss
#EE = double([-2,-1,0;-1,1,1;0,1,2]);

imSaida = uint8(zeros(height+2, width+2));
%Criando uma imagem maior com bordas pretas
imSaida(2:size(imSaida,1)-1, 2:size(imSaida,2)-1) = im;
%Jogando a primeira linha da menor na maior
imSaida(1,2:size(imSaida,2)-1) = im(1,:);
%Jogando a ultima linha da menor na maior
imSaida(size(imSaida,1),2:size(imSaida,2)-1) = im(height,:);
%Jogando a primeira coluna da menor na maior
imSaida(2:size(imSaida,1)-1,1) = im(:,1);
%Jogando a ultima coluna da menor na maior
imSaida(2:size(imSaida,1)-1,size(imSaida,2)) = im(:,width);

imSaida(1,1) = im(1,1);
imSaida(1, size(imSaida,2)) = im(1, width);
imSaida(size(imSaida,1),1) = im(height,1);
imSaida(size(imSaida,1), size(imSaida,2)) = im(height, width);

for i = 2  :height-1
   for j = 2 : width-1
        viz = (double(im(i-1:i+1, j-1:j+1,1))).*EE;
        imSaida(i,j) = sum(sum(viz));
    endfor
endfor

figure, imshow(imSaida);

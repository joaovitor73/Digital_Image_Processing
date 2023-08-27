%Limpando janelas
close all;
%Limpando variaveis
clear all;
pkg load image;

im = imread('dance.png');
imBase = imread('dance_depth.png');

figure('Name', 'Entrada');

subplot(1,2,1);
imshow(im);
title('Imagem original');

subplot(1,2,2);
imshow(imBase);
title('Imagem base');

figure('Name', 'Histograma');
imhist(imBase);

height = size(imBase,1);
width = size(imBase,2);

imObjeto1 = logical(zeros(height, width));
imObjeto2 = logical(zeros(height, width));
imMulher = rgb2gray(im);
imHomem = rgb2gray(im);

for (i = 1 : 1 : height)
  for(j = 1 : 1 : width)
     if(imBase(i,j) >  170)
          imObjeto2(i,j) = 1;
     elseif(imBase(i,j) > 114)
            imObjeto1(i,j) = 1;
     endif
     imMulher(i,j) *= imObjeto1(i,j);
     imHomem(i,j) *= imObjeto2(i,j);
  endfor
endfor


figure('Name', 'Processo');

subplot(1,2,1);
imshow(imObjeto1);

subplot(1,2,2);
imshow(imObjeto2);

figure('Name', 'Saida');

subplot(1,2,1);
imshow(imMulher);

subplot(1,2,2);
imshow(imHomem);

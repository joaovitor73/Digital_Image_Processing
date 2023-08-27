%Limpando janelas
close all;
%Limpando variaveis
clear all;
pkg load image;

im = imread('moon.png');

figure('Name', 'Entrada');

subplot(1,2,1);
imshow(im);
title('Imagem original');

subplot(1,2,2);
imhist(im);
title('Histograma');

height = size(im,1);
width = size(im,2);
imBinarizada = logical(zeros(height, width));
imBinarizadaUser = logical(zeros(height, width));

for (i = 1 : 1 : height)
  for (j = 1 : 1 : width)
    if(im(i,j) < 110)
      imBinarizada(i,j) = 1;
    endif
  endfor
endfor

n = input("Digite um valor para limiarizacao da imagem original: ");

for (i = 1 : 1 : height)
  for (j = 1 : 1 : width)
    if(im(i,j) < n)
      imBinarizadaUser(i,j) = 1;
    endif
  endfor
endfor

imInvertida = uint8(zeros(height, width));

imInvertida = 255-im;

imFinal = imInvertida;


for (i = 1 : 1 : height)
  for (j = 1 : 1 : width)
    if(imBinarizadaUser(i,j) == 1)
      imFinal(i,j) = power(imFinal(i,j), 1.3);
    endif
  endfor
endfor

for (i = 1 : 1 : height)
  for (j = 1 : 1 : width)
    if(imBinarizadaUser(i,j) == 0)
      imFinal(i,j) = power(imInvertida(i,j), 1.3);
    endif
  endfor
endfor


figure('Name','Saida');

subplot(1,4,1);
imshow(im);
title('Imagem original');

subplot(1,4,2);
imshow(imBinarizada);
title('Imagem Binarizada');

subplot(1,4,3);
imshow(imInvertida);
title('Imagem Invertida');


subplot(1,4,4);
imshow(imFinal);
title('Imagem Final');




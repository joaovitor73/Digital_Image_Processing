%Limpando janelas
close all;
%Limpando variaveis
clear all;

pkg load image;

im = imread('lake.png');

figure('Name', 'Entrada');

subplot(1,2,1);
imshow(im);
title('Imagem original');

subplot(1,2,2);
imhist(im);
title('Histograma');

vetorIntensidade = imhist(im);
qtdIntensidades = 0;

for ( i = 1 : 1 : 256)
    if(vetorIntensidade(i,1) != 0)
      qtdIntensidades++;
    endif
endfor

vetorAlargado = zeros(256,1);
vetorPosicoes = zeros(qtdIntensidades,1);

p = 1;
cont = 1;

k = round(255/(qtdIntensidades-1))+1;

for ( i = 1 : 1 : 256)
    if(vetorIntensidade(i,1) != 0)
      vetorAlargado(p,1) = vetorIntensidade(i,1);
      vetorPosicoes(cont,1) = i;
      cont++;
      p+=k;
    endif
endfor

imOriginal = im;

for (i = 1 : 1 : size(im,1))
  for(j = 1 : 1 : size(im,2))
      cont = 1;
      p = 1;
      while((im(i,j) != vetorPosicoes(cont,1)) && cont < 74)
        cont++;
        p+=k;
      endwhile
      if(cont < 74)
        im(i,j) = p;
      else
        im(i,j) = 0;
      endif
  endfor
endfor

figure('Name', 'Entrada');

subplot(1,2,1);
imshow(imOriginal);
title('Imagem original');

subplot(1,2,2);
imshow(im);
title('Imagem com alargamento de contraste');




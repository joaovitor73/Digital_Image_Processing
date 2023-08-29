%Limpando janelas
close all;
%Limpando variaveis
clear all;

pkg load image;

im = imread('lake.png');

vetorIntensidade = imhist(im);
qtdIntensidades = 0;
p = 0;
cont = 0;

for ( i = 1 : 1 : 256)
    if(vetorIntensidade(i,1) != 0)
      qtdIntensidades++;
      if(cont == 0)
        p = vetorIntensidade(i,1);
        cont++;
      endif
    endif
endfor

k = round(255/(qtdIntensidades-1))+1;

im = (im-p)*k;

figure(1);
imshow(im);

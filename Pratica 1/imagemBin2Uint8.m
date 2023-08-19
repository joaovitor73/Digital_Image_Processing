%Limpando janelas
close all;
%Limpando variaveis
clear all;
%Lendo imagem
im = imread('circulo.png');
%Printando imagem
figure('Name', 'Imagem original(Binaria), circulo branco');
imshow(im);
%Copiando a imagem logica para inteiros
im2 = uint8(im);

figure('Name', 'Imagem em inteiros de 8 bits');
imshow(im2);

for (i = 1 : 1 : size(im,1))
  for (j = 1 : 1 : size(im,2))
    if(im2(i,j) == 1)
       im2(i,j) = 126;
    endif
  endfor
endfor

figure('Name', 'Imagem com circulo cinza');
imshow(im2);

%Salvando imagem
imwrite(im2, 'circulo2.png');

close all;
clear all;

%1. Criar uma imagem vazia;
%2. Percorrer a imagem gerando um degrad? de 256 tons de cinza;
%3. Abrir uma nova janela;
%4. Mostrar a imagem em degrad?;

im = uint8(zeros(50, 256));

for i = 1 : size(im,1)
  for j = 1 : size(im,2)
      im(i,j) = j;
  endfor
endfor

figure(1);
imshow(im);


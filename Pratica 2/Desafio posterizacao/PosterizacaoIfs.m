%Limpando janelas
close all;
%Limpando variaveis
clear all;

im = imread('lena.png');
figure('Name', 'Imagem original');
imshow(im);

N = input ("Digite a quantidade de niveis de intensidade: ");
imPosterizada = uint8(zeros(512,512));
x = round(255/N);
y = round(255/(N-1));

for i = 1 : size(im,1)
  for j = 1 : size(im,2)
    cont = 1;
    if(im(i,j) >= x)
      while(im(i,j) > x*cont)
        cont++;
      endwhile
      imPosterizada(i,j) = y*(cont-1);
     endif
  endfor
endfor

figure('Name', 'Imagem posterizada');
imshow(imPosterizada);

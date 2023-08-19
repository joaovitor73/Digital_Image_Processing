%Limpando janelas
close all;
%Limpando variaveis
clear all;

im = imread('lena.png');
figure('Name', 'Imagem original');
imshow(im);

for i = 1 : size(im,1)
  cont = 255;
  for j = 1 : size(im,2)
    if(j < size(im,2)/2)
      imDegrade(i,j) = im(i,j)-cont;
      cont--;
    else
      imDegrade(i,j) = im(i,j)+cont;
      cont++;
    endif
  endfor
endfor

imPosterizada = im;

for i = 1 : size(im,1)
  for j = 1 : size(im,2)
    if(im(i,j) > 85 && im(i,j) < 170)
      imPosterizada(i,j) = 126;
    elseif(im(i,j) >= 170)
      imPosterizada(i,j) = 255;
    else
      imPosterizada(i,j) = 0;
    endif
  endfor
endfor

figure('Name', 'Imagem degrade');
imshow(imDegrade);
figure('Name', 'Imagem posterizada');
imshow(imPosterizada);





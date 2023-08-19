%Limpando janelas
close all;
%Limpando variaveis
clear all;

im = uint8(zeros(255,255));

k = 0;

for(i = 1: 1 : size(im,1))
  for(j = 1 : 1 : size(im,2))
        im(i, j) = k;
  endfor
  k++;
endfor

im2 = im;

for(i = 1: 1 : size(im,1))
  for(j = 1 : 1 : size(im,2))
      if(((j >= 8) && (j <= 24)) || ((j >= size(im,2)-24) && (j <= size(im,2)-8)) || ((i >= 8) && (i <= 24)) || ((i >= size(im,1)-24) && (i <= size(im,1)-8)))
        im2(i, j) = 126;
      endif
  endfor
endfor

figure('Name', 'Saidas');
subplot(1,2,1);
imshow(im), title("imagem degrade");
subplot(1,2,2);
imshow(im2), title("imagem com moldura");



close all;
clear all;

im = imread('lena.jpg');
imCinza = (im(:,:,1)*0.3+im(:,:,2)*0.59+im(:,:,3)*0.11);

for i = 1 : size(im,1)
  cont = 255;
  for j = 1 : size(im,2)
    if(j < size(im,2)/2)
      imCinza(i,j) = imCinza(i,j)-cont;
      cont--;
    else
      imCinza(i,j) = imCinza(i,j)+cont;
      cont++;
    endif
  endfor
endfor


figure(1);
imshow(imCinza);


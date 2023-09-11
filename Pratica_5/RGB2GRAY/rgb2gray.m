close all;
clear all;

im = imread('cores.jpg');

imGray = (im(:,:,1) * 0.2989) + (im(:,:,2) * 0.5870) + (im(:,:,3) * 0.1140);

figure(1);

subplot(1,2,1);
imshow(im);
title('Entrada');

subplot(1,2,2);
imshow(imGray);
title('Escala de cinza');

imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);

figure(2);

subplot(1,3,1);
imshow(imR);
title('Canal Vermelho');

subplot(1,3,2);
imshow(imG);
title('Canal Verde');

subplot(1,3,3);
imshow(imB);
title('Canal Azul');

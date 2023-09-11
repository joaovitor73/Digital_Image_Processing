close all;
clear all;

im = imread('milho.png');

figure(1);

subplot(1,4,1);
imshow(im(:,:,1));
title('Canal Vermelho');

subplot(1,4,2);
imshow(im(:,:,2));
title('Canal Verde');

subplot(1,4,3);
imshow(im(:,:,3));
title('Canal Azul');

subplot(1,4,4);
imshow(im);
title('Imagem original');

imMask = im(:,:,1) > 180;

figure('Name', 'Mascara');
imshow(imMask);

imFinal = imMask.*im;
figure('Name', 'Imagem final');
imshow(imFinal);



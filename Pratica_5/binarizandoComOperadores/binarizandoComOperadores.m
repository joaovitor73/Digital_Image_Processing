close all;
clear all;

im = imread('neuron.jpg');

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

imSaida1 = (im(:,:,1) - im(:,:,3)) - im(:,:,2) ;
imSaida2 = ((im(:,:,1) > 190) & (~(im(:,:,3) > 200) != 0));


figure(1);

figure('Name', 'Saidas');

subplot(1,3,1);
imshow(im);
title('Imagem entrada');

subplot(1,3,2);
imshow(imSaida1);
title('Saida 1');

subplot(1,3,3);
imshow(imSaida2);
title('Saida 2');


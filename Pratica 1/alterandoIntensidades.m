%Limpando janelas
close all;
%Limpando variaveis
clear all;
%Lendo imagem

im = imread('lena.png');
figure('Name', 'Imagem original');
imshow(im);

im(:,:,:) = im(:,:,:)+80;
figure('Name', 'Imagem com aumento de intensidade');
imshow(im);

im(:,:,:) = im(:,:,:)-80;
figure('Name', 'Imagem com reducao de intensidade');
imshow(im);

k = input ("Digite um valor para alterar a intensidade da imagem original: ");
im(:,:,:) = im(:,:,:)+k;
figure('Name', 'Imagem com alteracao de intensidade digitada pelo usuario');
imshow(im);


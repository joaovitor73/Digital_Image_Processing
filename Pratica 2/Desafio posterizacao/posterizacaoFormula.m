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

imPosterizada(:,:) = y*(round(im(:,:)-(x/N))/(y*0.8));

figure('Name', 'Imagem posterizada');
imshow(imPosterizada);

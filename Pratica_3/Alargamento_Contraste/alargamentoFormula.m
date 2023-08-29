%Limpando janelas
close all;
%Limpando variaveis
clear all;

pkg load image;

im = imread('lake.png');

vetorIntensidade = imhist(im);

qtd = sum(vetorIntensidade != 0);
k = round(255/(qtd-1))+1;
p = find(vetorIntensidade != 0,1);

im = (im-p)*k;

figure(1);
imshow(im);

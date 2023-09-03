%Limpando janelas
close all;
%Limpando variaveis
clear all;

mascara1 = logical(imread('mask_2.tif'));
mascara2 = imread('mask_3.tif');

saida = mascara1.*mascara2;

figure('Name','Saida');
imshow(saida);

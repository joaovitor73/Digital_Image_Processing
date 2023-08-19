%Limpando janelas
close all;
%Limpando variaveis
clear all;

im = imread('lena.png');
figure('Name', 'Imagem original');
imshow(im);

tic();

for(i = 1 : 1 : size(im,1))
  for(j = 1 : 1 : size(im,2))
    imClara(i, j) = im(i,j)*1.8;
    imEscura(i,j) = im(i,j)*0.2;
  endfor
endfor

tempoFor = toc();

tic();
imClara(:,:) = im(:,:)*1.8;
imEscura(:,:) = im(:,:)*0.2;
tempoAtribuicaoDireta = toc();


figure('Name', 'Saidas');
subplot(1,2,1);
imshow(imClara);
subplot(1,2,2);
imshow(imEscura);




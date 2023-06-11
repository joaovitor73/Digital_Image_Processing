close all;
clear all;

%Leitura
im = imread('lena.jpg');

%Transformando imagem para tons de cinza
imCinza = (im(:,:,1)*0.3+im(:,:,2)*0.59+im(:,:,3)*0.11);

%Copias
saida1 = imCinza;
saida2 = imCinza;

%Medir tempo de execucao do  for
t = tic;

%For para alterar brilho
for i = 1 : size(im,1)
  for j = 1 : size(im,2)
     saida1(i,j) *= 1.4;
     saida2(i,j) *= 0.4;
  endfor
endfor

toc(t)

%Printando
figure('Name', 'Imagem cinza');
imshow(imCinza);
figure('Name', 'Imagem com mais brilho(For)');
imshow(saida1);
figure('Name' , 'Imagem com menos brilho(For)');
imshow(saida2);

%Salvando saidas no disco
imwrite(imCinza, 'imCinza.png');
imwrite(saida1, 'imMaisBrilho.png');
imwrite(saida2, 'imMenosBrilho.png');

%Medir tempo de execucao da atribuicao direta
t = tic;

saida4(:,:) = 1.4*imCinza(:,:);
saida5(:,:) = 0.4*imCinza(:,:);

toc(t)

figure('Name', 'Imagem com mais brilho(Atribuicao direta)');
imshow(saida4);
figure('Name' , 'Imagem com menos brilho(Atribuicao direta)');
imshow(saida5);


%Limpando janelas
close all;
%Limpando variaveis
clear all;

imT = imread('object_1.jpg');
background = imread('background_2.jpg');
background1 = imread('background_4.jpg');
mascara = imread('mask_1.bmp');

%Negativo
mascara = 1-mascara;

%Rotacao 90 graus direita
mascaraRotacionada = mascara;
for(j = 1 : 1 : 512)
  for(i = 1 : 1 : 512)
    mascaraRotacionada(513-j,513-i) = mascara(i,j);
  endfor
endfor

%Negativo
imT = 255-imT;


for(i = 1 : 1 : 512)
  for(j = 1: 1 : 512)
    if(imT(i,j) < 150)
      imT(i,j) = background(i,j);
    endif
  endfor
endfor

%Espelhamento
backEepe = background1;
for(i = 1 : 1 : 512)
  for(j = 1 : 1 : 512)
    backEepe(513-i,j) = background1(i,j);
  endfor
endfor

%Operacao
quadro = imT.*mascaraRotacionada;

for(j = 1 : 1 : 512)
  for(i = 1 : 1 : 512)
    if(mascaraRotacionada(i,j) == 0)
      quadro(i,j) = backEepe(i,j);
    endif
  endfor
endfor

imwrite(quadro, 'imSaida.png');

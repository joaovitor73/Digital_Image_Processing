%Limpando janelas
close all;
%Limpando variaveis
clear all;

im = imread('mapa_menor.png');
maskB = im(:,:,3) > 150;

%Dimensao da imagem
fimX = size(im,1);
fimY = size(im,2);

flag = false;
x1 = 0;
y1 = 0;
inicioX = round(fimX/2);
inicioY = round(fimY/2);
%Pegando o primeiro pixel da metrica
for(i = inicioX : fimX)
  for(j = inicioY : fimY)
    if(maskB(i,j) == 1)
      x1 = i;
      y1 = j;
      flag = true;
    endif
    if(flag)
      break;
    endif
  endfor
  if(flag)
    break;
  endif
endfor

flag = false;
%Pegando o ultimo pixel da metrica
for(i = fimX : -1 : inicioX)
  for(j = fimY : -1 : inicioY)
    if(maskB(i,j) == 1)
      x2 = i;
      y2 = j;
      flag = true;
    endif
    if(flag)
      break;
    endif
  endfor
  if(flag)
    break;
  endif
endfor


%Calculo do diametro da metrica
diametroMetrica = sqrt(power(x2-x1,2)+power(y2-y1,2))

maskR = im(:,:,1) > 150;
flag = false;

for(i = 1:  inicioX)
  for(j = 1 : fimY)
    if(maskR(i,j) == 1)
      x3 = i;
      y3 = j;
      flag = true;
    endif
    if(flag)
      break;
    endif
  endfor
  if(flag)
    break;
  endif
endfor


flag = false;
%Pegando o ultimo pixel da metrica
for(i = inicioX : -1 : 1)
  for(j = inicioY : -1 : 1)
    if(maskR(i,j) == 1)
      x4 = i;
      y4 = j;
      flag = true;
    endif
    if(flag)
      break;
    endif
  endfor
  if(flag)
    break;
  endif
endfor

distanciaPontos = sqrt(power(x4-x3,2)+power(y4-y4,2))
distanciaPontosKm = ((distanciaPontos*10)/diametroMetrica)

figure(1);
imshow(im);

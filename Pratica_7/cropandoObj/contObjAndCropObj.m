%Limpando janelas
close all;
%Limpando variaveis
clear all;
pkg load image;
im = imread('soja.png');

%im = imread('objetos.jpg');
imCopy = im;
height = size(im,1);
width = size(im,2);
%Separando background de foreground
mask = (im(:,:,1)) > 100;
%Imagem que vai conter rotulos
imSaida = uint8(zeros(height, width));

%Posso guarda apenas duvidas unicas
function possoGuarda = possoGuardarDuvida(cima, lado, erros)
  flag = true;
   for(k = 2 : 2 : size(erros,2))
      if((erros(1,k) == lado) && (cima == erros(1,k-1)) || ((erros(1,k-1) == lado) && (cima == erros(1,k))))
       flag = false;
        break;
      endif
    endfor
    possoGuarda = flag;
endfunction

function alturaObj = alturasObj(inicioX, inicioY, fimX, fimY, img, passo, rotulosObj, mask)
  rotuloObj = [0];
  flag = true;
  cordenadas = [];
  for (i = inicioX : passo : fimX)
    for (j = inicioY : passo : fimY)
      if(mask(i,j))
        for(k = 1 : size(rotuloObj,2))
          if(img(i,j) == rotuloObj(1,k) && rotuloObj(1,k) != 0)
            flag = false;
          endif
         endfor
          if(flag)
            rotuloObj = [rotuloObj,img(i,j)];
            cordenadas  = [cordenadas ,i, img(i,j)];
         endif
         flag = true;
       endif
     endfor
  endfor

  if(passo == -1)
    y2s = [];
    for(i = 1 : size(rotulosObj,2))
      for(j = 2 : 2 : size(cordenadas,2))
        if(rotulosObj (1,i) == cordenadas(1,j))
          y2s = [y2s, cordenadas(1,j-1), cordenadas(1,j)];
        endif
      endfor
    endfor
    cordenadas = y2s;
  endif
  alturaObj = cordenadas;
endfunction

function larguraObj = larguraObj(inicioX, inicioY, fimX, fimY, img, passo, rotulosObj, mask)
  rotuloObj = [0];
  flag = true;
  cordenadas = [];
  for (i = inicioX : passo : fimX)
    for (j = inicioY : passo : fimY)
      if(mask(j,i))
        for(k = 1 : size(rotuloObj,2))
          if(img(j,i) == rotuloObj(1,k) && rotuloObj(1,k) != 0)
            flag = false;
          endif
         endfor
          if(flag)
            rotuloObj = [rotuloObj,img(j,i)];
            cordenadas  = [cordenadas ,j, img(j,i)];
         endif
         flag = true;
       endif
     endfor
  endfor


  y2s = [];
  for(i = 1 : size(rotulosObj,2))
    for(j = 2 : 2 : size(cordenadas,2))
      if(rotulosObj (1,i) == cordenadas(1,j))
        y2s = [y2s, cordenadas(1,j-1), cordenadas(1,j)];
      endif
    endfor
  endfor

  larguraObj = y2s;
endfunction

function procurarRotulos = procurarRotulos(inicioX, inicioY, fimX, fimY, img, passo, mask)
  rotuloObj = [0];
  flag = true;
  for (i = inicioX : passo : fimX)
    for (j = inicioY : passo : fimY)
      if(mask(i,j))
        for(k = 1 : size(rotuloObj,2))
          if(img(i,j) == rotuloObj(1,k))
            flag = false;
          endif
         endfor
          if(flag)
            rotuloObj = [rotuloObj,img(i,j)];
         endif
         flag = true;
       endif
     endfor
  endfor
  procurarRotulos = rotuloObj;
endfunction

cont = 0; %Rotula a imagem saida
erros = [];
flag = true;
im = mask;

for (i = 1 : height)
  for (j = 1 : width)
    if(im(i,j) && (i-1 > 0) && (j-1 > 0) && (i+1 <= width)) %Pixel da vez e branco
      %Diagonal superior direita e o lado esquerdo fazem parte do objetos, mas com rotulos diferentes
        if(im(i-1,j+1) && im(i,j-1) && (imSaida(i-1,j+1) != imSaida(i,j-1)))
               imSaida(i,j) = imSaida(i-1,j+1);
                if(possoGuardarDuvida(imSaida(i-1,j+1), imSaida(i,j-1), erros))
                  erros = [erros, imSaida(i-1,j+1), imSaida(i,j-1)];
                endif
        elseif(im(i-1,j+1) && im(i-1,j-1) && (imSaida(i-1,j+1) != imSaida(i-1,j-1)))
               imSaida(i,j) = imSaida(i-1,j-1);
                if(possoGuardarDuvida(imSaida(i-1,j+1), imSaida(i-1,j-1), erros))
                  erros = [erros, imSaida(i-1,j+1), imSaida(i-1,j-1)];
                endif
       elseif(im(i-1,j+1))
                    imSaida(i,j) = imSaida(i-1,j+1);
      %Diagonal superior esquerda e o lado esquerdo fazem parte do objetos, mas com rotulos diferentes
      elseif(im(i-1,j-1) && im(i,j-1) && (imSaida(i-1,j-1) != imSaida(i,j-1)))
                imSaida(i,j) = imSaida(i-1,j-1);
                if(possoGuardarDuvida(imSaida(i-1,j-1), imSaida(i,j-1), erros))
                  erros = [erros, imSaida(i-1,j-1), imSaida(i,j-1)];
                endif
      elseif(im(i-1,j-1) &&  im(i-1,j) && (imSaida(i-1,j-1) != imSaida(i-1,j)))
          imSaida(i,j) = imSaida(i-1,j-1);
          if(possoGuardarDuvida(imSaida(i-1,j-1), imSaida(i-1,j), erros))
            erros = [erros, imSaida(i-1,j-1), imSaida(i-1,j)];
          endif
      elseif(im(i-1,j-1))
          imSaida(i,j) = imSaida(i-1,j-1);
      %Pixel acima e o lado esquerdo fazem parte do objetos, mas com rotulos diferentes
      elseif(im(i-1,j) && im(i,j-1) && (imSaida(i-1,j) != imSaida(i,j-1)))
                imSaida(i,j) = imSaida(i-1,j);
                if(possoGuardarDuvida(imSaida(i-1,j), imSaida(i,j-1), erros))
                    erros = [erros, imSaida(i-1,j), imSaida(i,j-1)];
                endif
                %pega o rotulo do pixel acima
     elseif(im(i-1,j))
                  imSaida(i,j) = imSaida(i-1,j);
            %pega o rotulo do pixel ao lado esquerdo
      elseif(im(i,j-1))
             imSaida(i,j) = imSaida(i,j-1);
      else
          cont++;
         imSaida(i,j,1) = cont;
      endif
    endif
  endfor
endfor


%Corrigir erros
for (i = 1 : height)
  for (j = 1 : width)
    if(imSaida(i,j))
      for(k = size(erros,2) : -2 : 2)
        if(imSaida(i,j) == erros(1,k))
            imSaida(i,j) =  erros(1,k-1);
        endif
       endfor
     endif
   endfor
endfor

rotuloObj = [0];
flag = true;
y1s = [];
y1s = double(y1s);
x = imSaida;
for (i = 1 : height)
  for (j = 1 : width)
    if(mask(i,j))
      for(k = 2 : size(rotuloObj,2))
        if(imSaida(i,j) == rotuloObj(1,k))
          flag = false;
        endif
       endfor
        if(flag)
          rotuloObj = [rotuloObj,imSaida(i,j)];
          y1s  = double([y1s ,double(i), double(imSaida(i,j))]);
          %x(i,j,:) = 280;
       endif
       flag = true;
     endif
   endfor
endfor


rotuloObjAux = [0];
flag = true;
y2sAux = [];
y2sAux = double(y2sAux);
for (i = height : -1 : 1)
  for (j = width : - 1 : 1)
      if(mask(i,j))
      for(k = 2 : size(rotuloObjAux,2))
        if(imSaida(i,j) == rotuloObjAux(1,k))
          flag = false;
        endif
       endfor
        if(flag)
          rotuloObjAux = [rotuloObjAux,imSaida(i,j)];
          y2sAux  = double([y2sAux ,double(i), double(imSaida(i,j))]);
        % x(i,j,:) = 280;
       endif
       flag = true;
     endif
   endfor
endfor

y2s = [];
for(i = 1 : size(rotuloObj,2))
  for(j = 2 : 2 : size(y2sAux  ,2))
    if(rotuloObj (1,i) == y2sAux(1,j))
      y2s = [y2s, y2sAux(1,j-1), y2sAux(1,j)];
    endif
  endfor
endfor


rotuloObjAux2 = [0];
flag = true;
x1sAux = [];
x1sAux = double(x1sAux);
for (i = 1 : width)
  for (j = 1 : height)
      if(mask(j,i))
      for(k = 2 : size(rotuloObjAux2,2))
        if(imSaida(j,i) == rotuloObjAux2(1,k))
          flag = false;
        endif
       endfor
        if(flag)
          rotuloObjAux2 = [rotuloObjAux2,imSaida(j,i)];
          x1sAux  = double([x1sAux,double(i), double(imSaida(j,i))]);
          x(j,i,:) = 280;
       endif
       flag = true;
     endif
   endfor
endfor

x1s = [];
for(i = 1 : size(rotuloObj,2))
  for(j = 2 : 2 : size(x1sAux ,2))
    if(rotuloObj (1,i) == x1sAux(1,j))
      x1s = [x1s, x1sAux(1,j-1), x1sAux(1,j)];
    endif
  endfor
endfor

rotuloObjAux3 = [0];
flag = true;
x2sAux = [];
x2sAux = double(x2sAux);
for (i = width : -1 : 1)
  for (j = height : - 1 : 1)
      if(mask(j,i))
      for(k = 2 : size(rotuloObjAux3,2))
        if(imSaida(j,i) == rotuloObjAux3(1,k))
          flag = false;
        endif
       endfor
        if(flag)
          rotuloObjAux3 = [rotuloObjAux3,imSaida(j,i)];
          x2sAux  = double([x2sAux,double(i), double(imSaida(j,i))]);
          x(j,i,:) = 280;
       endif
       flag = true;
     endif
   endfor
endfor

x2s = [];
for(i = 1 : size(rotuloObj,2))
  for(j = 2 : 2 : size(x1sAux ,2))
    if(rotuloObj (1,i) == x2sAux(1,j))
      x2s = [x2s, x2sAux(1,j-1), x2sAux(1,j)];
    endif
  endfor
endfor
cont=1;
for(j = 1 : 2 : size(x2s,2))
  figure(cont);
  imshow(imCopy(y1s(1,j):y2s(1,j), x1s(1,j):x2s(1,j),:));
  cont++;
endfor
qtdObj =  size(rotuloObj,2)-1


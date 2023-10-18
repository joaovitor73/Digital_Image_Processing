%Limpando janelas
close all;
%Limpando variaveis
clear all;
im = imread('space_invaders.png');
height = size(im,1);

width = size(im,2);
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

cont = 0; %Rotula a imagem saida
erros = [];
flag = true;

for (i = 1 : height)
  for (j = 1 : width)
    if(im(i,j)) %Pixel da vez e branco
      %Diagonal superior direita e o lado esquerdo fazem parte do objetos, mas com rotulos diferentes
      if(im(i-1,j+1) && !im(i-1,j-1) && (i-1 > 0) && im(i,j-1) && (j-1 > 0) && (i+1 <= width) && (imSaida(i-1,j+1) != imSaida(i,j-1)))
          imSaida(i,j) = imSaida(i-1,j+1);
          if(possoGuardarDuvida(imSaida(i-1,j+1), imSaida(i,j-1), erros))
            erros = [erros, imSaida(i-1,j+1), imSaida(i,j-1)];
          endif
      %Diagonal superior direita faz parte do objeto, mas o lado esquerdo nao
      elseif(im(i-1, j+1) && !im(i-1,j-1) && (i-1 > 0) && (j-1 > 0) && (i+1 <= width) && !im(i,j-1))
              imSaida(i,j) = imSaida(i-1,j+1);
      %Diagonal superior esquerda e o lado esquerdo fazem parte do objetos, mas com rotulos diferentes
      elseif(im(i-1,j-1)  && im(i,j-1) && (i-1 > 0) && (j-1 > 0) && (imSaida(i-1,j-1) != imSaida(i,j-1)))
              imSaida(i,j) = imSaida(i-1,j-1);
              if(possoGuardarDuvida(imSaida(i-1,j-1), imSaida(i,j-1), erros))
                erros = [erros, imSaida(i-1,j-1), imSaida(i,j-1)];
              endif
      %Diagonal superior esquerda faz parte do objeto, mas o lado esquerdo nao
      elseif((im(i-1, j-1))  && (i-1 > 0) && (j-1 > 0) && !im(i,j-1))
             imSaida(i,j) = imSaida(i-1,j-1);
      %Pixel acima e o lado esquerdo fazem parte do objetos, mas com rotulos diferentes
      elseif(im(i-1,j) && im(i,j-1) &&  (i-1 > 0) && (j-1 > 0) && (imSaida(i-1,j) != imSaida(i,j-1)))
            imSaida(i,j) = imSaida(i-1,j);
            if(possoGuardarDuvida(imSaida(i-1,j), imSaida(i,j-1), erros))
                erros = [erros, imSaida(i-1,j), imSaida(i,j-1)];
            endif
      %pega o rotulo do pixel acima
      elseif(im(i-1,j) && (i != 1))
            imSaida(i,j) = imSaida(i-1,j);
      %pega o rotulo do pixel ao lado esquerdo
      elseif(im(i,j-1) && (j != 1))
            imSaida(i,j) = imSaida(i,j-1);
      else
         cont+=13;
         imSaida(i,j) = cont;
      endif
    endif
  endfor
endfor

%Corrigir erros
for (i = 1 : height)
  for (j = 1 : width)
    for(k = 2 : 2 : size(erros,2))
      if(imSaida(i,j) == erros(1,k))
          imSaida(i,j) =  erros(1,k-1);
      endif
     endfor
   endfor
endfor

figure(1);
imshow(imSaida);
qtdObj = (cont/13)-(size(erros,2)/2)

close all;
clear all;
pkg load image;

im = imread('objetos.jpg');

height = size(im,1);
width = size(im,2);

mask = im(:,:,1) > 100;
#mask = im> 100;
imSaida = uint8(zeros(height,width));

%Guarda apenas duvidas unicas
function possoGuarda = possoGuardarDuvida(cima, lado, erros)
  flag = true;
   for(k = 2 : 2 : size(erros,2))
     %Percorre todo o vetor de erro para verificar se o erro e unico
      if((erros(1,k) == lado) && (cima == erros(1,k-1)) || ((erros(1,k-1) == lado) && (cima == erros(1,k))))
       flag = false;
        break;
      endif
    endfor
    possoGuarda = flag;
endfunction

cont = 0; %Rotula a imagem saida
erros = []; %Vetor que vai guardar duvidas unicas
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
      %Atribui o erro de agora para o erro anterior
        if(imSaida(i,j) == erros(1,k))
            imSaida(i,j) =  erros(1,k-1);
        endif
       endfor
     endif
   endfor
endfor

vetor =  imhist(imSaida);
qtd = length(vetor(vetor!=0))-1

figure, imshow(imSaida);

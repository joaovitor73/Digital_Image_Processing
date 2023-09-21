%Joao Vitor Gomes Vieira

%Limpando janelas
close all;
%Limpando variaveis
clear all;

pkg load image;

mask = imread('mask_32.png');

figure('Name','Histograma');
imhist(mask);

figure('Name','Mascara');
imshow(mask);

hMask = size(mask,1);
wMask =size(mask,2);

arvore = imread('land_32.png');
arvoreCopy = arvore;
arvore = 255-arvore;


cont = 7;

for(i = 1 : hMask )

  for(j = 1 : wMask)

    if(cont > 6)
      arvoreCopy(i,j,:) = 0;
    endif

    if(cont == 9)
      cont = 0;
    endif

  endfor
cont++;
endfor


peixe = imread('animal_32.png');
peixe = rgb2gray(peixe);
peixeCopy = peixe;



for(k = 1: wMask)
  peixe(k,:) = peixeCopy(:,k);
endfor


for(k = 1: wMask)
  peixe(k,:) = peixeCopy(:,513-k);
endfor



ass = imread('tads_32.png');
ass = 255-ass;

hAss = size(ass,1);
wAss =size(ass,2);

fundo = imread('text_32.png');

fundoCopy = fundo;



x = 1;
y = 1;

for(i = 1: hMask)
  for(j = 1: wMask)
     if(mask(i,j) == 127)
        mask(i,j,1) = 0;
        mask(i,j,2) = 255;
        mask(i,j,3) = 255;
     else
        if(mask(i,j) == 0)
          mask(i,j,:) = arvore(i,j,:);
        else
          if(mask(i,j) == 255)
            mask(i,j,:) = peixe(i,j,:);
          else
            if(mask(i,j) == 60)
                 mask(i,j,:) = arvoreCopy(i,j,:);
            else

                    mask(i,j,:) = 0;

            endif
          endif
        endif
     endif
  endfor
endfor

for(i = 1: hAss)
  for(j = 1: wAss)
    if(ass(i,j) > 100);
      ass(i,j,:) = 0;
      mask(i,351+j,:) = ass(i,j,:);
    else
       mask(i,351+j,:) = fundo(i,j,:) ;
    endif
  endfor
endfor


figure('Name','Saida');
imshow(mask)



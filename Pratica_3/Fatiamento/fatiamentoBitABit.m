%Limpando janelas
close all;
%Limpando variaveis
clear all;

im = imread('fractal.png');

height = size(im,1);
width = size(im,2);
dec = 0;
imagens = cell(1,8);

for (i = 1: 1 : 8)
    imagens{i} = logical(zeros(height,width));
end

cont = 1;
bit = 0;
for (i = 1 : 1 : height)
  for (j = 1 : 1 : width)
     dec = im(i,j);
     bin = dec2bin(dec);
     bin =  fliplr (bin);
     cont = 1;
     while(cont <= 8)
        if(cont <= size(bin,2))
            bit = str2double(bin(1,cont)) == 1;
            imagemVez = imagens{cont};
            imagemVez(i,j) = bit;
            imagens{cont} = imagemVez;
        else
            cont = 8;
        endif
        cont++;
     endwhile
  endfor
endfor

imSaida = imagens{7}+imagens{8};
figure('Name', 'Saida');

subplot(1,2,1);
imshow(im);
title('Imagem Original');

subplot(1,2,2);
imshow(imSaida);
title('imSaida');


clear all;
close all;

im1 = imread('brain.png');
im2 = imread('orgao.png');
im3 = imread('ruido.png');

im = im3;

figure, imshow(im);

height = size(im, 1);
width = size(im, 2);

erodir = true;
kernel_rect = true;

if kernel_rect
    altura = 5;
    largura = 5;
    EE = logical(ones(altura, largura));
    comecoX = floor(altura/2);
    comecoY = floor(largura/2);
    imMaior = zeros(height+comecoX*2, width+comecoY*2);
    heightM = size(imMaior,1);
    widthM = size(imMaior, 2);
    imMaior(comecoX+1: heightM-comecoX, comecoY+1:widthM-comecoY) = im;
else
    raio = 3;
    tam = raio*2+1;
    EE = logical(ones(tam, tam));
    comecoX = floor(raio/2);
    comecoY = floor(raio/2);
    distanciaVez = 0;
    for i = 1:ta
        for j = 1:tam
            distanciaVez = sqrt((i - (raio+1)).^2 + (j - (raio+1)).^2);
            EE(i, j) = distanciaVez <= raio;
        endfor
    endfor
endif

if erodir
    for i =  comecoX+1:heightM-comecoX
        for j =  comecoY+1:widthM-comecoY
            if imMaior(i, j)
                viz = imMaior(i- comecoX:i+ comecoX, j-comecoY:j+comecoY);
                if sum(sum(viz)) != altura*largura
                    im(i-comecoX, j-comecoX) = 0;
                endif
            endif
        endfor
    endfor
else
    for i = comecoX+1:height+comecoX
        for j = comecoY+1:width+comecoY
            if imMaior(i, j) ==  0
                viz = imMaior(i-comecoX:i+comecoX, j-comecoY:j+comecoY);
                if sum(sum(viz)) != 0
                    im(i-comecoX, j-comecoX) = 1;
                endif
            endif
        endfor
    endfor
end


figure, imshow(im);

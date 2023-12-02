close all;
clear all;

im = imread('imagem.png');

%Reducao
heightIm = size(im,1);
widthIm = size(im,2);

%Interpolacao subamostragem
imNovaPeqeuna = uint8(zeros((heightIm/2),(widthIm/2),3));

passo = 2;

for i=passo : passo : heightIm
    for j=passo : passo : widthIm
        imNovaPeqeuna(i/passo,j/passo,:) = im(i,j,:);
    endfor
endfor

figure, imshow(imNovaPeqeuna);

%Interpolacao media arimitetica
imNovaPeqeuna2 = uint8(zeros((heightIm/2),(widthIm/2),3));

passo = 2;
im = double(im);

for i=passo : passo : heightIm
    for j=passo : passo : widthIm
        imNovaPeqeuna2(i/passo,j/passo,:) = (im(i, j,:)+im(i-1, j,:)+im(i, j-1,:)+im(i-1, j-1,:))/4;
    endfor
endfor

figure, imshow(imNovaPeqeuna2);

%Aumento
imGrande = uint8(zeros(widthIm*2, heightIm*2,3));

heightImGrande = size(imGrande, 1);
widthImGrande = size(imGrande,2);

%Preenchendo a imagem maior
for i = passo : passo : heightImGrande
    for j = passo : passo : widthImGrande
        imGrande(i,j,:) = im(i/passo, j/passo,:);
    endfor
endfor

figure, imshow(imGrande)


%Interpolacao vizinho mais proximo
imViziMaisProx = imGrande;

%Preenche as linhas

for i = heightImGrande : -passo : 1
    for j = widthImGrande-1 : -passo : 1
        imViziMaisProx(i,j,:) = imGrande(i, j+1, :);
    endfor
endfor

for i = heightImGrande -1 : -passo : 1
    for j = widthImGrande-1 : -passo : 1
        imViziMaisProx(i,j,:) = imGrande(i+1, j+1, :);
    endfor
endfor

for i = heightImGrande -1 : -passo : 1
    for j = widthImGrande : -passo : 1
        imViziMaisProx(i,j,:) = imGrande(i+1, j, :);
    endfor
endfor

figure, imshow(imViziMaisProx);

%Interpolacao bilinear
imBilinear = imGrande;
imGrande = double(imGrande);
%Preenche as linhas

for i = heightImGrande : -passo : 1
    for j = widthImGrande-1 : -passo : 2
        imBilinear(i,j,:) = (imGrande(i, j+1, :) + imGrande(i, j-1, :))/2;
    endfor
endfor

for i = heightImGrande -1 : -passo : 2
    for j = widthImGrande : -passo : 1
        imBilinear(i,j,:) = (imGrande(i+1, j, :) + imGrande(i-1, j, :))/2;
    endfor
endfor

for i = heightImGrande -1 : -passo : 3
    for j = widthImGrande-1 : -passo : 3
        imBilinear(i,j,:) = (imGrande(i+1, j+1, :) + imGrande(i-1, j-1, :) + imGrande(i+1, j-1, :) + imGrande(i-1, j+1, :))/4;
    endfor
endfor

imBilinear(:,1,:) = imBilinear(:, 2, :);
imBilinear(1,:,:) = imBilinear(2, :, :);

figure, imshow(imBilinear);

% Interpolacao bicubica
imBicubica = uint8(imGrande);


for i = heightImGrande-7  : -1 : 8
    for j = widthImGrande-7 : -1 : 8
    if (imBicubica(i,j,:) == 0)
        vizinho = double(imGrande(i-3:i+3, j-3:j+3, :));
        qtdValidos = sum(sum(vizinho != 0));
        imBicubica(i,j,:) = uint8((sum(sum(vizinho)))/qtdValidos(1));
    endif
    endfor
endfor


figure, imshow(imBicubica);

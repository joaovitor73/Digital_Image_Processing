im = imread('fractal.png');

imF(:,:)  = logical((im(:,:)/255)+(im(:,:)/127));

figure(1);
imshow(imF);

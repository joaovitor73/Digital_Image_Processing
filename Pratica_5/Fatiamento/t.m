im = imread('img1.jpg');
im = im(:,:,3);
imF(:,:)  = logical((im(:,:)/512));

figure(1);
imshow(imF);


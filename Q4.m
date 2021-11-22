name = ['R', 'G', 'B'];

% for i = 1:3
%     figure
%     I = imread([name(i) '.png']);
%     show(I);
% end
I = imread('test3.png'');
show(I);

function show(I)
It = rgb2gray(I);

J = dct2(It);



K = idct2(J);
K = mat2gray(K);

subplot(221),imshow(I);title('Original');
subplot(222), imshow(It); title('Grey');
subplot(223), imshow(log(abs(J)), []); title('DCT');
colormap(gca,jet(64))       
colorbar;

subplot(224), imshow(K); title('Transform back');
end


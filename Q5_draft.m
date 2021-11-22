clc;
saveplace = 'Q5/';

I = imread('money_easy.jpg');
imwrite(I, [saveplace 'Step1.png']);

Im = rgb2gray(I);
imwrite(Im, [saveplace 'Step2.png']);

% Im = filter2(fspecial('average', 5),Im)/255;
Im = imfilter(Im, fspecial('average', [12 12]));
figure, imshow(Im), title('f');

coin = imbinarize(Im);
imwrite(coin, [saveplace 'Step3_1.png']);
coin = 1-coin;
imwrite(coin, [saveplace 'Step3_2.png']);

cfil = imfill(coin, 'holes');
imwrite(cfil, [saveplace 'Step4.png']);

% % Filtering
% J = dct2(cfil);
% 
% figure
% imshow(log(abs(J)), [])
% colormap(gca,jet(64))       
% colorbar;
% 
% J(abs(J) < 1) = 0;
% 
% J2 = idct2(J);
% figure
% imshow(J2);

[L, N] = bwlabel(double(cfil));
prop = regionprops(L, 'Area', 'Centroid');

figure, imshow(I);

totalCent = 0;

for n = 1 : size(prop, 1)
    cent = prop(n).Centroid;
    X = cent(1);
    Y = cent(2);
    if prop(n).Area > 50
        text(X-10, Y, '5C')
        totalCent = totalCent + 5;
    else
        totalCent = totalCent + 10;
        text(X-10, Y, '10C');
    end
end

title(['The number of coins: ' num2str(N) ' Total of money: ' num2str(totalCent) ' Cents']);


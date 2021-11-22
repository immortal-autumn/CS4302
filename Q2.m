% R = imread('R.png');
% G = imread('G.png');
% B = imread('B.png');
% 
% IR = rgb2ycbcr(R);
% IG = rgb2ycbcr(G);
% IB = rgb2ycbcr(B);
% 
% subplot(331),imshow(IR);title('R-ycbcr');
% subplot(332),imshow(IG);title('G-ycbcr');
% subplot(333),imshow(IB);title('B-ycbcr');
% 
% imwrite(IR, 'YR.png');
% imwrite(IG, 'YG.png');
% imwrite(IB, 'YB.png');

I = imread('test1.png');
I2 = imread('test2.jpg');
I3 = imread('test3.png');

II = rgb2ycbcr(I);
II2 = rgb2ycbcr(I2);
II3 = rgb2ycbcr(I3);

subplot(221), imshow(II);
subplot(222), imshow(II2);
subplot(223), imshow(II3);

imwrite(II, 'test1_Y.png');
imwrite(II2, 'test2_Y.png');
imwrite(II3, 'test3_Y.png');


function convIm(fig, ind_o, ind_n) 
fR = fig(:,:,1);
fG = fig(:,:,2);
fB = fig(:,:,3);

figure(ind_o);
imshow(fig);

[ROW, COL, ~] = size(fig);

Y = zeros(ROW,COL);
Cb = zeros(ROW,COL);
Cr = zeros(ROW,COL);

for r = 1 :ROW
    for c = 1:ROW
        Y(r, c) = 0.299*fR(r, c) + 0.587*fG(r, c) + 0.114*fB(r, c);
        Cb(r, c) = -0.172*fR(r, c) - 0.339*fG(r, c) + 0.511*fB(r, c) + 128;
        Cr(r, c) = 0.511*fR(r, c) - 0.428*fG(r, c) - 0.083*fB(r, c) + 128;
    end
end

res = fig;
res(:,:,1) = Y;
res(:,:,2) = Cb;
res(:,:,3) = Cr;

figure(ind_n)
imshow(res);


end
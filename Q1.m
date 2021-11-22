c = zeros(200);
c(:,:) = 1;

z = zeros(200);

R = cat(3, c, z, z);
G = cat(3, z, c, z);
B = cat(3, z, z, c);

subplot(331),imshow(R);title("Red");
colorbar;

subplot(332),imshow(G);title("Green");
colorbar;

subplot(333),imshow(B);title("Blue");
colorbar;

imwrite(R, 'R.png');
imwrite(G, 'G.png');
imwrite(B, 'B.png');
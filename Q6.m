%% Global var
global ind;
ind = 1;

%% Read coins image
I = imread('money_very_hard.jpg');
gn(I);

%% Convert and indentify
I_grey = rgb2gray(I);
gn(I_grey);


%% Filtering
Ft = imadjust(I_grey, stretchlim(I_grey), [0 1]);
Ft = medfilt2(Ft, [5 5]);
gn(Ft);  

% figure, imhist(Ft);

%% To binary image
F = Ft;
[M,N] = size(F);
T = graythresh(F) * 256;

for x = 1:M
    for y = 1:N
        if F(x,y)<T
            F(x,y) = 0;
        else
            F(x,y) = 255;
        end
    end
end
% coin = imbinarize(I_grey);
% coin = 1-coin;
gn(F);

%% Vise colour
F = imadjust(F, [0,1], [1,0], 1);
gn(F);

%% Remove nosies
ele=strel('disk', 10);
F = imdilate(F, ele);
F = bwareaopen(F, 1500);
F = imerode(F,ele);

gn(F);

%% Fill
im1 = imfill(F, 'holes');
im2 = imerode(im1, ele);
im3 = bwareaopen(im2, 1500);
im4 = imdilate(im3, ele);
gn(im4);

%% Count
[L, N] = bwlabel(im4, 8);

%% Count value
s = regionprops(L, 'centroid');
centroids = cat(1, s.Centroid);
p=ceil(centroids);
x=p(:,2);
y=p(:,1);
len = zeros(2,length(x));

% Locate vertical and horizental length
for i = 1:length(x)
    j = 0;
    while (im4(x(i),y(i)+j) > 0)
        j = j+1;
    end
    len(2,i) = j;
    j = 0;
    while (im4(x(i)+j,y(i)) > 0)
        j = j+1;
    end
    len(1,i) = j;
end

%% Filter coins space
% maxlen = max(max(len));
% for i = 1:length(len)
%     if len(1,i) < maxlen*0.5 || len(2,i) < maxlen*0.5
%         len(1,i) = 0;
%         len(2,i) = 0;
%     end
% end

%% Locate the smallest coin
% minlen = min(min(len(len>0)));
len_size = length(len(1, :));

minlen = 134;
count = 0;

for i = 1:len_size
    count = count + floor(len(1,i)/minlen) + floor(len(2, i) / minlen) - 1;
%     count = count + floor((len(1, i) * len(2, i)) / (minlen * minlen));
end

%% Locate size of coins
figure
imshow(I);

for i = 1:len_size
    text(centroids(i, 1), centroids(i, 2), [num2str(len(1, i)) ',' num2str(len(2, i))]);
end


%% Print result
pre_red = [146, 5; 166, 20; 169, 1; 192, 10; 193, 100; 212, 26; 229, 200];
min_space = 146;

pred = [0, 5; 0, 20; 0, 1; 0, 10; 0, 100; 0, 26; 0, 200];

for i = 1:len_size
    rest_v = len(2, i);
    rest = len(1, i);
    indq = 0;
    while (rest > min_space) 
        tmp = rest - pre_red(:, 1);
        minV = min(tmp(tmp > 0));

        minI = find(tmp == minV);

        pred(minI, 1) = pred(minI, 1) + 1;
        rest = rest - pre_red(minI, 1);
        if indq == 0
            rest_v = rest_v - pre_red(minI, 1);
            indq = 1;
        end
    end
    
    rest = rest_v;
    while (rest > min_space) 
        tmp = rest - pre_red(:, 1);
        minV = min(tmp(tmp > 0));

        minI = find(tmp == minV);

        pred(minI, 1) = pred(minI, 1) + 1;
        rest = rest - pre_red(minI, 1);
    end
end

totalVal = 0;
for i = 1:length(pred(:, 1))
    totalVal = totalVal + pred(i, 1) * pred(i, 2);
end

pred
totalVal

title(['Value for coins on the table is: ' num2str(floor(totalVal / 100)) ' Pounds, ' num2str(mod(totalVal, 100)) ' pence']);
%% Utilities
function gn(Im)
global ind
s = ['Q5/Step' num2str(ind) '.png'];
imwrite(Im, s);
ind = ind + 1;
end
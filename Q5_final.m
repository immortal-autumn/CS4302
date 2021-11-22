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
minlen = 134;
count = 0;
for i = 1:length(len(1, :))
    count = count + floor(len(1,i)/minlen) + floor(len(2, i) / minlen) - 1;
%     count = count + floor((len(1, i) * len(2, i)) / (minlen * minlen));
end
%% Print result
count
N

%% Utilities
function gn(Im)
global ind
s = ['Q5/Step' num2str(ind) '.png'];
imwrite(Im, s);
ind = ind + 1;
end
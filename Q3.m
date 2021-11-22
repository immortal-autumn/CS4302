    I = imread('test3_Y.png');
    
    d_sam = 8;
    
    Y = I(:,:,1);
    Cb = I(:,:,2);
    Cr = I(:,:,3);
    
    new_Cb = zeros(size(Cb));
    new_Cr = zeros(size(Cr));
    
    [line, row] = size(Cr);
    line_s = floor(line / d_sam);
    row_s = floor(row / d_sam);
    
    for x = 1:line_s
        for y = 1:row_s
            new_Cb(x * 8, y * 8) = Cb(x * 8, y * 8);
            new_Cr(x * 8, y * 8) = Cr(x * 8, y * 8);
        end
    end
    
    
    Im = cat(3, Y, new_Cb, new_Cr);
    
    Cb_sub = double(Cb) - double(new_Cb);
    Cr_sub = double(Cr) - double(new_Cr);
    
    Is = cat(3, Y, Cb_sub, Cr_sub);
    
    subplot(331),imshow(I);title('Original');
    subplot(332),imshow(Im);title('Result');
    subplot(333),imshow(Is);title('Substract');
    subplot(334),imshow(ycbcr2rgb(I));title('RGB original');
    subplot(335),imshow(ycbcr2rgb(Im));title('RGB result');
    subplot(336),imshow(ycbcr2rgb(Is));title('RGB Substract');
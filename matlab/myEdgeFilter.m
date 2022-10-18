function [gradMag_img1] = myEdgeFilter(img0, sigma)

%Implemention
hsize = 2 * ceil(3 * sigma) + 1;
h = fspecial ('gaussian', hsize, sigma) ;
img1 = myImageFilter(img0, h); % smoothen

hy_sobel = fspecial ('sobel');
hx_sobel = hy_sobel' ;

imgx = myImageFilter(img1, hx_sobel);
imgy = myImageFilter(img1, hy_sobel);

% Magnitude of the gradient
gradMag_img1 = sqrt((imgx.*imgx)+(imgy.*imgy)); 
[row,col] = size(gradMag_img1);
%figure(6); imshow(gradMag_img1); 

%NMS for thinning the edges
gradAngle = atan(imgy./imgx)*180;
%gradAngle = atan2(imgx, imgy)*180/pi;

[img01] = padarray(gradMag_img1, [1, 1]);
for i=2 : row+1
    for j=2 : col+1
        if (abs(gradAngle(i-1,j-1)) >= 157.5) || (abs(gradAngle(i-1,j-1)) < 22.5)
            if (img01(i-1, j) > img01(i,j)) || (img01(i+1, j) > img01(i,j))
                gradMag_img1(i-1, j-1) = 0;
            end

        elseif (abs(gradAngle(i-1,j-1)) >= 22.5) && (abs(gradAngle(i-1,j-1)) < 67.5)
            if (img01(i-1, j+1) > img01(i,j)) || (img01(i+1, j-1) > img01(i,j))
                gradMag_img1(i-1, j-1) = 0;
            end
        elseif (abs(gradAngle(i-1,j-1)) >= 67.5) && (abs(gradAngle(i-1,j-1)) < 112.5)
            if (img01(i, j+1) > img01(i,j)) || (img01(i, j-1) > img01(i,j)) 
                gradMag_img1(i-1, j-1) = 0;
            end
        elseif (abs(gradAngle(i-1,j-1)) >= 112.5) && (abs(gradAngle(i-1,j-1)) < 157.5)
            if (img01(i+1, j+1) > img01(i,j)) || (img01(i-1, j-1) > img01(i,j))
                gradMag_img1(i-1, j-1) = 0;
            end
   
        end
    end
end
     
%figure(7); imshow(gradMag_img1); % img1 with thin edges
                
        
        

function [img1] = myImageFilter(img, h)

%[img1] = padarray(img, [m, n],"replicate");
[img1] = padarray(img, 1, 1, "both");
%figure(3); imshow(img1); % Padded img

[row,col] = size(img1);
[m,n] = size(h); 
repln_img = zeros(row + m*2, col + n*2);
for x = m : m+row-1
    for y = n : n+col-1
        repln_img(x,y) = img1(x-m+1, y-n+1);
    end
end
%figure(4); imshow(repl); % Replicated img

img1 = zeros(row+m-1,col+n-1);
for x = 1 : row+m-1
    for y = 1 : col+n-1
        for i = 1 : m
            for j = 1 : n
                img1(x, y) = img1(x, y) + (repln_img(x+i, y+j) * h(i,j));
            end
        end
    end
end

%figure(5); imshow(img1); % Convolved img

end
 

function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)

%Implementation 

[row, col] = size(Im);

rhoRes = 2;
thetaRes = pi/180;
threshold = 0.1;

rhoMax = 1 * sqrt((row*row)+(col*col));
thetaMax = 2 * pi;

Hrres = ceil(rhoMax / rhoRes);
Htres = ceil(thetaMax / thetaRes);
H = zeros([Hrres, Htres]);
rhoScale = zeros(1, Hrres);
thetaScale = zeros(1, Htres);

for i = 1 : row
    for j = 1 : col
        if  Im (i,j) > threshold
            for theta = 0: 0.01: thetaMax
                rho=(col*cos(theta))+(row*sin(theta));
                if 0<rho && rho <rhoMax
                    if (ceil(rho/rhoRes) <= Hrres && ceil((theta+1) / thetaRes) <= Htres)
                        H(ceil(rho/rhoRes), ceil((theta+1) / thetaRes)) = H(ceil(rho/rhoRes), ceil((theta+1) / thetaRes)+1);
                        rhoScale(1, ceil(rho/rhoRes)) = rho;
                        thetaScale(1, ceil((theta+1)/thetaRes)) = theta;
                    end
                end
            end
        end
    end
end

%figure(8); imshow(H); 

end


 
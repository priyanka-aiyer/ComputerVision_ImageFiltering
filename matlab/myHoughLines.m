function [rhos, thetas] = myHoughLines(H, nLines)

%Implemention 

Hd = padarray(H, [1,1]);
rhos = zeros(nLines,1);
thetas = zeros(nLines, 1);
[x,y] = size(Hd);


for i=1 : nLines
    [m, id] = max(Hd, [], 'all', 'linear');
    %[lm, lid] = max([Hd(id), Hd(id-1), Hd(id+1), Hd(id+y), Hd(id-y)], [], 'all', 'linear');
    [lm, lid] = max([Hd(id), Hd(id+1), Hd(id+y)], [], 'all', 'linear');
    if lm ~= m
        Hd(id) = 0;
        [m,id] = max(Hd, [], 'all', 'linear');
    end
    [rhos(i, 1), thetas(i, 1)] = ind2sub(size(Hd), id);
    Hd(id) = 0;

end

end

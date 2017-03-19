function index = gray2index( gray, n )
%GRAY2INDEX 灰度图像转化为索引图像
%   将灰度图像gray转换成色阶为n的索引图像
    [x,y] = size(gray);
    index = zeros(x,y);
    for i = 1:x
        for j = 1:y
            index(i,j) = (gray(i,j) + 1)/floor(256/n) - 1;
        end
    end
end


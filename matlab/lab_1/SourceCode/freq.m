function result = freq( img )
%FREQ 灰度频域转换
%   输入一幅图像，返回该图像从最小灰度到最大灰度，各个灰度级出现的次数
    gray_min = min(img(:));
    gray_max = max(img(:));
    n = double(gray_max - gray_min) + 1;
    result = zeros(1,n - 1);
    for i = 0 :n - 1
        result(1,i + 1) = numel(find(img == (i + gray_min)));
    end
end


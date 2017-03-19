function result = hist_equal( img )
%HIST_EQUAL 直方图均衡化
%   求img均衡化后的直方图
    [x,y] = size(img);
    per = zeros(256);
    cum = zeros(256);
    result = zeros(x,y);
    % 统计各灰度出现次数
    for i = 0 : 255
        per(i + 1) = numel(find(img == (i)));
    end
    % 计算所占比例
    per = per/(x * y * 1.0);
    % 计算累积分布函数
    for i = 2: 256
        cum(i) = cum(i-1) + per(i);
    end
    % 计算结果的灰度值
    for i = 1: x
        for j = 1:y
            result(i,j) = round(256.0 * cum(double(img(i,j)) + 1));
        end
    end
    result = uint8(result);
end
function result = gray_extension(A,min,max,k,b)
%GRAY_EXTENSION 灰度拉伸
% 将矩阵A内灰度处于(min,max)的像素值按y = kx + b进行线性拉伸
    % p,q为矩阵A的长、宽
    [p,q]=size(A);
    % result
    result = zeros(p,q);
    for i = 1:p
        for j = 1:q
            % 若灰度处于(min.max)则拉伸，否则保留原灰度值
            if A(i,j) < max && A(i,j) > min
                result(i,j) = (A(i,j) * k) + b;
            else
                result(i,j) = A(i,j);
            end
        end
    end
end


function result = myfft2( img )
%MYFFT2 二维快速傅里叶变换
%   在M=N=2^n时，根据公式快速计算二维傅里叶变换的结果
    [x,y] = size(img);
    result = zeros(x,y);
    % 二维傅里叶变换相当于在x和y上分别进行一次一维傅里叶变换
    for i=1:x;
        result(i,:) = myfft(img(i,:));
    end
    for j=1:y;
        result(:,j) = myfft(result(:,j));
    end
end

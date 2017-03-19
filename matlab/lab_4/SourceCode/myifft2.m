function result = myifft2( list )
%MYIFFT2 二维快速傅里叶逆变换
%   在M=N=2^n时，根据公式快速计算计算二维傅里叶逆变换的结果
    [x,y] = size(list);
    result = zeros(x,y);
     % 二维傅里叶逆变换相当于在x和y上分别进行一次一维傅里叶逆变换
    for i=1:x;
        result(i,:) = myifft(list(i,:));
    end
    for j=1:y;
        result(:,j) = myifft(result(:,j));
    end
    result = real(result);
end

function result = myifft( list )
%MYIFFT 快速傅里叶逆变换
%   在N=2^n时，根据公式快速计算计算傅里叶逆变换的结果
    N = length(list);
    % 取原序列的共轭序列
    list_conj = conj(list);
    % 对共轭序列进行快速傅里叶变换
    result_conj = myfft(list_conj);
    % 结果取共轭，除以N
    result = conj(result_conj)/N;
end
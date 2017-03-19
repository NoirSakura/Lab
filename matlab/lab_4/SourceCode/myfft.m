function result = myfft( list )
%MYFFT 快速傅里叶变换
%   在N=2^n时，根据公式快速计算快速傅里叶变换的结果
    N = length(list);
    % 递归到1开始返回结果
    if N == 1
        result = list;
        return;
    end
    % myfft函数 用递归实现
    M = N/2;
    Wn = exp(-1i*2*pi/N).^(0:M-1);
    n = 1:M;
    % 递归调用
    res_even(n) = myfft(list(2*n-1));
    res_odd(n) = myfft(list(2*n)); 
    % 结果分为前后两部分
    result = [res_even+res_odd.*Wn res_even-res_odd.*Wn];
end

function temp = LoG( k,sigma )
%LOG 计算k阶，标准差为sigma的LoG算子
% ▽h? = （-（x?+y?-2sigma?）/sigma^4）exp(-((x?+y?)/2sigma?))
    m = k;
    n = k;
    % 模板大小为k*k
    temp=zeros(m,n);
    % sigma?
    sigma2=sigma^2;
    % 中心点坐标
    center_m= ceil(m/2);
    center_n= ceil(n/2);
    for i=1:m
        for j=1:n
            y=i - center_m;
            x=j - center_n;
            % r? = x?+y?
            r2 = x^2 + y^2; 
            temp(i,j)=(-(r2-2*sigma2/(sigma2^2)))*exp(-(r2/(2*sigma2)));
        end
    end
    % 归一化，使得模板和为0
    temp = temp - sum(temp(:))/(m*n);
end


function result = butterworth( img,type )
%BUTTERWORTH butterworth滤波器实现
%   对img进行butterworth高通/低通滤波，返回处理后的图像。
    % 快速傅里叶变换
    g = fft2(double(img));
    % 转换数据矩阵fftshift是针对频域的，将FFT的DC分量移到频谱中心即对频域的图像，
    g = fftshift(g);
    [M,N]=size(g);
    result = zeros(M,N);
    prompt = {'Please enter D0:','Please enter n:'};
    if strcmp(type,'lowp')
        param = inputdlg(prompt,'Butterworth',1,{'10','1'},'on');
    else param = inputdlg(prompt,'Butterworth',1,{'4.5','2'},'on');
    end
    D0 = str2double(param{1,1});
    n = str2double(param{2,1});
    % 将坐标原点从左上角移动到中心
    x0 = fix(M/2);
    y0 = fix(N/2);
    for x = 1:M
        for y = 1:N
            d = sqrt((x-x0)^2+(y-y0)^2);
            if strcmp(type,'lowp')
                % 低通公式h(x,y) = 1/(1+(sqrt(x^2+y^2)/D0)^2n)
                h = 1/(1+(d/D0)^(2*n));
            elseif strcmp(type,'highp')
                % 高通公式h(x,y) = 1/(1+(D0/sqrt(x^2+y^2))^2n)
                if d == 0
                    h = 0;
                else
                    h = 1/(1+(D0/d)^(2*n));
                end
            else h = 1;
            end
            result(x,y) = h * g(x,y);
        end
    end
    % 将处理后频域的DC分量移到原始位置
    result = ifftshift(result);
    % 快速傅里叶逆变换
    result = ifft2(result);
    result = uint8(real(result));
end


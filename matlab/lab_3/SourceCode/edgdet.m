function result = edgdet( img,type )
%EDGDET 四种边缘检测算子的实现
%   此处显示详细说明
    [x,y] = size(img);
    result = zeros(x,y);
    % marr算子是二阶微分算子，因此单独处理
    if(strcmp(type,'marr'))
        % 构造9x9，标准差为0.4的高斯模板
        temp = LoG(7, 1);
        G = myfilter(double(img),temp);
        result = G;
        [m,n]=size(img);
        % 计算过零点，如果阈值同时大于40的话，认定其为边缘
        for i=2:m-1
            for j=2:n-1
                m1 = result(i-1:i,j-1:j);
                m2 = result(i-1:i,j:j+1);
                m3 = result(i:i+1,j-1:j);
                m4 = result(i:i+1,j:j+1);
                tmp = [sum(m1(:)) sum(m2(:)) sum(m3(:)) sum(m4(:))];
                if max(tmp)>0 && min(tmp)<0 && abs(result(i,j)) > 40
                    result(i,j)=255;
                else
                    result(i,j)=0;
                end
            end
        end
    else
        % 三种一阶梯度算子
        switch type
            % sobel算子实现
            case 'sobel'
                % tempx为x方向梯度模板，tempy为y方向剃度模板
                tempx = [-1 -sqrt(2) -1; 0 0 0; 1 sqrt(2) 1];
                tempy = tempx';
                Gx = myfilter(double(img),tempx);
                Gy = myfilter(double(img),tempy);
                % 模板的加权处理
                G = sqrt(Gx.^2 + Gy.^2);
                % 用最大类间方差法求阈值
                thresh = 0.5*(max(G(:)) - max(img(:)));
            % prewitt算子实现
            case 'prewitt'
                % tempx为x方向梯度模板，tempy为y方向剃度模板
                tempx = [-1 -1 -1; 0 0 0; 1 1 1];
                tempy = tempx';
                Gx = myfilter(double(img),tempx);
                Gy = myfilter(double(img),tempy);
                % 模板的加权处理
                G = abs(Gx) + abs(Gy);
                % 用最大类间方差法求阈值
                thresh = 0.5*(max(G(:)) - max(img(:)));
            % roberts算子实现
            case 'roberts'
                % tempx为x方向梯度模板，tempy为y方向剃度模板
                tempx = [1 0; 0 -1];
                tempy = [0 1; -1 0];
                Gx = myfilter(double(img),tempx);
                Gy = myfilter(double(img),tempy);
                % 模板的加权处理
                G = abs(Gx) + abs(Gy);
                % 用最大类间方差法求阈值
                thresh = 0.5*(max(G(:)) - max(img(:)));
        end
         % 根据阈值，灰度二值化
        for i = 1:x
            for j = 1:y
                if G(i,j) >= thresh
                    result(i,j) = 255;
                else result(i,j) = 0;
                end
            end
        end    
    end
end

function result = myfilter( img, temp )
%MYFILTER 滤波处理
%   对img进行temp模板的滤波处理
    % 模板旋转180度，将点积运算转换为卷积运算
    temp = rot90(temp,2);
    % 卷积求出结果
    result = conv2(img,temp,'same');
end

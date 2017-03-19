% lab1实现
% 关闭所有窗口，清理工作区，清理命令行窗口
clear all;
close all;
clc;
% 读取图像
[file_name,path_name] = uigetfile('*.bmp;*.jpg','选择图片');
A = imread([path_name,file_name]); 
% 视图展示，分为六个部分
figure('name','lab_1');
    subplot(3,2,1);
        % 如果图像是彩色的，则转化为灰度图像
        if size(A,3)>1
        	A = rgb2gray(A);
        end
        % 展示图像
        imshow(A);
        title('原图像');
    subplot(3,2,2);
        % 绘制直方图，灰度级由图像输入决定
        bar(double(min(A(:)):1:max(A(:))),freq(A),'grouped');
        title('直方图');
    subplot(3,2,3);
        % hist_eqal将图像均衡化，imshow输出
        he = hist_equal(A);
        imshow(he);
        title('均衡化后的图像');
    subplot(3,2,4);
        % 绘制直方图，灰度级由图像输入决定
        bar(double(min(he(:)):1:max(he(:))),freq(he),'grouped');
        title('均衡化后直方图');
    subplot(3,2,5);
        % input_linear返回cell{min,max,k,b}
        param = input_linear();
        % 灰度拉伸实现：将处于(min,max)的像素值按y = kx + b线性拉伸
        result = gray_extension(A,str2double(param{1,1}),str2double(param{2,1}),str2double(param{3,1}),str2double(param{4,1}));
        bar(min(result(:)):1:max(result(:)),freq(result),'grouped');
        imshow(uint8(result));
        title('灰度拉伸后图像');
    subplot(3,2,6);
        % 绘制直方图，灰度级由图像输入决定
        bar(min(result(:)):1:max(result(:)),freq(result),'grouped');
        title('灰度拉伸后直方图');
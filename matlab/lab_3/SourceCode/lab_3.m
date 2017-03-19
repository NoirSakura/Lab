% lab3实现
% 关闭所有窗口，清理工作区，清理命令行窗口
clear all;
close all;
clc;
% 读取图像
[file_name,path_name] = uigetfile('*.bmp;*.jpg','选择图片');
A = imread([path_name,file_name]);
% 视图展示，分为五个部分
figure('name','lab_3');
    subplot(3,2,1);
        % 如果图像是彩色的，则转化为灰度图像
        if size(A,3)>1
        	A = rgb2gray(A);
        end
        % 展示图像
        imshow(A);
        title('原图像');
    subplot(3,2,3);
        % sobel算子
        imshow(edgdet(A,'sobel'));
        title('Sobel算子边缘提取');
    subplot(3,2,4);
        % prewitt算子
        imshow(edgdet(A,'prewitt'));
        title('Prewitt算子边缘提取');
    subplot(3,2,5);
        % roberts算子
        imshow(edgdet(A,'roberts'));
        title('Roberts算子边缘提取');
    subplot(3,2,6);
        % marr算子
        imshow(edgdet(A,'marr'));
        title('Marr');
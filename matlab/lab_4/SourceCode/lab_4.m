% lab4实现
% 关闭所有窗口，清理工作区，清理命令行窗口
clear all;
close all;
clc;
% 读取图像
[file_name,path_name] = uigetfile('*.bmp;*.jpg','选择图片');
img = imread([path_name,file_name]);
% 视图展示，分为五个部分
figure('name','lab_3');
    subplot(3,2,1);
        % 如果图像是彩色的，则转化为灰度图像
        if size(img,3)>1
        	img = rgb2gray(img);
        end
        % 展示图像
        imshow(img);
        title('原图像');
    subplot(3,2,3);
        my = myfft2(double(img));
        A = abs(fftshift(my));
        A=(A - min(A(:)))/(max(A(:))-min(A(:))) * 225;
        imshow(A);
        title('自编fft2结果');
    subplot(3,2,4);
        default = fft2(img);
        A = abs(fftshift(default));
        A=(A - min(A(:)))/(max(A(:))-min(A(:))) * 225;
        imshow(A);
        title('自带fft2结果');
    subplot(3,2,5);
        myresult = myifft2(my);
        imshow(uint8(myresult));
        title('自编ifft2结果');
    subplot(3,2,6);
        result = ifft2(default);
        imshow(uint8(result));
        k = result-myresult;
        title('自带ifft2结果');
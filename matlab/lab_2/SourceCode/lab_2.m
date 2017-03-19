% lab2实现
% 关闭所有窗口，清理工作区，清理命令行窗口
clear all;
close all;
clc;
figure('name','lab_2');
% 低通去噪
    subplot(3,2,1);
    noise = imread('..\lena_noise.bmp');
    imshow(noise);
    title('噪声图像');
    subplot(3,2,2);
    imshow (butterworth(noise,'lowp'));
    title('Butterworth低通滤波所得图像');
% 高通去模糊
    subplot(3,2,3);
    blur = imread('..\lena_blur.bmp');
    imshow(blur);
    title('模糊图像');
    subplot(3,2,4);
    imshow (butterworth(blur,'highp'));
    title('Butterworth高通滤波所得图像');
% 伪彩色
    subplot(3,2,5);
    gray = imread('..\lena.jpg');
    imshow(gray);
    title('原图像');
    subplot(3,2,6);
% gray2index将灰度图像转化为索引图像，jet为MATLAB预设的一套蓝色到红色的颜色对应方案，label2rgb将索引图像转化为rgb图像
    prompt = {'Please enter n:'};
    param = inputdlg(prompt,'color',1,{'256'},'on');
    n = str2double(param{1,1});
    index = gray2index(gray, n);
    rgb = label2rgb(index,jet(n));
    imshow(rgb);
    title('伪彩色图');
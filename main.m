clear;
close all;

img_in  = im2double(imread('img1.jpg'));
scales = [2 120 240];
alpha = 500;
d = 1.5;
img_out = MSRCR(img_in,scales,[],alpha,d);

figure;
imshow([img_in img_out]);

str_scales = ['scale=[',num2str(scales(1)),',',num2str(scales(2)),',',num2str(scales(3)),']'];
str_alpha  = ['alpha=',num2str(alpha)];
str_d  = ['contrast=',num2str(d)];
title([str_scales,',',str_alpha,',',str_d]);
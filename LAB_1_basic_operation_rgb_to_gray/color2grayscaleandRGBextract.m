% created by Mohit Talwar
% DIP LAB : Experiment 1 
% Color Image --> Gray Scale , Extracting Red Blue and Green Channels

clc
clear all
close all

imdata = imread('cat.jpg');
imshow(imdata);        % color

display(imdata(1,3));

imshow(imdata(:,:,1)); % grayscale

imshow(imdata(:,:,1));

[r,g,b] = imsplit(imdata);
%Create color versions of the individual color channels

%Create an all black channel
allBlack = zeros(size(imdata, 1), size(imdata, 2), class(imdata));

justRed = cat(3, r, allBlack, allBlack);
justGreen = cat(3, allBlack, g, allBlack);
justBlue = cat(3, allBlack, allBlack, b);

%Display all the channels and original image
montage({justRed, justGreen, justBlue, imdata}, 'ThumbnailSize',[]);
%% clear
clc; clear all; close all;

%% path
addpath('./lib');

%% generate image
im = zeros(300,300,300);
im(150,150,150) = 1;
imth = bwdist(im)<90;

%% starting point
idx = sub2ind(size(im),150,150,150);

%% 3d anisotropic geodesic distance
sc = fliplr(fullfact(ones(1,3)*2));
sc(end,:) = [];
for i=1:size(sc,1)
    
    % distance
    imgd = bwdistgeodesicsc3d(imth,idx,sc(i,:));
    
    % plot
    figure; 
    subplot(1,3,1); imagesc(squeeze(max(imgd,[],1))); colormap jet; 
        axis off; axis image; axis tight;
    subplot(1,3,2); imagesc(squeeze(max(imgd,[],2))); colormap jet; 
        axis off; axis image; axis tight;
    subplot(1,3,3); imagesc(squeeze(max(imgd,[],3))); colormap jet; 
        axis off; axis image; axis tight;
end
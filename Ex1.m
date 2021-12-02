clc; clear; close all;

Image = double(imread('eight.tif'));
noisy_image = add_gaussian_noise(Image,30);

%mask_nois = roipoly(noisy_image/255.); % defines manually the region
%save("mask_nois.mat")

%load mask_2;
load mask1;


phi   = signed_distance_from_mask(mask1);
%phi   = signed_distance_from_mask(mask_nois);
%surf(phi)

% Main
eps    = 1;
eta    = 1;
lambda = 10^(-4);
restart = 10;
N      = 100;

loss1      = chanvese(phi, Image, lambda, eps, eta, N, restart);

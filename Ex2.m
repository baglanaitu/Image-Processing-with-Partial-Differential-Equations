clc; clear; close all;

load mask1;
%load mask_2;
phi    = signed_distance_from_mask(mask1);
Image  = double(imread('eight.tif'));
c1     = 110;
c2     = 227;

% Parameters
eta    = 1;
mu     = 0.5;
N      = 1000;
eps    = 1;
lambda = 10^(-4);
restart = 10;

% Main
chan_esed_nikol(phi, Image, c1, c2, lambda, eps, eta, N, restart);


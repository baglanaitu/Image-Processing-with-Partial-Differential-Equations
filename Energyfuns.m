clc; clear; close all;

Image = double(imread('eight.tif'));
load mask1;
phi   = signed_distance_from_mask(mask1);

% Main
c1     = 110;
c2     = 227;

eps    = 1;
eta    = 1;
lambda = 10^(-4);
restart = 10;
N      = 100;

%getting the energy 
loss1      = chanvese(phi, Image, lambda, eps, eta, N, restart);
loss2      = chan_esed_nikol(phi, Image, c1, c2, lambda, eps, eta, N, restart);
loss3      = dual(phi, Image, c1, c2, lambda, eps, eta, N, restart);

%% plot loss
figure;
line = linspace(1,length(loss2),length(loss2));
L(1) = plot(line, loss3(1:length(loss1)), 'g-');
xlabel('Iteration');
ylabel('Energy');
hold on 
L(2) = plot(line,loss2(1:length(loss2)), 'b-');
L(3) = plot(line,loss1(1:length(loss3)),'r-');

legend(L,{'Dual Tv','Chan, Esedoglu and Nikolova', 'Chan-Vese'});
hold off

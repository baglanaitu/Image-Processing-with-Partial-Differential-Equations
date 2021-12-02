clc; clear; close all;

load mask1;
phi    = signed_distance_from_mask(mask1);
Image  = double(imread('eight.tif'));

% Parameters
sigma  = 1/2;
t      = 1/4;
lambda = 10^(-4);
eta    = 1
N      = 50;
c1     = 110;
c2     = 227;
z1     = zeros(size(gradx(phi)));
z2     = zeros(size(grady(phi)));
loss= [];
% Main
u      = {};
u_b    = u;
u{1}   = phi;
u_b{1} = phi;

for k = 1:N
    [z1, z2] = P_B( z1 + sigma.*gradx(u_b{k}), z2 + sigma.*grady(u_b{k}));
    u{k+1}   = P_A( u{k} + t*div(z1, z2) - lambda*(Image - c1).^2 + lambda*(Image - c2).^2);
    u_b{k+1} = u{k+1} + eta.*(u{k+1} - u{k});
 
    I_c1 = (Image - c1).^2;
    I_c2 = (Image - c2).^2;
    
    out      = u{k+1}>0;
    loss = [loss, compute_energy_smooth(out,I_c1,I_c2, lambda, eps)]; 

end

figure(1)
imagesc(Image);
colormap gray
hold on
contour(out, 'r', 'Linewidth', 3)
title("Final Result")

figure(3)
p=linspace(1, N, N);
plot(p,loss);
xlabel('iteration')
ylabel('loss')
title('Energy');
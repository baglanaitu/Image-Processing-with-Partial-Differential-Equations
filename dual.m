function output = dual(phi, Image, c1, c2, lambda, eps, eta, N, restart)

sigma  = 1/2;
t      = 1/4;
z1     = zeros(size(gradx(phi)));
z2     = zeros(size(grady(phi)));
% Main
u    = {};
u{1} = phi;
loss = [];
eps = 1;
for k = 1:N
    [z1, z2] = P_B( z1 + sigma.*gradx(u{k}), z2 + sigma.*grady(u{k}));
    u{k+1}   = P_A( u{k} + t*div(z1, z2) - lambda*(Image - c1).^2 + lambda*(Image - c2).^2);
    
    I_c1 = (Image - c1).^2;
    I_c2 = (Image - c2).^2;
    
    if(k==N/2)
        mid = u{k+1};
    end
    out      = u{k+1}>0;
    loss = [loss, compute_energy_smooth(out,I_c1,I_c2, lambda, eps)]; 
    output = loss;
end

u = out > 0;
% Plot
figure(1)
imagesc(Image);
colormap gray
hold on
contour(u, 'r', 'Linewidth', 3)
title("Final Iteration")

figure(2)
u = mid>0;  
imagesc(Image);
colormap gray
hold on
contour(u, 'r', 'Linewidth', 3)
title("Mid Result")

figure(1)
p=linspace(1, N, N);
plot(p,loss);
xlabel('iteration')
ylabel('loss')
title('Energy');
end


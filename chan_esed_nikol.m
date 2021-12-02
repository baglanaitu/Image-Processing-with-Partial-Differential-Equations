function output = chan_esed_nikol(phi, Image, c1, c2, lambda, eps, eta, N, restart)
Phi    = {};
Phi{1} = phi;
loss = [];

for k = 1:N
    
    inp_grad_x = gradx(Phi{k}) ./ (gradx(Phi{k}).^2 + grady(Phi{k}).^2+eps);
    inp_grad_y = grady(Phi{k}) ./ (gradx(Phi{k}).^2 + grady(Phi{k}).^2+eps);
    
    J_phi      = delta_eta(Phi{k}, eta).* div(inp_grad_x, inp_grad_y) - lambda*(Image - c1).^2 + lambda*(Image - c2).^2;
    t          = 1/2 * max(max(J_phi));
    
    if (mod(k,restart)==0)
        Phi{k+1} = signed_distance_from_mask( Phi{k} > 0);
    else
        Phi{k+1} = Phi{k} + t*J_phi;
    end
    if (k==N/2)
        mid = Phi{k+1};
    end
        
    out          = Phi{k+1}; 
    u = out > 0;
    %out        = compute_energy_smooth(u, Image, c1, c2, lambda, eps);
    I_c1 = (Image - c1).^2;
    I_c2 = (Image - c2).^2;
    
    loss = [loss, compute_energy_smooth(u,I_c1,I_c2, lambda, eps)]; 
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

figure(3)
p=linspace(1, N, N);
plot(p,loss);
xlabel('iteration')
ylabel('loss')
title('Energy');
end


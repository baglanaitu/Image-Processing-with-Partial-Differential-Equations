function output = chanvese(phi, Image, lambda, eps, eta, N,restart)
Phi    = {};
Phi{1} = phi;
loss = []

for k = 1:N
       
    inp_grad_x = gradx(Phi{k}) ./ sqrt((gradx(Phi{k}).^2 + grady(Phi{k}).^2+eps^2));
    inp_grad_y = grady(Phi{k}) ./ sqrt((gradx(Phi{k}).^2 + grady(Phi{k}).^2+eps^2));
    
    
    c1         = sum(sum(Image.* Heavyside_eta(Phi{k},eta)))    / sum(sum(Heavyside_eta(Phi{k},eta)));
    c2         = sum(sum(Image.*(1-Heavyside_eta(Phi{k},eta)))) / sum(sum(1 - Heavyside_eta(Phi{k},eta)));
    
    J_phi      = delta_eta(Phi{k}, eta).* div(inp_grad_x, inp_grad_y) - lambda*(Image - c1).^2 + lambda*(Image - c2).^2;
    t          = 1/2 * max(max(J_phi));
    %
    if (mod(k,restart)==0)
        Phi{k+1} = signed_distance_from_mask( Phi{k} > 0);
    else
        Phi{k+1} = Phi{k} + t*J_phi;
    end
    if k==N/2
        phi_middle        = Phi{k+1};
    end 
    
    I_c1 = (Image - c1).^2;
    I_c2 = (Image - c2).^2;
    
    
    out        = Phi{k+1};
    u = out > 0;
    loss = [loss, compute_energy_smooth(u,I_c1,I_c2, lambda, eps)]; 
    output = loss;
end
 % Plot
figure(1)
u = out>0;
imagesc(Image);
colormap gray
hold on
contour(u, 'r', 'Linewidth', 3)
title("Final Iteration")

figure(2)
u = phi_middle>0;
imagesc(Image);
colormap gray
hold on
contour(u, 'r', 'Linewidth', 3)
title("Middle iteration")

figure(3)
p = linspace(1, k, k);
plot(p,loss);
xlabel('iteration')
ylabel('loss')
title('Energy');
end


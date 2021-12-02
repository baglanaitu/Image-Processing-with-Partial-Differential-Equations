function out = compute_energy_smooth(u, I_c1, I_c2, lambda, e)

%u_norm = sqrt( gradx(u).^2 + grady(u).^2 + eps);
%out    = sum(sum(u_norm)) + lambda.*sum( sum((Image-c1).^2).*u ) + lambda.*sum( sum((Image-c2).^2).*(1-u) );

gradx_u = gradx(u);
grady_u = grady(u);
norm_u = sqrt(gradx_u.^2 + grady_u.^2 + e^2 );
out = sum(sum(norm_u)) + lambda.* sum(sum((I_c1).*u)) + sum(sum(lambda.*((I_c2)).*(1-u))); 

end


function out = compute_energy(u, Image, c1, c2, lambda)
u_norm = sqrt( gradx(u).^2 + grady(u).^2 + eps);
out    = sum(sum(u_norm)) + lambda.*sum( sum((Image-c1).^2).*u ) + lambda.*sum( sum((Image-c2).^2).*(1-u) );
end


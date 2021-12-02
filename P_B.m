function [out1, out2] = P_B(z1, z2)
z_norm  = sqrt(sum(sum(z1.^2 + z2.^2)));

if z_norm <= 1
    [out1 out2] = [z1 z2];
else
    out1        = z1./z_norm;
    out2        = z2./z_norm;
end

end


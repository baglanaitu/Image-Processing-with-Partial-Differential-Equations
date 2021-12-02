function out = Heavyside_eta(inp, eta)
% H2 function
out = [];
[m, n] = size(inp);
for i = 1:m
    for j = 1:n
        out(i,j) = 1/2 * (1+ (2/pi)*atan(inp(i,j)/eta));
    end
end
end


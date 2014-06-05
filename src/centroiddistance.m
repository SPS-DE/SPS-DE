function ret = centroiddistance(x)
% CENTROIDDISTANCE Distance between each of x and the centroid of x
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE

c = mean(x, 2);
[~, NP] = size(x);
ret = zeros(1, NP);
for i = 1 : NP
	ret(i) = norm(x(:, i) - c);
end
end

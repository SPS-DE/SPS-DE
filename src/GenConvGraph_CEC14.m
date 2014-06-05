function GenConvGraph_CEC14(D, Q)
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE
CONV_XLSX_NAME = sprintf('CEC14_D%d_Q%d_CONV.xlsx', D, Q);
CONV_GRAPH_NAME = sprintf('CEC14_D%d_Q%d_CONVGRAPH.xlsx', D, Q);
solvers = {...
	'dcmaeabin'; ...
	'dcmaea_sps'; ...
	'deglbin'; ...
	'degl_sps'; ...
	'jadebin'; ...
	'jade_sps'; ...
	'rbdebin'; ...
	'rbde_sps'; ...
	'sadebin'; ...
	'sade_sps'; ...
	'shade'; ...
	'shade_sps'};

conv = zeros(30, 21, numel(solvers));

for i = 1 : numel(solvers)
	tmp = xlsread(CONV_XLSX_NAME, solvers{i}, 'A1:U31');
	generation = tmp(1, :);
	conv(:, :, i) = tmp(2 : end, :);
end

titledata = cell(1 + numel(solvers), 1);
titledata{1} = 'Method';
for i = 1 : numel(solvers)
	titledata{i + 1} = solvers{i};
end

data = zeros(numel(solvers) + 1, 21, 30);
for i = 1 : 30
	data(1, :, i) = generation;
	for j = 1 : numel(solvers)
		data(j + 1, :, i) = conv(i, :, j);
	end
end

for i = 1 : 30
	sheet = sprintf('f%d', i);
	xlswrite(CONV_GRAPH_NAME, titledata, sheet, 'A1:A13');
	xlswrite(CONV_GRAPH_NAME, data(:, :, i), sheet, 'B1:V13');
	fprintf('%s: OK!\n', sheet);
end
end
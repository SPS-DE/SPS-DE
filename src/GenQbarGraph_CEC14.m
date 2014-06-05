function GenQbarGraph_CEC14(D, Q)
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE
QBAR_XLSX_NAME = sprintf('CEC14_D%d_Q%d_QBAR.xlsx', D, Q);
QBAR_GRAPH_NAME = sprintf('CEC14_D%d_Q%d_QBARGRAPH.xlsx', D, Q);
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

cont = zeros(30, 21, numel(solvers));

for i = 1 : numel(solvers)
	tmp = xlsread(QBAR_XLSX_NAME, solvers{i}, 'A1:U31');
	generation = tmp(1, :);
	cont(:, :, i) = tmp(2 : end, :);
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
		data(j + 1, :, i) = cont(i, :, j);
	end
end

for i = 1 : 30
	sheet = sprintf('f%d', i);
	xlswrite(QBAR_GRAPH_NAME, titledata, sheet, 'A1:A13');
	xlswrite(QBAR_GRAPH_NAME, data(:, :, i), sheet, 'B1:V13');
	fprintf('%s: OK!\n', sheet);
end
end
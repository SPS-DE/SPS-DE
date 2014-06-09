function GenQbarGraph_CEC11
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE
Q = 32;
QBAR_XLSX_NAME = sprintf('CEC11_Q%d_QBAR.xlsx', Q);
QBAR_GRAPH_NAME = sprintf('CEC11_Q%d_QBARGRAPH.xlsx', Q);
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

nf = 4;
cont = zeros(nf, 21, numel(solvers));

for i = 1 : numel(solvers)
	for retry = 1 : 10
		try
			tmp = xlsread(QBAR_XLSX_NAME, solvers{i}, 'A1:U5');
			break;
		catch ME
			pause(0.1);
			if retry == 10
				rethrow(ME);
			end
		end
	end
	
	generation = tmp(1, :);
	cont(:, :, i) = tmp(2 : end, :);
end

titledata = cell(1 + numel(solvers), 1);
titledata{1} = 'Method';
for i = 1 : numel(solvers)
	titledata{i + 1} = solvers{i};
end

data = zeros(numel(solvers) + 1, 21, nf);
for i = 1 : nf
	data(1, :, i) = generation;
	for j = 1 : numel(solvers)
		data(j + 1, :, i) = cont(i, :, j);
	end
end

for i = 1 : nf
	sheet = sprintf('f%d', i);
	xlswrite(QBAR_GRAPH_NAME, titledata, sheet, 'A1:A13');
	xlswrite(QBAR_GRAPH_NAME, data(:, :, i), sheet, 'B1:V13');
	fprintf('%s: OK!\n', sheet);
end
end

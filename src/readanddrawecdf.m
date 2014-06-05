function readanddrawecdf(...
	metafilename_cec11_o, ...
	metafilename_cec14_o_D10, ...
	metafilename_cec14_o_D30, ...
	metafilename_cec14_o_D50, ...
	metafilename_cec11_sps, ...
	metafilename_cec14_sps_D10, ...
	metafilename_cec14_sps_D30, ...
	metafilename_cec14_sps_D50)
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE

load(metafilename_cec11_o);
load(filenames{1});
nruns = measureOptions.Runs;

%% Original solution errors/function values
eo = zeros(nruns, 8, 94);

load(metafilename_cec11_o);
filenames_tmp = filenames; %#ok<*NODEF>
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 4);
	eo(:, i, 1 : 4) = ei;
end

load(metafilename_cec14_o_D10);
filenames_tmp = filenames;
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 30);
	eo(:, i, 4 + 1 : 4 + 30) = ei;
end

load(metafilename_cec14_o_D30);
filenames_tmp = filenames;
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 30);
	eo(:, i, 1 + 4 + 30 : 4 + 30 + 30) = ei;
end

load(metafilename_cec14_o_D50);
filenames_tmp = filenames;
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 30);
	eo(:, i, 1 + 4 + 30 + 30 : 4 + 30 + 30 + 30) = ei;
end

%% Solution errors/function values with the SPS frameworks
esps = zeros(nruns, 8, 94);

load(metafilename_cec11_sps);
filenames_tmp = filenames;
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 4);
	esps(:, i, 1 : 4) = ei;
end

load(metafilename_cec14_sps_D10);
filenames_tmp = filenames(6, :);
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 30);
	esps(:, i, 4 + 1 : 4 + 30) = ei;
end

load(metafilename_cec14_sps_D30);
filenames_tmp = filenames(6, :);
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 30);
	esps(:, i, 1 + 4 + 30 : 4 + 30 + 30) = ei;
end

load(metafilename_cec14_sps_D50);
filenames_tmp = filenames(6, :);
for i = 1 : numel(filenames_tmp)
	filename = filenames_tmp{i};
	load(filename);
	ei = reshape(allfvals(end, :, :), nruns, 1, 30);
	esps(:, i, 1 + 4 + 30 + 30 : 4 + 30 + 30 + 30) = ei;
end
save('ecdfraw.mat', 'eo', 'esps');

%% Compute ECDF
[nruns, nA, nf] = size(eo);
eomin = reshape(min(min(eo)), nf, 1);
eomax = reshape(max(max(eo)), nf, 1);
espsmin = reshape(min(min(esps)), nf, 1);
espsmax = reshape(max(max(esps)), nf, 1);
emin = min(eomin, espsmin);
emax = max(eomax, espsmax);
eonorm = eo;
espsnorm = esps;

for i = 1 : nruns
	for j = 1 : nA
		for k = 1 : nf
			eonorm(i, j, k) = ...
				(eo(i, j, k) - emin(k) + eps) ./ (emax(k) - emin(k) + eps);
			
			espsnorm(i, j, k) = ...
				(esps(i, j, k) - emin(k) + eps) ./ (emax(k) - emin(k) + eps);
		end
	end
end

h1 = figure;
hold off;
plot(sort(eonorm(:)), (1 : numel(eonorm)) ./ numel(eonorm), 'k');
hold on;
plot(sort(espsnorm(:)), (1 : numel(espsnorm)) ./ numel(espsnorm), 'k--');
title('ECDF over four real-world problems and 90 artificial functions');
xlabel('NSE');
ylabel('ECDF over all functions');
legend('DEs without the proposed framework', ...
	'DEs with the proposed framework', ...
	'Location', 'SouthEast');
h1Position = get(h1, 'Position');
set(h1, 'Position', [h1Position(1:2), 400 * 1.2, 320 * 1.2]);
end
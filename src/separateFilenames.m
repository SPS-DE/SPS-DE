function [metafilename_o, metafilename_sps] = ...
	separateFilenames(metafilename_all)
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE

load(metafilename_all)
N = numel(filenames); %#ok<*NODEF>
filenames_o = cell(1, N/2);
filenames_sps = cell(1, N/2);
for i = 1 : N/2
	filenames_o{i} = filenames{2 * i - 1};
	filenames_sps{i} = filenames{2 * i};
end
outsidedate = datestr(now, 'yyyymmddHHMM');
metafilename_o = sprintf('filenames_o_%s.mat', outsidedate);
filenames = filenames_o;
save(metafilename_o, 'filenames');
metafilename_sps = sprintf('filenames_sps_%s.mat', outsidedate);
filenames = filenames_sps;
save(metafilename_sps, 'filenames');
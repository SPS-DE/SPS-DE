function options = setdefoptions(options, defaultOptions) 
%SETOPTIONS Set options with default options
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE

optionNames = fieldnames(defaultOptions);

for i = 1 : numel(optionNames)
	if ~isfield(options, optionNames{i})
		options.(optionNames{i}) = defaultOptions.(optionNames{i});
	end
end
end


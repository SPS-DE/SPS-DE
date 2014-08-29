function GenRunningTimeReport(filename_time_o, filename_time_sps)
%
% Copyright (C) 2014 Chin-Chang Yang
% See the license at https://github.com/SPS-DE/SPS-DE

load(filename_time_o);
elapsedTime_o = elapsedTime;
load(filename_time_sps);
elapsedTime_sps = elapsedTime;
xlsfilename = sprintf('CEC14_D%d_Q%d_TIME.xlsx', D, Q);
sheet = 'TIME';
	
xlswrite(xlsfilename, ...
	{'DEs without SPS', 'DEs with SPS', 'Overhead'}, ...
	sheet, ...
	'A1:C1');

xlswrite(xlsfilename, ...
	[elapsedTime_o, elapsedTime_sps, elapsedTime_sps/elapsedTime_o - 1], ...
	sheet, ...
	'A2:C2');
end
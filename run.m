% SPS-DE Successful-Parent-Selecting Differential Evolution
% Copyright (C) 2014 Chin-Chang Yang
% 
% This library is free software; you can redistribute it and/or
% modify it under the terms of the GNU Lesser General Public
% License as published by the Free Software Foundation; either
% version 2.1 of the License, or (at your option) any later version.
% 
% This library is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Lesser General Public
% License along with this library; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
% USA

% Path
cd('src');
currentPath = cd;
functionPath = sprintf('%s/function', currentPath);
cauchyPath = sprintf('%s/cauchy', currentPath);
addpath(genpath(functionPath));
addpath(genpath(cauchyPath));

% Four real-world optimization problems
nruns = 51;
geninitialx_cec11;
metafilename = run_complete_cec11(nruns);
[metafilename_cec11_o, metafilename_cec11_sps] = ...
	separateFilenames(metafilename);
readcec11data(metafilename_cec11_o, metafilename_cec11_sps);
GenContGraph_CEC11;
GenConvGraph_CEC11;
GenQbarGraph_CEC11;
GenQdynGraph_CEC11;

% 90 test functions in CEC 2014 benchmarks at D = 10, 30, 50 with
% increasing stagnation tolerance Q = 1, 2, 4, 8, 16, 32, 64, 128, 256, 512
% over 51 independent runs 
Ds = [10, 30, 50];
Qs = 2.^(0:9);
metafilename_cec14_o	= cell(1, numel(Ds));
metafilename_cec14_sps	= cell(1, numel(Ds));
geninitialx_cec14;
for i = 1 : numel(Ds)
	D = Ds(i);
	metafilename_cec14_o{i} = run_complete_cec14_o(D, nruns);
	metafilename_cec14_sps{i} = run_complete_cec14_sps(D, nruns);
	readcec14data(...
		metafilename_cec14_o{i}, metafilename_cec14_sps{i});
	
	for j = 1 : numel(Qs)
		Q = Qs(j);
		GenContGraph_CEC14(D, Q);
		GenConvGraph_CEC14(D, Q);
		GenQbarGraph_CEC14(D, Q);
		GenQdynGraph_CEC14(D, Q);
	end
end

% Fig. 1 and Fig. 2
illustratestagnation;

% ECDF of NSE over four real-world optimization problems and 90 test
% functions in CEC 2014 benchmarks
readanddrawecdf(...
	metafilename_cec11_o, ...
	metafilename_cec14_o{1}, ...
	metafilename_cec14_o{2}, ...
	metafilename_cec14_o{3}, ...
	metafilename_cec11_sps, ...
	metafilename_cec14_sps{1}, ...
	metafilename_cec14_sps{2}, ...
	metafilename_cec14_sps{3});

% 30 test functions in CEC 2014 benchmarks at D = 100 with increasing
% stagnation tolerance Q = 1, 2, 4, 8, 16, 32, 64, 128, 256, 512 over 4
% independent runs  
metafilename_cec14_o_D100 = run_complete_cec14_o(100, 4);
metafilename_cec14_sps_D100 = run_complete_cec14_sps(100, 4);
readcec14data(...
	metafilename_cec14_o_D100, metafilename_cec14_sps_D100);

for j = 1 : numel(Qs)
	Q = Qs(j);
	GenContGraph_CEC14(100, Q);
	GenConvGraph_CEC14(100, Q);
	GenQbarGraph_CEC14(100, Q);
	GenQdynGraph_CEC14(100, Q);
end

% Real computation time of DEs and their SPS variants on CEC 2014
% benchmarks at D = 30 with Q = 32 over 51 independent runs
filename_time_o = run_computation_time_o(30, 51);
filename_time_sps = run_computation_time_sps(30, 32, 51);
GenRunningTimeReport(filename_time_o, filename_time_sps);

#!/usr/bin/octave -q

arg_list = argv ();
inputFile = arg_list{1};
if length(arg_list) >= 2
    k = str2num(arg_list{2});
    ktruss(inputFile, k);
else
    k = 3;
    ktruss_max(inputFile, k);
endif
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph Challenge benchmark
% Developer : Dr. Siddharth Samsi (ssamsi@mit.edu)
%
% MIT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) <2017> Massachusetts Institute of Technology
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
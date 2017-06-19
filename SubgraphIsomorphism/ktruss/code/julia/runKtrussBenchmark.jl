include("ktruss.jl");

input_file = ARGS[1];
if length(ARGS) > 1
	k = parse(Int, ARGS[2]);
	E = ktruss(input_file, k);
else
	k = ktruss_max(input_file);
end

#######################################################
# Graph Challenge Benchmark
# Developer : Dr. Siddharth Samsi (ssamsi@mit.edu)
#
# MIT
#########################################################
# (c) <2017> Massachusetts Institute of Technology
########################################################



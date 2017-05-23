include("ktruss.jl");

input_file = ARGS[1];
k = parse(Int, ARGS[2]);
@time E = ktruss(input_file, k);
# println(E);

#######################################################
# Graph Challenge Benchmark
# Developer : Dr. Siddharth Samsi (ssamsi@mit.edu)
#
# MIT
#########################################################
# (c) <2017> Massachusetts Institute of Technology
########################################################



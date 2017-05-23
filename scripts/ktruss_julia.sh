#!/bin/bash

OUT=$1
INPUT_DIR=/data/GraphChallenge-17
APP_DIR=$HOME/GraphChallenge/SubgraphIsomorphism/ktruss/code/julia
APP=${APP_DIR}/runKtrussBenchmark.jl
EXE=julia
# snap_graphs=(amazon0302 cit-Patents)
# scale_graphs=(graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16)
graphs=(amazon0302 cit-Patents graph500-scale18-ef16)
K=(3 6 12 24 48)

cd ${APP_DIR}
for k in "${K[@]}"
do
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_inc.tsv"
		echo "graph=${graph},k=$k" >> ${OUT}
		${EXE} ${APP} ${input} $k >> ${OUT}
	done
done
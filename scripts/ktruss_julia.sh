#!/bin/bash

OUT=$1
INPUT_DIR=/data/GraphChallenge-17
APP_DIR=$HOME/GraphChallenge/SubgraphIsomorphism/ktruss/code/julia
APP=${APP_DIR}/runKtrussBenchmark.jl
EXE=julia

graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004)
K=(4)

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
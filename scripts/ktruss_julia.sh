#!/bin/bash

OUT=$1
k=$2
INPUT_DIR=$DATA
APP_DIR=$HOME/GraphChallenge/SubgraphIsomorphism/ktruss/code/julia
APP=${APP_DIR}/runKtrussBenchmark.jl
EXE=julia

# graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004)
graphs=(p2p-Gnutella08 ca-HepTh ca-HepPh email-Enron soc-Epinions1 cit-HepPh soc-Slashdot0902 roadNet-PA)

if [ ! -z "$k" ]
then
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_inc.tsv"
		echo "graph=${graph},k=$k" >> ${OUT}
		${EXE} ${APP} ${input} $k >> ${OUT}
	done
else
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_inc.tsv"
		echo "graph=${graph}" >> ${OUT}
		${EXE} ${APP} ${input} >> ${OUT}
	done
fi
#!/bin/bash

OUT=$1
k=$2
INPUT_DIR=/data/GraphChallenge-17
APP=$HOME/GraphChallenge/SubgraphIsomorphism/ktruss/code/python/runKtrussBenchmark.py
PYTHON=$HOME/anaconda/bin/python3

graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004)

if [ ! -z "$k" ]
then
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_inc.tsv"
		echo "graph=${graph},k=$k" >> ${OUT}
		${PYTHON} ${APP} ${input} $k >> ${OUT}
	done
else
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_inc.tsv"
		echo "graph=${graph}" >> ${OUT}
		${PYTHON} ${APP} ${input} >> ${OUT}
	done
fi
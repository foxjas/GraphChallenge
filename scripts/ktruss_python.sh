#!/bin/bash

OUT=$1
k=$2
INPUT_DIR=$DATA
APP=$HOME/GraphChallenge/SubgraphIsomorphism/ktruss/code/python/runKtrussBenchmark.py
PYTHON=$HOME/anaconda/bin/python3

# graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004)
graphs=(p2p-Gnutella08 ca-HepTh ca-HepPh email-Enron soc-Epinions1 cit-HepPh soc-Slashdot0902 roadNet-PA flickrEdges amazon0601 cit-Patents graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16)


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
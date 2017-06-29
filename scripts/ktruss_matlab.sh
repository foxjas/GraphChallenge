#!/bin/bash

OUT=$1
k=$2
INPUT_DIR=$DATA
APP_DIR=$HOME/GraphChallenge/SubgraphIsomorphism/ktruss/code/matlab
APP=${APP_DIR}/runKtrussBenchmark.m
EXE=octave

# graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004)
graphs=(p2p-Gnutella08 ca-HepTh ca-HepPh email-Enron soc-Epinions1 cit-HepPh soc-Slashdot0902 roadNet-PA flickrEdges amazon0601 cit-Patents)

cd ${APP_DIR}

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
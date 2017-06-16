#!/bin/bash

OUT=$1
k=$2

INPUT_DIR=$HOME/data/GraphChallenge-17
APP=$HOME/ktruss2/build/ktruss

graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004 uk-2002)

if [ ! -z "$k" ]
then
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_adj.mmio"
		echo "graph=${graph},k=$k" >> ${OUT}
		${APP} ${input} 4 $k >> ${OUT}
		echo >> ${OUT}
	done
else
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_adj.mmio"
		echo "graph=${graph}" >> ${OUT}
		${APP} ${input} 1 >> ${OUT}
		echo >> ${OUT}
	done
fi
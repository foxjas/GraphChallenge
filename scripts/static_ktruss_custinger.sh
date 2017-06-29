#!/bin/bash

OUT=$1
k=$2

INPUT_DIR=${DATA_HOME}
APP=$HOME/ktruss2/build/ktruss

# graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter cit-Patents soc-LiveJournal1 indochina-2004 uk-2002)
graphs=(p2p-Gnutella08 ca-HepTh ca-HepPh email-Enron soc-Epinions1 cit-HepPh soc-Slashdot0902 roadNet-PA flickrEdges amazon0601 cit-Patents graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16 graph500-scale21-ef16 graph500-scale22-ef16 graph500-scale23-ef16)

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
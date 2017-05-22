#!/bin/bash

OUT=$1
INPUT_DIR=$HOME/data/GraphChallenge-17
APP=$HOME/cuStingerAlg-green/build/ktruss

# snap_graphs=(amazon0302 cit-Patents)
# scale_graphs=(graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16)
graphs=(amazon0302 cit-Patents graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16 graph500-scale21-ef16 graph500-scale22-ef16 graph500-scale23-ef16)
K=(3 6 12 24 48)
for k in "${K[@]}"
do
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}_adj.mtx"
		echo "graph=${graph},k=$k" >> ${OUT}
		${APP} ${input} $k >> ${OUT}
		echo >> ${OUT}
	done
done
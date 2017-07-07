#!/bin/bash

OUT=$1

INPUT_DIR=/data/GraphChallenge-17/James
APP=$HOME/cuStingerAlg2/build/KTruss

graphs=(p2p-Gnutella08 ca-HepTh amazon0601 wiki-Talk as-skitter soc-LiveJournal1) # Wang'12

for graph in "${graphs[@]}"
do
	input="${INPUT_DIR}/${graph}_adj.mtx"
	echo "graph=${graph}" >> ${OUT}
	${APP} ${input} 2 >> ${OUT}
	echo >> ${OUT}
done

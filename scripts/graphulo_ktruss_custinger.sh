#!/bin/bash

OUT=$1
MODE=$2

INPUT_DIR=$DATA
APP=$HOME/cuStingerAlg2/build/KTruss

graphs=(graphulo-scale10 graphulo-scale11 graphulo-scale12 graphulo-scale13 graphulo-scale14 graphulo-scale15 graphulo-scale16)

if [ "$MODE" == 4 ]
then
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}.mmio"
		echo "graph=${graph},k=3" >> ${OUT}
		${APP} ${input} 4 3 >> ${OUT}
		echo >> ${OUT}
	done
else
	for graph in "${graphs[@]}"
	do
		input="${INPUT_DIR}/${graph}.mmio"
		echo "graph=${graph},k=3" >> ${OUT}
		${APP} ${input} 8 3 >> ${OUT}
		echo >> ${OUT}
	done
fi
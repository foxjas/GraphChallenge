#!/bin/bash

OUTDIR=$1
INPUT_DIR=${DATA_HOME}
APP=$HOME/relabeling/src-c/graph_relabeling
graphs=(p2p-Gnutella08 ca-HepTh ca-HepPh email-Enron soc-Epinions1 cit-HepPh soc-Slashdot0902 roadNet-PA flickrEdges amazon0601 cit-Patents graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16 graph500-scale21-ef16 graph500-scale22-ef16 graph500-scale23-ef16)
degFile=${OUTDIR}/topDegrees.out

for graph in "${graphs[@]}"
do
	echo "$APP $INPUT $OUTPUT --degrees"
	INPUT="${INPUT_DIR}/${graph}_adj.mtx"
	OUTPUT="${OUTDIR}/${graph}_adj.degrees"
	touch $OUTPUT
	$APP $INPUT $OUTPUT --degrees
	echo "graph=${graph}" >> $degFile
	head -n 1 $OUTPUT >> $degFile
done
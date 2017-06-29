#!/bin/bash

INPUT_DIR="/data/GraphChallenge-17"
OUTPUT_DIR="/data/GraphChallenge-17/processed"
APP_DIR=$HOME/GraphChallenge/scripts
APP=${APP_DIR}/tsv_mmio_format.py

# graphs=(p2p-Gnutella08 ca-HepTh ca-HepPh email-Enron soc-Epinions1 soc-Slashdot0902 roadNet-PA flickrEdges amazon0601 cit-Patents graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16 graph500-scale21-ef16 graph500-scale22-ef16 graph500-scale23-ef16)
graphs=(graph500-scale18-ef16 graph500-scale19-ef16 graph500-scale20-ef16 graph500-scale21-ef16 graph500-scale22-ef16 graph500-scale23-ef16)

for graph in "${graphs[@]}"
do
	input="${INPUT_DIR}/${graph}_adj.tsv"
	python ${APP} ${input} ${OUTPUT_DIR}
done
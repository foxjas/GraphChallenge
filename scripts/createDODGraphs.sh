#!/bin/bash

APP_DIR=$HOME/GraphChallenge/conversions
APP=${APP_DIR}/graph_conversions
INPUT_DIR=/data/GraphChallenge
OUTPUT_DIR=/data/GraphChallenge/DegreeOrderedDirected
mkdir -p ${OUTPUT_DIR}
ARGS="2 1 --sort --directed-degree"

cd ${APP_DIR}
make

scales=(18 19 20 21 22 23 24 25)
for scale in "${scales[@]}"
do
	echo "${APP} ${INPUT_DIR}/graph500-scale${scale}-ef16_adj.mtx ${OUTPUT_DIR}/graph500-scale${scale}-ef16_adj.mtx ${ARGS}"
	${APP} ${INPUT_DIR}/graph500-scale${scale}-ef16_adj.mtx ${OUTPUT_DIR}/graph500-scale${scale}-ef16_adj.mtx ${ARGS}
done
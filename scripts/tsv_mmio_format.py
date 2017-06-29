#!/usr/bin/python

import sys
import os
from pprint import pprint

"""
Readers have following side effects:
1) ensures *unique* edges, ignoring direction
2) relabels vertices to be between [0, |V|-1]

"""

def SNAPtoIncTSV(inputPath, outPath):
    edge_list = [] # edge = tuple
    vSet = set()

    with open(inputPath, 'r') as fe:
        for line in fe:
            l = line.strip()
            if not l.startswith("#"):
                src_id, dst_id = [int(vId) for vId in l.split()[:2]]
                edge_list.append( (min(src_id, dst_id), max(src_id, dst_id)) )
                vSet.add(src_id)
                vSet.add(dst_id)

    # remove duplicate edges
    edge_list.sort()
    duplicates = 0
    prev_edge = (-1, -1)
    unique_edges = []
    for edge in edge_list:
    	if edge == prev_edge:
    		duplicates += 1
    	else:
    		unique_edges.append(edge)
    	prev_edge = edge

    print("Duplicates removed: {}".format(duplicates))

    # relabeling (compaction)
    vOrdered = sorted(vSet)
    nv = len(vOrdered)
    ne = len(unique_edges)
    relabel_map = { vOrdered[i]: i for i in range(nv) }

    # write out to TSV file
    with open(outPath, 'w') as f_mm:
        for i, edge in enumerate(unique_edges):
        	src, dst = edge
        	src_r, dst_r = relabel_map[src]+1, relabel_map[dst]+1
        	f_mm.write("{}\t{}\t1\n".format(i+1, src_r))
        	f_mm.write("{}\t{}\t1\n".format(i+1, dst_r))

    print("Vertices: {}, Edges: {}".format(nv, ne))


def SNAPtoAdjMMIO(inputPath, outPath):
    edge_list = [] # edge = tuple
    vSet = set()

    with open(inputPath, 'r') as fe:
        for line in fe:
            l = line.strip()
            if not l.startswith("#"):
                src_id, dst_id = [int(vId) for vId in l.split()]
                edge_list.append( (min(src_id, dst_id), max(src_id, dst_id)) )
                vSet.add(src_id)
                vSet.add(dst_id)

    # remove duplicate edges
    edge_list.sort()
    duplicates = 0
    prev_edge = (-1, -1)
    unique_edges = []
    for edge in edge_list:
    	if edge == prev_edge:
    		duplicates += 1
    	else:
    		unique_edges.append(edge)
    	prev_edge = edge

    print("Duplicates removed: {}".format(duplicates))

    # relabeling (compaction)
    vOrdered = sorted(vSet)
    nv = len(vOrdered)
    ne = len(unique_edges)
    relabel_map = { vOrdered[i]: i for i in range(nv) }

    # write out to matrix-market file
    with open(outPath, 'w') as f_mm:
        f_mm.write("%%MatrixMarket matrix coordinate real symmetric\n")
        f_mm.write("{} {} {}\n".format(nv, nv, ne))
        for src, dst in unique_edges:
        	src_r, dst_r = relabel_map[src]+1, relabel_map[dst]+1
        	f_mm.write("{} {}\n".format(src_r, dst_r))

    print("Vertices: {}, Edges: {}".format(nv, ne))



def main(argv):
    inputPath = argv[0]
    outDir = argv[1] # produce both _inc.tsv and _adj.mmio files
    baseName = os.path.basename(inputPath).split('.')[0]
    if "_" in baseName:
        baseName = baseName.split('_')[0]
    outPath = os.path.join(outDir, baseName+"_adj.mmio")
    # SNAPtoAdjMMIO(inputPath, outPath)
    outPath2 = os.path.join(outDir, baseName+"_inc.tsv")
    SNAPtoIncTSV(inputPath, outPath2)
    
if __name__ == "__main__":
    main(sys.argv[1:])
#!/usr/bin/python

import sys
import os
from pprint import pprint

def graphuloToMarket(rowsPath, colsPath, outPath):
    with open(rowsPath, 'r') as rf:
        line = rf.readline()
        rowIdsStr = line.split(',')[:-1]
        rowIds = [int(r) for r in rowIdsStr]

    with open(colsPath, 'r') as cf:
        line = cf.readline()
        colIdsStr = line.split(',')[:-1]
        colIds = [int(c) for c in colIdsStr]

    edge_list = []
    vSet = set()
    self_edges = 0
    for rid, cid in zip(rowIds, colIds):
        if rid == cid:
            self_edges += 1
            continue
        edge_list.append((min(rid,cid), max(rid,cid)))
        vSet.add(rid)
        vSet.add(cid)

    # remove duplicate Edges
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

    print("Self-edges removed: {}".format(self_edges))
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
    rowsPath = argv[0]
    colsPath = argv[1]
    outPath = argv[2]
    graphuloToMarket(rowsPath, colsPath, outPath)
    
if __name__ == "__main__":
    main(sys.argv[1:])
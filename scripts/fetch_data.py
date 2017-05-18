#!/usr/bin/env python

import optparse
import sys
import wget

SNAP="s3://graphchallenge/snap/{}/{}{}.{}" # name, name, suffix, format
SCALE="s3://graphchallenge/synthetic/graph500-scale{}-ef16/graph500-scale{}-ef16{}.{}"

if __name__ == "__main__":
    parser = optparse.OptionParser()
    parser.add_option('--tsv', action="store_true", default=True, dest=tsv)
    parser.add_option('--mmio', action="store_true", default=True, dest=mmio)
    opts, args = parser.parse_args(sys.argv[1:])

    if not len(args) == 2:
        print("Should be 2 args")

    g_type, g_name = args[0], args[1]
    if g_type == "snap":
        url = SNAP
    else:
        url = SCALE

    if opts.tsv:
        fname = wget.download(url.format(args[1], args[1], '', "tsv"), out=dest)
    if otps.mmio:
        fname = wget.download(url.format(args[1], args[1], '', "mmio"), out=dest)

"""
    s3://graphchallenge/snap/[URL_SUFFIX]/[URL_SUFFIX].tsv
    s3://graphchallenge/snap/[URL_SUFFIX]/[URL_SUFFIX]_adj.tsv
    s3://graphchallenge/snap/[URL_SUFFIX]/[URL_SUFFIX]_inc.tsv
"""

"""
    s3://graphchallenge/synthetic/graph500-scale[SCALE]-ef16/graph500-scale[SCALE]-ef16.mmio
    s3://graphchallenge/synthetic/graph500-scale[SCALE]-ef16/graph500-scale[SCALE]-ef16_adj.mmio
    s3://graphchallenge/synthetic/graph500-scale[SCALE]-ef16/graph500-scale[SCALE]-ef16_inc.mmio
"""


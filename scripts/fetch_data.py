#!/usr/bin/env python

import optparse
import sys
import urllib.request
import shutil
from os.path import join

SNAP="https://graphchallenge.s3.amazonaws.com/snap/{}/{}{}.{}" # name, name, suffix, format
SCALE="https://graphchallenge.s3.amazonaws.com/synthetic/graph500-scale{}-ef16/graph500-scale{}-ef16{}.{}.gz" # name, name, suffix, format

def download(url, outpath):
    try:
        with urllib.request.urlopen(url) as response, open(outpath, 'wb') as out_file:
            shutil.copyfileobj(response, out_file)
        print("{} successfully downloaded".format(url))
    except Exception as e:
        print("{} failed; {}".format(url, e))

if __name__ == "__main__":
    help_text = """ <snap|scale> [graph name] [outdir path] ... options """
    parser = optparse.OptionParser(usage=help_text)
    parser.add_option('--tsv', action="store_true", default=False, dest="tsv", help="include tsv format")
    parser.add_option('--mmio', action="store_true", default=False, dest="mmio", help="include mmio format")
    opts, args = parser.parse_args(sys.argv[1:])

    if not len(args) == 3:
        print("Should be 3 args")

    g_type, g_name = args[0], args[1]
    dest_dir = args[2]
    if g_type == "snap":
        dest_fname = g_name + "{}"
        url_template = SNAP
    else:
        dest_prefix = "graph500-scale{}-ef16".format(args[1])
        dest_fname = dest_prefix + "{}" + ".gz"
        url_template = SCALE

    if opts.tsv or (not opts.tsv and not opts.mmio):
        outpath = join(dest_dir, dest_fname.format('.tsv'))
        url = url_template.format(args[1], args[1], '', "tsv")
        download(url, outpath)

        outpath = join(dest_dir, dest_fname.format("_adj.tsv"))
        url = url_template.format(args[1], args[1], '_adj', "tsv")
        download(url, outpath)

        outpath = join(dest_dir, dest_fname.format("_inc.tsv"))
        url = url_template.format(args[1], args[1], '_inc', "tsv")
        download(url, outpath)

    if opts.mmio or (not opts.tsv and not opts.mmio):
        outpath = join(dest_dir, dest_fname.format("_adj.mmio"))
        url = url_template.format(args[1], args[1], '_adj', "mmio")
        download(url, outpath)

        outpath = join(dest_dir, dest_fname.format("_inc.mmio"))
        url = url_template.format(args[1], args[1], '_inc', "mmio")
        download(url, outpath)


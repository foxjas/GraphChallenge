import numpy as np
import scipy as sp
import sys
from ktruss import ktruss

#Use the pandas package if available
#import pandas as pd

args = sys.argv[1:]
if not len(args) == 2:
	print("Usage: [input] [k]")
	sys.exit()

# inc_file = '../../../data/ktruss_example.tsv';
inc_file = args[0]
k = int(args[1])

# E_expected=np.array([ (1, 1, 0 ,0 ,0), (0, 1, 1 ,0 ,0), (1, 0,0,1,0),(0,0,1,1,0),(1,0,1,0,0),(0,0,0,0,0) ])

E=ktruss(inc_file,k)
# print(E.toarray())

# if sum(sum(E.toarray()-E_expected)):
#     print("unable to verify")
# else:
#     print(E.toarray()) # verbose option?

###################################################
# Graph Challenge benchmark
# Developer: Dr. Vijay Gadepally (vijayg@mit.edu)
# MIT
###################################################
# (c) <2015> Vijay Gadepally
###################################################
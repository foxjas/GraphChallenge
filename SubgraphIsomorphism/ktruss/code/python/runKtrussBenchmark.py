import numpy as np
import scipy as sp
import sys
from ktruss import ktruss, ktruss_max

#Use the pandas package if available
#import pandas as pd

args = sys.argv[1:]
inc_file = args[0]
if len(args) > 1:
	k = int(args[1])
	E=ktruss(inc_file,k)
else:
	E=ktruss_max(inc_file)
# E_expected=np.array([ (1, 1, 0 ,0 ,0), (0, 1, 1 ,0 ,0), (1, 0,0,1,0),(0,0,1,1,0),(1,0,1,0,0),(0,0,0,0,0) ])

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
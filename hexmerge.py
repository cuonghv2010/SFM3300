import sys
from intelhex import IntelHex
 
usage = "%s hex_infile1 hex_infile2 hex_outfile" % sys.argv[0]
if len(sys.argv) != 4:
    print(usage)
    sys.exit(1)
 
infile1, infile2,outfile  = sys.argv[1:]
 
ih1 = IntelHex(infile1)
ih2 = IntelHex(infile2)
ih1.merge(ih2, overlap='ignore')
ih1.write_hex_file(outfile)


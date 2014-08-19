#
# Filename: nacpeepjmpcc.awk
# Purpose : A peephole optimizer for the NAC programming language.
# Author  : Nikolaos Kavvadias (C) 2010
# Date    : 17-Nov-2010
# Revision: 0.3.0 (17/11/10)
#           Initial version.
# Notes   :
# RULES
# 1. Replacement of incomplete conditional jumps:
# The pattern 
#   S_TRUE <= jmpxx opnd1, opnd2; 
# is replaced by:
#   S_TRUE, S_FALSE <= jmpxx opnd1, opnd2;
# S_FALSE:  // the label is generated only if it doesn't already exist
#

BEGIN {
  RS = "\n";
  ix = 1;
  labcnt = 1;
}

{
  ixstr = sprintf("%5d", ix);
  nacstmts[ixstr] = $0;
  ix = ix + 1;
}

END {
# copy indices
  j = 1;
  for (ix in nacstmts) {
    # index value becomes element value
    ind[j] = ix; 
    j++;
  }

  # index values are now sorted
  n = asort(ind); 

  # 1. Replacement of incomplete conditional jumps.
  for (i = 1; i <= n; i++) {
    split(nacstmts[ind[i]], currarr);
    split(nacstmts[ind[i+1]], nextarr);   
    if ((currarr[2] == "<=") && match(currarr[3], /jmp+/) && (currarr[3] != "jmpun")) {
      if (nextarr[2] != ":") {
        newlab = sprintf("S_%05d_X", labcnt);
        labcnt = labcnt + 1;
        print currarr[1], ",", newlab, currarr[2], currarr[3], currarr[4], currarr[5], currarr[6], ";";
        print newlab, ":";
      }
      else {
        print currarr[1], ",", nextarr[1], currarr[2], currarr[3], currarr[4], currarr[5], currarr[6], ";";
      }
    }
    else {
      print nacstmts[ind[i]];
    }
  }
}

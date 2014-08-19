#
# Filename: nacpeepjmpun.awk
# Purpose : A peephole optimizer for the NAC programming language.
# Author  : Nikolaos Kavvadias (C) 2010
# Date    : 17-Nov-2010
# Revision: 0.3.0 (17/11/10)
#           Initial version.
# Notes   :
# RULES
# 2. Addition of "forgotten" unconditional jumps. The pattern
#   no-jump-instruction;
# LABEL:  
# is replaced by:
#   no-jump-instruction;
#   LABEL <= jmpun;
# LABEL:  
#

BEGIN {
  RS = "\n";
  ix = 1;
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

  # 2. Handling omitted jmpuns.
  for (i = 1; i <= n; i++) {
    split(nacstmts[ind[i]], currarr);
    split(nacstmts[ind[i+1]], nextarr);   
    print nacstmts[ind[i]];
    matchpos = match(nacstmts[ind[i]], /jmp*/);
    if ((currarr[1] != "localvar") && 
         (matchpos == 0) && 
         (nextarr[2] == ":")) {
      print nextarr[1], "<= jmpun ;";
    }
  }
}

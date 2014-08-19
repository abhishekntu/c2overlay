#
# Filename: gimplefgmpfix.awk
# Purpose : Fix mpz_* function invocations (as defined by the fgmp API).
# Author  : Nikolaos Kavvadias (C) 2013
# Date    : 28-Aug-2013
# Revision: 0.4.0 (28/08/13)
#           Initial version.

function nofirstchar(x) {
  return (substr(x, 2, length(x)));
}

BEGIN {
  RS = "\n";
  ix = 1;
  flag = 0;
}

{
  ixstr = sprintf("%5d", ix);
  gimplestmts[ixstr] = $0;
  ix = ix + 1;
}

END {
  # copy indices
  j = 1;
  for (ix in gimplestmts) {
    # index value becomes element value
    ind[j] = ix; 
    j++;
  }
    
  # index values are now sorted
  n = asort(ind); 

#  do {
#    flag = "0";
   
    for (i = 1; i <= n; i++) {
      split(gimplestmts[ind[i]], currarr);
           
      # gimple_call < mpz_init , NULL , &%0 >
      # =
      # gimple_call < mpz_init , NULL , %0 >
      if ((currarr[1] == "gimple_call") && (currarr[3] == "mpz_init")) {
        gimplestmts[ind[i]] = sprintf("gimple_call < mpz_init , NULL , %s >", 
          nofirstchar(currarr[7]));
        flag = "1";
      }
      # gimple_call < mpz_set_ui , NULL , &%0 , %1 >
      # =
      # gimple_call < mpz_set_ui , NULL , %0 , %1 >
      else if ((currarr[1] == "gimple_call") && (currarr[3] == "mpz_set_ui")) {
        gimplestmts[ind[i]] = sprintf("gimple_call < mpz_set_ui , NULL , %s , %s >", 
          nofirstchar(currarr[7]), currarr[9]);
        flag = "1";
      }
      # gimple_call < mpz_mul_ui , NULL , &%0 , &%1 , %2 >
      # =
      # gimple_call < mpz_mul_ui , NULL , %0 , %1 , %2 >      
      else if ((currarr[1] == "gimple_call") && (currarr[3] == "mpz_mul_ui")) {
        gimplestmts[ind[i]] = sprintf("gimple_call < mpz_mul_ui , NULL , %s , %s , %s >", 
          nofirstchar(currarr[7]), nofirstchar(currarr[9]), currarr[11]);
        flag = "1";
      }
      # gimple_call < mpz_printh , NULL , &%0 >
      # =
      # gimple_call < mpz_printh , NULL , %0 >
      else if ((currarr[1] == "gimple_call") && (currarr[3] == "mpz_printh")) {
        gimplestmts[ind[i]] = sprintf("gimple_call < mpz_printh , NULL , %s >", 
          nofirstchar(currarr[7]));
        flag = "1";
      }
      # gimple_call < mpz_add , NULL , &%0 , &%1 , &%2 >
      # =
      # gimple_call < mpz_add , NULL , %0 , %1 , %2 >
      else if ((currarr[1] == "gimple_call") && (currarr[3] == "mpz_add")) {
        gimplestmts[ind[i]] = sprintf("gimple_call < mpz_add , NULL , %s , %s , %s >", 
          nofirstchar(currarr[7]), nofirstchar(currarr[9]), nofirstchar(currarr[11]));
        flag = "1";
      }
      # gimple_call < mpz_set , NULL , &%0 , &%1 >
      # =
      # gimple_call < mpz_set , NULL , %0 , %1 >      
      else if ((currarr[1] == "gimple_call") && (currarr[3] == "mpz_set")) {
        gimplestmts[ind[i]] = sprintf("gimple_call < mpz_set , NULL , %s , %s >", 
          nofirstchar(currarr[7]), nofirstchar(currarr[9]));
        flag = "1";
      }
    }
#  } while (flag != "0");

  for (i = 1; i <= n; i++) {
#    flag = "1";
    split(gimplestmts[ind[i]], currarr);    
    if (i < n) {
      split(gimplestmts[ind[i+1]], nextarr);
#      if (nextarr[1] != "}" && currarr[1] == "nop") {
#        flag = "0";
#      }
    }
#    if (flag == "1") {
      print gimplestmts[ind[i]];
#    }
  }
}

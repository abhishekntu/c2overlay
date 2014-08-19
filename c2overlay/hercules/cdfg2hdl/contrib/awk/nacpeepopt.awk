#
# Filename: nacpeepopt.awk
# Purpose : A peephole optimizer for the NAC programming language.
# Author  : Nikolaos Kavvadias (C) 2010, 2011, 2012, 2013
# Date    : 15-Jan-2013
# Revision: 0.3.0 (19/11/10)
#           Initial version.
#           0.3.1 (02/05/11)
#           Added rules "bitget" (12), "bitset" (13).
#           0.3.2 (26/07/11)
#           Added rule for if(1){} (14).
#           0.3.3 (29/08/11)
#           Added rules for rem, mod (15-17).
#           0.4.0 (15/01/13)
#           Added rule for rem/mod by power-of-2 (39).
# Notes   :
# RULES
# 1. y <= add x , 0 ;    // x + 0 = x;
# 2. y <= sub x , 0 ;    // x - 0 = x;
# ?. y <= neg num ;      // y = - num;
# ?. x <= mov x ;        // x = x;
# 3. t <= mul x , 0 ;    // x * 0 = 0;
# 4. y <= mul x , 1 ;    // x * 1 = x;
# 7. y <= div x , 1 ;    // x / 1 = x;
# 6. t <= mul x , 2^n ;  // x * 2^n = x << n;
# ?. t <= add x , x ;    // x + x = x << 1;
# ?. t <= dbl x ;        // x + x = x << 1;
# ?. t <= sub x , x ;    // x - x = 0;
# 8. t <= div x , 2^n ;  // x / 2^n = x >> n;
# 9. y <= div x , x ;    // x / x  = 1;
# 10. y <= shl x , 0 ;   // x << 0 = y;
# 11. y <= shr x , 0 ;   // x >> 0 = y;
# 12. y <= bitget x , z ; // y = bitextract(x,z,z);
# 13. y <= bitset x , z ; // y = bitinsert(x,z,z);
# 14. L1 , L2 <= jmpne 1 , 0 ; // L1 <= jmpun; from if(1){}
# ??. L1 , L2 <= jmpeq x , x ; // L1 <= jmpun;
# ??. L1 , L2 <= jmpne x , x ; // L2 <= jmpun;
# ??. L1 , L2 <= jmplt x , x ; // L2 <= jmpun;
# ??. L1 , L2 <= jmple x , x ; // L1 <= jmpun;
# ??. L1 , L2 <= jmpgt x , x ; // L2 <= jmpun;
# ??. L1 , L2 <= jmpge x , x ; // L1 <= jmpun;
# 15. y <= mod x , 0 ;    // mod(x,0) = x;
# 16. y <= mod x , x ;    // mod(x,x) = 0; for x != 0
# 17. y <= rem x , x ;    // rem(x,x) = 0; for x != 0
# 18. y <= seq x , x ;    // x == x => 1; for all x
# 19. y <= sne x , x ;    // x != x => 0; for all x
# 20. y <= slt x , x ;    // x < x => 0; for all x
# 21. y <= sle x , x ;    // x <= x => 1; for all x
# 22. y <= sgt x , x ;    // x > x => 0; for all x
# 23. y <= sge x , x ;    // x >= x => 1; for all x
# 24. y <= muxzz x , z , u , u ;  // y = (x op z) ? u : u; => y = u;
# 25. y <= muxeq x , x , u , v ;  // y = (x eq x) ? u : v; => y = u;
# 26. y <= muxne x , x , u , v ;  // y = (x ne x) ? u : v; => y = v;
# 27. y <= muxlt x , x , u , v ;  // y = (x lt x) ? u : v; => y = v;
# 28. y <= muxle x , x , u , v ;  // y = (x le x) ? u : v; => y = u;
# 29. y <= muxgt x , x , u , v ;  // y = (x gt x) ? u : v; => y = v;
# 30. y <= muxge x , x , u , v ;  // y = (x ge x) ? u : v; => y = u;
# 31. y <= muxzz x , x , u , u ;  // y = (x op x) ? u : u; => y = u;
# 32. y <= max x , x ;    // max(x,x) = x;
# 33. y <= min x , x ;    // min(x,x) = x;
# 34. y <= rotl x , 0 ;   // x <<< 0 = x;
# 35. y <= rotr x , 0 ;   // x >>> 0 = x;
# 36. y <= and x , x ;    // x & x = x;
# 37. y <= ior x , x ;    // x | x = x;
# 38. y <= xor x , x ;    // x ^ x = 0;
# 39. t <= mod x , 2^n ;  // x % 2^n = x & 2^n-1;
# TBD1. y <= mul x, intcnst; // constant multiplication optimization
#                            // naive, bernstein, ...
# TBD2. y <= div x, intcnst; // constant division optimization
#                            // as mult. by magic number
#

function ilog2(x) { 
  return int(log(x)/log(2));
} 

function ispowof2(x) { 
  while (((x % 2) == 0) && x > 1) {
     x /= 2;
  }
  return (x == 1);
} 

function isnum(x) {
  return (x==x+0);
}

BEGIN {
  RS = "\n";
  ix = 1;
  flag = 0;
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

  do {
    flag = "0";
   
    for (i = 1; i <= n; i++) {
      split(nacstmts[ind[i]], currarr);
      
      # 1. y <= add x , 0 ;  // x + 0 = x;
      # 2. y <= sub x , 0 ;  // x - 0 = x;
      if ((currarr[2] == "<=") && 
          ((currarr[3] == "add") || (currarr[3] == "sub")) && 
          (currarr[6] == "0")) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # ?. y <= neg num ;  // y = - x;
      else if ((currarr[2] == "<=") && (currarr[3] == "neg") && (isnum(currarr[4]) == 1)) {
        nacstmts[ind[i]] = sprintf("%s <= ldc - %s ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # ?. x <= mov x ;  // x = x;
      else if ((currarr[2] == "<=") && (currarr[3] == "mov") && (currarr[1] == currarr[4])) {
        nacstmts[ind[i]] = sprintf("nop ;");
        flag = "1";
      }
      # 3. t <= mul x , 0 ;  // x * 0 = 0;
      else if ((currarr[2] == "<=") && (currarr[3] == "mul") && (currarr[6] == "0")) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 0 ;", currarr[1]);
        flag = "1";
      }
      # 4. y <= mul x , 1 ;  // x * 1 = x;
      # 7. y <= div x , 1 ;  // x / 1 = x;
      else if ((currarr[2] == "<=") && 
              ((currarr[3] == "mul") || (currarr[3] == "div")) && (currarr[6] == "1")) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # 6. t <= mul x , 2^n ;  // x * 2^n = x << n;
      else if ((currarr[2] == "<=") && (currarr[3] == "mul") && (ispowof2(strtonum(currarr[6])) == 1)) {
        opnd2 = strtonum(currarr[6]);
        opnd2_exp = ilog2(opnd2);
        nacstmts[ind[i]] = sprintf("%s <= shl %s , %s ;", currarr[1], currarr[4], opnd2_exp);
        flag = "1";
      }
      # ?. t <= add x , x ;  // x + x = x << 1;
      else if ((currarr[2] == "<=") && (currarr[3] == "add") && (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= shl %s , 1 ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # ?. t <= dbl x ;  // x + x = x << 1;
      else if ((currarr[2] == "<=") && (currarr[3] == "dbl")) {
        nacstmts[ind[i]] = sprintf("%s <= shl %s , 1 ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # ?. t <= sub x , x ;  // x - x = 0;
      else if ((currarr[2] == "<=") && (currarr[3] == "sub") && (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 0 ;", currarr[1]);
        flag = "1";
      }
      # 8. t <= div x , 2^n ;  // x / 2^n = x >> n;
      else if ((currarr[2] == "<=") && (currarr[3] == "div") && (ispowof2(strtonum(currarr[6])) == 1)) {
        opnd2 = strtonum(currarr[6]);
        opnd2_exp = ilog2(opnd2);
        nacstmts[ind[i]] = sprintf("%s <= shr %s , %s ;", currarr[1], currarr[4], opnd2_exp);
        flag = "1";
      }
      # 9. y <= div x , x ;  // x / x  = 1;
      else if ((currarr[2] == "<=") && (currarr[3] == "div") && (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 1 ;", currarr[1]);
        flag = "1";
      }
      # 10. y <= shl x , 0 ;  // x << 0 = y;
      # 11. y <= shr x , 0 ;  // x >> 0 = y;
      else if ((currarr[2] == "<=") && 
        ((currarr[3] == "shl") || (currarr[3] == "shr")) && 
        (currarr[6] == "0")) {
         nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # 12. y <= bitget x , z ; // y = bitextract(x,z,z);
      else if ((currarr[2] == "<=") && (currarr[3] == "bitget")) {
        nacstmts[ind[i]] = sprintf("%s <= bitextract %s , %s , %s ;", currarr[1], currarr[4], currarr[6], currarr[6]);
        flag = "1";
      }
      # 13. y <= bitset x , z ; // y = bitinsert(x,z,z);
      else if ((currarr[2] == "<=") && (currarr[3] == "bitset")) {
        nacstmts[ind[i]] = sprintf("%s <= bitinsert %s , %s , %s ;", currarr[1], currarr[4], currarr[6], currarr[6]);
        flag = "1";
      }
      # 14. L1 , L2 <= jmpne 1 , 0 ; // L1 <= jmpun; from if(1){}
      else if ((currarr[4] == "<=") && (currarr[5] == "jmpne") && (currarr[6] == "1") && (currarr[8] == "0")) {
        nacstmts[ind[i]] = sprintf("%s <= jmpun ;", currarr[1]);
        flag = "1";
      }
      # ??. L1 , L2 <= jmpeq x , x ; // L1 <= jmpun;
      # ??. L1 , L2 <= jmple x , x ; // L1 <= jmpun;
      # ??. L1 , L2 <= jmpge x , x ; // L1 <= jmpun;
      else if ((currarr[4] == "<=") && ((currarr[5] == "jmpeq") || (currarr[5] == "jmple") || (currarr[5] == "jmpge")) && 
               (currarr[6] == currarr[8])) {
        nacstmts[ind[i]] = sprintf("%s <= jmpun ;", currarr[1]);
        flag = "1";
      }      
      # ??. L1 , L2 <= jmpne x , x ; // L2 <= jmpun;
      # ??. L1 , L2 <= jmplt x , x ; // L2 <= jmpun;
      # ??. L1 , L2 <= jmpgt x , x ; // L2 <= jmpun;
      else if ((currarr[4] == "<=") && ((currarr[5] == "jmpne") || (currarr[5] == "jmplt") || (currarr[5] == "jmpgt")) && 
               (currarr[6] == currarr[8])) {
        nacstmts[ind[i]] = sprintf("%s <= jmpun ;", currarr[3]);
        flag = "1";
      }      
      # 16. y <= mod x , x ;    // mod(x,x) = 0; for x != 0
      # 17. y <= rem x , x ;    // rem(x,x) = 0; for x != 0
      else if ((currarr[2] == "<=") && ((currarr[3] == "mod") || (currarr[3] == "rem")) && 
               (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 0 ;", currarr[1]);
        flag = "1";
      }
      # 15. y <= mod x , 0 ;    // mod(x,0) = x;
      else if ((currarr[2] == "<=") && (currarr[3] == "mod") && (currarr[6] == "0")) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # 18. y <= seq x , x ;    // x == x => 1; for all x
      # 21. y <= sle x , x ;    // x <= x => 1; for all x
      # 23. y <= sge x , x ;    // x >= x => 1; for all x      
      else if ((currarr[2] == "<=") && ((currarr[3] == "seq") || (currarr[3] == "sle") || (currarr[3] == "sge")) && 
               (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 1 ;", currarr[1]);
        flag = "1";
      }
      # 19. y <= sne x , x ;    // x != x => 0; for all x
      # 20. y <= slt x , x ;    // x < x => 0; for all x
      # 22. y <= sgt x , x ;    // x > x => 0; for all x
      else if ((currarr[2] == "<=") && ((currarr[3] == "sne") || (currarr[3] == "slt") || (currarr[3] == "sgt")) && 
               (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 0 ;", currarr[1]);
        flag = "1";
      }
      # 24. y <= muxzz x , z , u , u ;  // y = (x op z) ? u : u; => y = u;
      else if ((currarr[2] == "<=") && ((currarr[3] == "muxeq") || (currarr[3] == "muxne") || (currarr[3] == "muxlt") ||
               (currarr[3] == "muxle") || (currarr[3] == "muxgt") || (currarr[3] == "muxge")) && 
               (currarr[8] == currarr[10])) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[8]);
        flag = "1";
      }      
      # 25. y <= muxeq x , x , u , v ;  // y = (x eq x) ? u : v; => y = u;
      # 28. y <= muxle x , x , u , v ;  // y = (x le x) ? u : v; => y = u;
      # 30. y <= muxge x , x , u , v ;  // y = (x ge x) ? u : v; => y = u;
      else if ((currarr[2] == "<=") && ((currarr[3] == "muxeq") || (currarr[3] == "muxle") || (currarr[3] == "muxge")) && 
               (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[8]);
        flag = "1";
      }      
      # 26. y <= muxne x , x , u , v ;  // y = (x ne x) ? u : v; => y = v;
      # 27. y <= muxlt x , x , u , v ;  // y = (x lt x) ? u : v; => y = v;
      # 29. y <= muxgt x , x , u , v ;  // y = (x gt x) ? u : v; => y = v;
      else if ((currarr[2] == "<=") && ((currarr[3] == "muxne") || (currarr[3] == "muxlt") || (currarr[3] == "muxgt")) && 
               (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[10]);
        flag = "1";
      }      
      # 31. y <= muxzz x , x , u , u ;  // y = (x op x) ? u : u; => y = u;
      else if ((currarr[2] == "<=") && ((currarr[3] == "muxeq") || (currarr[3] == "muxne") || (currarr[3] == "muxlt") ||
               (currarr[3] == "muxle") || (currarr[3] == "muxgt") || (currarr[3] == "muxge")) && 
               (currarr[4] == currarr[6]) && (currarr[8] == currarr[10])) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[8]);
        flag = "1";
      }      
      # 32. y <= max x , x ;    // max(x,x) = x;
      # 33. y <= min x , x ;    // min(x,x) = x;
      else if ((currarr[2] == "<=") && ((currarr[3] == "max") || (currarr[3] == "min")) && 
               (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }    
      # 34. y <= rotl x , 0 ;   // x <<< 0 = x;
      # 35. y <= rotr x , 0 ;   // x >>> 0 = x;
      else if ((currarr[2] == "<=") && 
        ((currarr[3] == "rotl") || (currarr[3] == "rotr")) && (currarr[6] == "0")) {
         nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }
      # 36. y <= and x , x ;    // x & x = x;
      # 37. y <= ior x , x ;    // x | x = x;
      else if ((currarr[2] == "<=") && 
        ((currarr[3] == "and") || (currarr[3] == "ior")) && (currarr[4] == currarr[6])) {
         nacstmts[ind[i]] = sprintf("%s <= mov %s ;", currarr[1], currarr[4]);
        flag = "1";
      }    
      # 38. y <= xor x , x ;    // x ^ x = 0;
      else if ((currarr[2] == "<=") && ((currarr[3] == "xor")) && (currarr[4] == currarr[6])) {
        nacstmts[ind[i]] = sprintf("%s <= ldc 0 ;", currarr[1]);
        flag = "1";
      }      
      # 39. t <= mod x , 2^n ;  // x % 2^n = x & 2^n-1;
      else if ((currarr[2] == "<=") && (currarr[3] == "mod" || currarr[3] == "rem") && (ispowof2(strtonum(currarr[6])) == 1)) {
        opnd2 = strtonum(currarr[6]);
        opnd2_exp = opnd2 - 1;
        nacstmts[ind[i]] = sprintf("%s <= and %s , %s ;", currarr[1], currarr[4], opnd2_exp);
        flag = "1";
      }
    }
  } while (flag != "0");

  for (i = 1; i <= n; i++) {
    flag = "1";
    split(nacstmts[ind[i]], currarr);    
    if (i < n) {
      split(nacstmts[ind[i+1]], nextarr);
      if (nextarr[1] != "}" && currarr[1] == "nop") {
        flag = "0";
      }
    }
    if (flag == "1") {
      print nacstmts[ind[i]];
    }
  }
}

/* 
 * Count the number of nodes (vertices) and edges in the graph. 
 * Nikolaos Kavvadias 2011-03-27 
 */ 

BEGIN {
  int cnt_v;
  int cnt_e;
  string fmt;
}

BEG_G {
  cnt_v = 0;
  cnt_e = 0;
}

N { 
  cnt_v++;
}

E { 
  cnt_e++;
}

END_G {
//  fmt = sprintf("V = %%d\n");
//  fmt = sprintf("%sE = = %%%%d\n", fmt);
//  fmt = sprintf("%sE = %%%%d", fmt, "%%\n");
//  printf (1, fmt, cnt_v, cnt_e);
  printf("(V=%d, E=%d)\n", cnt_v, cnt_e);  
  cnt_v = 0;
  cnt_e = 0;
}

/* Eliminates dead (unconnected) nodes as well as nodes that donnot perform 
 * any useful computations. 
 */
BEGIN {
  graph_t newg;
  node_t  n;
}
BEG_G {
  newg = clone(NULL, $G);
}
N {
  if (outdegree == 0)
  {
    if (name == "mov*")
    {
      printf("// (%s, I:%d, O:%d)\n", name, indegree, outdegree);
      n = clone(newg, $);
      delete(newg, n);
    }
  }
}
END_G {
  $O = newg;
}
END {
}

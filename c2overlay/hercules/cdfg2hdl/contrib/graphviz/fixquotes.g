/* Adds double quotes to attribute values. */
BEG_G {
  string attr;
  string attrv;
  string temp;
  int flag;
  $O = $G;
}
N { 
  attr = fstAttr($G, "N");
  while (attr != "") {
    attrv = aget($, attr);
    if (attrv != "") {
      temp = sprintf("\040%s\040", attrv);
      flag = aset($, attr, temp);
    }
    attr = nxtAttr($G, "N", attr);
  }  
}
E {
  attr = fstAttr($G, "E");
  while (attr != "") {
    attrv = aget($, attr);
    if (attrv != "") {
      temp = sprintf("\040%s\040", attrv);
      flag = aset($, attr, temp);
    }
    attr = nxtAttr($G, "E", attr);
  }  
}
END {
}

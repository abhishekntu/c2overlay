#
# Filename: remblanklines.awk
# Purpose : Removes blank lines from NAC files.
# Author  : Nikolaos Kavvadias (C) 2010
# Date    : 17-Nov-2010
# Revision: 0.3.0 (17/11/10)
#           Initial version.
# Notes   :
{ 
  if ((NF > 0) && (!match($0, /\/\/*/))) {
    print $0;
  }
}

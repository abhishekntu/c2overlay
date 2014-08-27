# File automatically generated by "cdfg2hdl".
# Filename: sierpinski
# Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

#!/bin/bash

vsim -c -do "sierpinski.do"
if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
exit 0
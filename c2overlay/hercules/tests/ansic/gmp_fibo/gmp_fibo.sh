# File automatically generated by "cdfg2hdl".
# Filename: gmp_fibo
# Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

#!/bin/bash

vsim -c -do "gmp_fibo.do"
if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
exit 0

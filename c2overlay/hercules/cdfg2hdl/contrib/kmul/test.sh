#!/bin/bash

# Test unsigned and signed multiplications
for mulu in "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "23" "37" "43" "111" "255"
do
  ./kmul.exe -mul ${mulu} -width 32 -unsigned -nac
  ./kmul.exe -mul ${mulu} -width 32 -unsigned -ansic
done
for muls in "-255" "-111" "-43" "-3" "-2" "-1" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "23" "37" "43" "111" "255"
do
  ./kmul.exe -mul -${muls} -width 32 -signed -nac
  ./kmul.exe -mul -${muls} -width 32 -signed -ansic
done

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
exit 0

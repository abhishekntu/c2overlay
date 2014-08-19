#!/bin/sh

# Test signed divisions for d = [1,11] and signed divisions 
# for d = [-11,-1] U [1,11]
for divu in "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "15" "23" "31" "49" "57" "63" "111" "127" "255" "351" "641" "734" "1000" "345345"
do
  ./kdiv.exe -div ${divu} -width 32 -unsigned -nac -d -errors
  ./kdiv.exe -div ${divu} -width 32 -unsigned -ansic
done
for divs in "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "15" "23" "31" "49" "57" "63" "111" "127" "255" "351" "641" "734" "1000" "345345"
do
  ./kdiv.exe -div -${divs} -width 32 -signed -nac -d -errors
  ./kdiv.exe -div -${divs} -width 32 -signed -ansic
  ./kdiv.exe -div ${divs} -width 32 -signed -nac -d -errors
  ./kdiv.exe -div ${divs} -width 32 -signed -ansic
done

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
exit 0

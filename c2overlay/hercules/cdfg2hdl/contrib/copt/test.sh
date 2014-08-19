#!/bin/sh

OS=cygwin
#OS=win32

./fixasm <$1.s > $1_fix.s
./copt <$1_fix.s $2 >$1_fix.peep.s

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running $SECONDS $units."

echo "Ran all tests."
exit 0

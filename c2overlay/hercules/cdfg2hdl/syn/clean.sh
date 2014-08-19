#!/bin/sh

rm -rf *.ngc *.xst *.lso *.srp *.work *.prj xst _xmsgs

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running $SECONDS $units."

echo "Cleaned all XST-generated files."
exit 0

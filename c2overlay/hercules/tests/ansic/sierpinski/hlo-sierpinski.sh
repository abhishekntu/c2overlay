#!/bin/bash

echo "### SOURCE LEVEL OPTIMIZER RUN: STARTED ###"
export HLSTOP="c:/hercules"
export HLSTOP_WIN="c:/hercules"
export HLOTOP="c:/hercules/hlo"
TXL_PATH="/usr/local/bin/"

app="sierpinski"

P_UNROLLFACTOR=8
P_TILESIZE=8
P_VECTSIZE=8

infile=$1
outfile=$2

cp -f $infile temp.1

cp -f temp.2 $2
rm -rf temp.1 temp.2

echo "### SOURCE LEVEL OPTIMIZER RUN: ENDED ###"
exit 0

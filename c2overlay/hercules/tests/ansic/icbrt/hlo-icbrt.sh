#!/bin/bash

echo "### SOURCE LEVEL OPTIMIZER RUN: STARTED ###"
export HLSTOP="c:/hercules"
export HLSTOP_WIN="c:/hercules"
export HLOTOP="c:/hercules/hlo"
TXL_PATH="/usr/local/bin/"

app="icbrt"

P_UNROLLFACTOR=8
P_TILESIZE=8
P_VECTSIZE=8

infile=$1
outfile=$2

cp -f $infile temp.1

echo "canon"
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "splitlocaldecls"
${HLOTOP}/bin/transform.sh splitlocaldecls temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "carrayflatten"
${HLOTOP}/bin/carrayflatten.sh temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "ckmulopt"
${HLOTOP}/bin/ckmulopt.sh temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "ckdivopt"
${HLOTOP}/bin/ckdivopt.sh temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "lowlevelopt"
${HLOTOP}/bin/transform.sh lowlevelopt temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "loopnormalization"
${HLOTOP}/bin/transform.sh loopnormalization temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "loopcoalescing"
${HLOTOP}/bin/transform.sh loopcoalescing temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "csvect"
${HLOTOP}/bin/csvect.sh 8 temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "clooppartialunrolling"
${HLOTOP}/bin/clooppartialunrolling.sh 8 temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "csdevect"
${HLOTOP}/bin/csdevect.sh 8 temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "canon"
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "splitlocaldecls"
${HLOTOP}/bin/transform.sh splitlocaldecls temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "carrayflatten"
${HLOTOP}/bin/carrayflatten.sh temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "ckmulopt"
${HLOTOP}/bin/ckmulopt.sh temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "ckdivopt"
${HLOTOP}/bin/ckdivopt.sh temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "lowlevelopt"
${HLOTOP}/bin/transform.sh lowlevelopt temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "loopnormalization"
${HLOTOP}/bin/transform.sh loopnormalization temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "loopcoalescing"
${HLOTOP}/bin/transform.sh loopcoalescing temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "csvect"
${HLOTOP}/bin/csvect.sh 8 temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "clooppartialunrolling"
${HLOTOP}/bin/clooppartialunrolling.sh 8 temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
echo "csdevect"
${HLOTOP}/bin/csdevect.sh 8 temp.1 temp.2
cp -f temp.2 temp.1
${HLOTOP}/bin/transform.sh canon temp.1 temp.2
cp -f temp.2 temp.1
cp -f temp.2 $2
rm -rf temp.1 temp.2

echo "### SOURCE LEVEL OPTIMIZER RUN: ENDED ###"
exit 0

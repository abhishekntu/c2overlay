#!/bin/bash

CDFG2HDL_PATH="${HLSTOP}/cdfg2hdl"
KMUL_PATH="${CDFG2HDL_PATH}/contrib/kmul"
KDIV_PATH="${CDFG2HDL_PATH}/contrib/kdiv"

#txlopts="-q -raw -idchars '$'"
txlopts="-q -raw"

# Parse input script arguments.
nacfile=$1

# Split localvar declarations in NAC file.
cp -f ${nacfile} ${nacfile}.0
${CDFG2HDL_PATH}/contrib/txl/nacsplitlocaldecls.exe ${nacfile} ${txlopts} > ${nacfile}.1
# Remove redundant/unused declarations in NAC file.
${CDFG2HDL_PATH}/contrib/txl/nacredundant.exe ${nacfile}.1 ${txlopts} > ${nacfile}.2
# Localize declarations in NAC file.
${CDFG2HDL_PATH}/contrib/txl/nactolocal.exe ${nacfile}.2 ${txlopts} > ${nacfile}.3
cp -f ${nacfile}.3 ${nacfile}
rm -rf ${nacfile}.1 ${nacfile}.2 ${nacfile}.3
# Transform NAC file with constant multiplications/divisions.
${CDFG2HDL_PATH}/contrib/txl/nackmuldivopt.exe ${nacfile} ${txlopts} > ${nacfile}.4
cp -f ${nacfile}.4 ${nacfile}
rm -rf ${nacfile}.4

# About the generated kmul.txt file.
kmulfile="kmul.txt"
kdivfile="kdiv.txt"
sep="_"

# Fix kmul.txt, kdiv.txt
# 1. Remove calls to kmul_, kdiv_ routines with power-of-2 integers.
if [ -e "$kmulfile" ]
then
  ${CDFG2HDL_PATH}/contrib/copt/copt.exe <${kmulfile} ${CDFG2HDL_PATH}/contrib/copt/txtkmuldivfix >${kmulfile}.1
  gawk -f ${CDFG2HDL_PATH}/contrib/awk/remblanklines.awk ${kmulfile}.1 >${kmulfile}.2
  cp -f ${kmulfile}.2 ${kmulfile}
  rm -rf ${kmulfile}.1 ${kmulfile}.2
fi
if [ -e "$kdivfile" ]
then
  ${CDFG2HDL_PATH}/contrib/copt/copt.exe <${kdivfile} ${CDFG2HDL_PATH}/contrib/copt/txtkmuldivfix >${kdivfile}.1
  gawk -f ${CDFG2HDL_PATH}/contrib/awk/remblanklines.awk ${kdivfile}.1 >${kdivfile}.2
  cp -f ${kdivfile}.2 ${kdivfile}
  rm -rf ${kdivfile}.1 ${kdivfile}.2
fi 

# Continue with the constant multiplication optimization.
if [ -e "$kmulfile" ]
then
  # Remove duplicate lines from "kmul.txt"
  gawk -f ${CDFG2HDL_PATH}/contrib/awk/remdupllines.awk ${kmulfile} >${kmulfile}.3
  cp -f ${kmulfile}.3 ${kmulfile}
  rm -rf ${kmulfile}.3
  # Read "kmul.txt" line-by-line (entry-by-entry)
  while read -r line; 
  do 
    echo "KMUL: $line"; 
    set - $(IFS=$sep; echo $line)
    prefix=$1
    datatype=$2
    sign=${datatype:0:1}
    bitwidth=${datatype:1}
    posneg=$3
    absnum=$4
    if [ "$sign" = "u" ]
    then
      optsign="-unsigned"
    else
      optsign="-signed"
    fi
    if [ "$posneg" = "m" ]
    then
      num="-${absnum}"
    else
      num="${absnum}"
    fi
    # Call kmul.exe with the proper command-line options for generating 
    # "kmul_[u|s]<num>_[p|m]_<num>.nac".
    ${KMUL_PATH}/kmul -mul ${num} -width ${bitwidth} ${optsign} -nac
    # Remove redundant declarations from the generated nac file.
    ${CDFG2HDL_PATH}/contrib/txl/nacredundant.exe kmul_${datatype}_${posneg}_${absnum}.nac ${txlopts} > kmul_${datatype}_${posneg}_${absnum}.1.nac
    cp -f kmul_${datatype}_${posneg}_${absnum}.1.nac kmul_${datatype}_${posneg}_${absnum}.nac
    rm -rf kmul_${datatype}_${posneg}_${absnum}.1.nac
    # Concatenate the kmul*.nac files with ${nacfile}
    cat ${nacfile} kmul_${datatype}_${posneg}_${absnum}.nac > ${nacfile}.5
    cp -f ${nacfile}.5 ${nacfile}
    rm -rf ${nacfile}.5
    ###
  done < ${kmulfile}
fi

# Continue with the constant division optimization.
if [ -e "$kdivfile" ]
then
  # Remove duplicate lines from "kdiv.txt"
  gawk -f ${CDFG2HDL_PATH}/contrib/awk/remdupllines.awk ${kdivfile} >${kdivfile}.3
  cp -f ${kdivfile}.3 ${kdivfile}
  rm -rf ${kdivfile}.3
  # Read "kdiv.txt" line-by-line (entry-by-entry)
  while read -r line; 
  do 
    echo "KDIV: $line"; 
    set - $(IFS=$sep; echo $line)
    prefix=$1
    datatype=$2
    sign=${datatype:0:1}
    bitwidth=${datatype:1}
    posneg=$3
    absnum=$4
    if [ "$sign" = "u" ]
    then
      optsign="-unsigned"
    else
      optsign="-signed"
    fi
    if [ "$posneg" = "m" ]
    then
      num="-${absnum}"
    else
      num="${absnum}"
    fi
    # Call kdiv.exe with the proper command-line options for generating 
    # "kdiv_[u|s]<num>_[p|m]_<num>.nac".
    ${KDIV_PATH}/kdiv -div ${num} -width ${bitwidth} ${optsign} -nac
    # Remove redundant declarations from the generated nac file.
    ${CDFG2HDL_PATH}/contrib/txl/nacredundant.exe kdiv_${datatype}_${posneg}_${absnum}.nac ${txlopts} > kdiv_${datatype}_${posneg}_${absnum}.1.nac
    cp -f kdiv_${datatype}_${posneg}_${absnum}.1.nac kdiv_${datatype}_${posneg}_${absnum}.nac
    rm -rf kdiv_${datatype}_${posneg}_${absnum}.1.nac
    # Concatenate the kdiv*.nac files with ${nacfile}
    cat ${nacfile} kdiv_${datatype}_${posneg}_${absnum}.nac > ${nacfile}.6
    cp -f ${nacfile}.6 ${nacfile}
    rm -rf ${nacfile}.6
    ###
  done < ${kdivfile}
fi

# Globalize declarations in NAC file.
${CDFG2HDL_PATH}/contrib/txl/nactoglobal.exe ${nacfile} ${txlopts} > ${nacfile}.7
cp -f ${nacfile}.7 ${nacfile}
rm -rf ${nacfile}.7

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running $SECONDS $units."
exit 0

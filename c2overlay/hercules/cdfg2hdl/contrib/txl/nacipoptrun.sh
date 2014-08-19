#!/bin/bash

CDFG2HDL_PATH="${HLSTOP}/cdfg2hdl"

txlopts="-q -raw"
nacfile=$1
# Split localvar declarations in NAC file.
${CDFG2HDL_PATH}/contrib/txl/nacsplitlocaldecls.exe ${txlopts} ${nacfile} > ${nacfile}.11
# Remove redundant/unused declarations in NAC file.
${CDFG2HDL_PATH}/contrib/txl/nacredundant.exe ${txlopts} ${nacfile}.11 > ${nacfile}.12
# Localize declarations in NAC file.
#${CDFG2HDL_PATH}/contrib/txl/nactolocal.exe ${txlopts} ${nacfile}.12 > ${nacfile}.13
${CDFG2HDL_PATH}/contrib/txl/nactolocalepilogue.exe ${txlopts} ${nacfile}.12 > ${nacfile}.13
cp -f ${nacfile}.13 ${nacfile}
rm -rf ${nacfile}.11 ${nacfile}.12 ${nacfile}.13
# Transform NAC file so that it includes builtin IPs.
# 1. divs, divu
# 2. rems, remu
# 3. mods, modu
# 4. addf, addd
# 5. mulf, muld
# 6. expf, expd
# 7. divf, divd
# 8. dblf, dbld
# 9. sqrf, sqrd
#10. sqrtf, sqrtd
${CDFG2HDL_PATH}/contrib/txl/nacipopt.exe ${txlopts} ${nacfile} > ${nacfile}.14
cp -f ${nacfile}.14 ${nacfile}
rm -rf ${nacfile}.14
# Globalize declarations in NAC file.
${CDFG2HDL_PATH}/contrib/txl/nactoglobal.exe ${txlopts} ${nacfile} > ${nacfile}.15
cp -f ${nacfile}.15 ${nacfile}
rm -rf ${nacfile}.15

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running $SECONDS $units."
exit 0

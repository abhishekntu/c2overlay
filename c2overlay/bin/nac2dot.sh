#!/bin/bash
echo "---------------------------"
echo "### NAC to DOT: STARTED ###"
export HLSTOP="../hercules"
export HLSTOP_WIN="../hercules"
export CDFG2HDL_PATH="../hercules/cdfg2hdl"
CFRONTEND_PATH="../hercules/gimple2nac"
TXL_PATH="/usr/local/bin/"
HLO_PATH="../hercules/hlo"
GCC_PATH="/usr/local/bin/gcc-4.7.0-install/bin"

app=$1

${CDFG2HDL_PATH}/src/nac2cdfg.exe  -force-data-types -ssa -emit-nac -emit-cfg -emit-cg ${app}.nac
uniq <builtin_names.txt >& builtin_names.txt.1
cp -f builtin_names.txt.1 builtin_names.txt
rm -rf builtin_names.txt.1
cp -f builtin_names.txt builtin_names.txt.bak
dot -Tpng -O ${app}_cg.dot
procfile="procedure_names.txt"
while read -r app2;
do
  cp -f ${app2}.dot ${app2}.orig.dot
  #${CDFG2HDL_PATH}/src/cdfg2hdl.exe  -vhd2vl -mpint -sched-naive -ieee -ghdl ${app2}.dot
  dot -Tpng -O ${app2}.orig.dot
  dot -Tpng -O ${app2}_cfg.dot
  mv ${app2}.orig.dot ${app2}.orig.txt
  rm -rf *.dot
  mv ${app2}.orig.txt test.dot
done < ${procfile}
rm -rf *.vhd *.png *.txt *.bak
#chmod 777 -R ${app}.sh
#./${app}.sh
#cp -f ${app}_alg_test_results.txt ${app}_alg_test_results.txt.rsim
#mv ${app}.orig.dot ${app}.orig.txt
#rm -rf *.dot
#mv ${app}.orig.txt ${app}.orig.dot
echo "### NAC to DOT: ENDED ###"
echo "---------------------------"
#exit 0


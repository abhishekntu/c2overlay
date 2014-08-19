#!/bin/bash

echo "### C to NAC: STARTED ###"
export HLSTOP="../hercules"
export HLSTOP_WIN="../hercules"
export CDFG2HDL_PATH="../hercules/cdfg2hdl"
CFRONTEND_PATH="../hercules/gimple2nac"
TXL_PATH="/usr/local/bin/"
HLO_PATH="../hercules/hlo"
GCC_PATH="/usr/local/bin/gcc-4.7.0-install/bin"

app=$1

#gcc -DALGO -DTEST -O2 -o ${app}.exe ${app}.c 
#./${app}.exe >& ${app}_test_data.txt

gcc -DALGO -O2 -fdump-tree-gimple-raw -c ${app}.c
mv -f ${app}.c.004t.gimple ${app}.gimple
${CFRONTEND_PATH}/gimple2nac.exe -q ${app}.gimple
rm -rf ${app}.gimple
mv -f ${app}.gimple.nac ${app}.nac

${CDFG2HDL_PATH}/contrib/ansic/fixncopy.exe -noprecspaces -notabs <${app}.nac >${app}.11.nac
${CDFG2HDL_PATH}/contrib/copt/copt.exe <${app}.11.nac ${CDFG2HDL_PATH}/contrib/copt/nacdeadcodeelim >${app}.12.nac
${CDFG2HDL_PATH}/contrib/copt/copt.exe <${app}.12.nac ${CDFG2HDL_PATH}/contrib/copt/nacloadstoreopt >${app}.13.nac
${CDFG2HDL_PATH}/contrib/copt/copt.exe <${app}.13.nac ${CDFG2HDL_PATH}/contrib/copt/nacloadstoredeadelim >${app}.14.nac
cp -f ${app}.14.nac ${app}.nac
rm -rf ${app}.11.nac ${app}.12.nac ${app}.13.nac ${app}.14.nac

cp -f ${app}.nac ${app}.20.nac
${CDFG2HDL_PATH}/contrib/ansic/nactksep.exe < ${app}.20.nac > ${app}.21.nac
gawk -f ${CDFG2HDL_PATH}/contrib/awk/remblanklines.awk ${app}.21.nac > ${app}.22.nac
gawk -f ${CDFG2HDL_PATH}/contrib/awk/nacpeepjmpcc.awk ${app}.22.nac > ${app}.23.nac
gawk -f ${CDFG2HDL_PATH}/contrib/awk/nacpeepjmpun.awk ${app}.23.nac > ${app}.24.nac
cp -f ${app}.24.nac ${app}.nac
rm -rf ${app}.20.nac ${app}.21.nac ${app}.22.nac ${app}.23.nac ${app}.24.nac

cp -f ${app}.nac ${app}.pp.nac
${CDFG2HDL_PATH}/contrib/txl/nacparser.exe -q -raw ${app}.pp.nac >& ${app}.nac
rm -rf ${app}.pp.nac ${app}.o
#${CDFG2HDL_PATH}/src/nac2cdfg.exe  -force-data-types -ssa -emit-nac -emit-cfg -emit-cg ${app}.nac
#uniq <builtin_names.txt >& builtin_names.txt.1
#cp -f builtin_names.txt.1 builtin_names.txt
#rm -rf builtin_names.txt.1
#cp -f builtin_names.txt builtin_names.txt.bak
#dot -Tpng -O ${app}_cg.dot
#procfile="procedure_names.txt"
#while read -r app2;
#do
#  cp -f ${app2}.dot ${app2}.orig.dot
#  #${CDFG2HDL_PATH}/src/cdfg2hdl.exe  -vhd2vl -mpint -sched-naive -ieee -ghdl ${app2}.dot
#  dot -Tpng -O ${app2}.orig.dot
#  dot -Tpng -O ${app2}_cfg.dot
#  mv ${app2}.orig.dot ${app2}.orig.txt
#  rm -rf *.dot
#  mv ${app2}.orig.txt test.dot
#done < ${procfile}

#chmod 777 -R ${app}.sh
#./${app}.sh
#cp -f ${app}_alg_test_results.txt ${app}_alg_test_results.txt.rsim
#mv ${app}.orig.dot ${app}.orig.txt
#rm -rf *.dot
#mv ${app}.orig.txt ${app}.orig.dot
echo "### C to NAC: ENDED ###"
#exit 0


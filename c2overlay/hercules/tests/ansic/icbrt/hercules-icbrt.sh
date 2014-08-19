#!/bin/bash

echo "### HERCULES RUN: STARTED ###"
export HLSTOP="c:/hercules"
export HLSTOP_WIN="c:/hercules"
export CDFG2HDL_PATH="c:/hercules/cdfg2hdl"
CFRONTEND_PATH="c:/hercules/gimple2nac"
TXL_PATH="/usr/local/bin/"
HLO_PATH="c:/hercules/hlo"
GCC_PATH="/usr/local/bin/gcc-4.7.0-install/bin"

app="icbrt"

echo "Optimizing ${app} to ${app}.opt"
gcc -DALGO -E -P ${app}.c > ${app}-ref.c
./hlo-${app}.sh ${app}-ref.c ${app}.opt.c

gcc -DALGO -DTEST -O2 -o ${app}.exe ${app}.c 
./${app}.exe >& ${app}_test_data.txt

gcc -DALGO -O2 -fdump-tree-gimple-raw -c ${app}.opt.c
cp -f ${app}.opt.c.004t.gimple ${app}.gimple
${CFRONTEND_PATH}/gimple2nac -q ${app}.gimple
cp -f ${app}.gimple.nac ${app}.nac

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

rm -rf ram.vhd
cp -f ${app}.nac ${app}.pp.nac
${CDFG2HDL_PATH}/contrib/txl/nacparser.exe -q -raw ${app}.pp.nac >& ${app}.nac
${CDFG2HDL_PATH}/src/nac2cdfg.exe  -force-data-types -ssa -pseudo-ssa -unique-ssavars -emit-nac -emit-ansic -emit-cfg -emit-cg ${app}.nac
uniq <builtin_names.txt >& builtin_names.txt.1
cp -f builtin_names.txt.1 builtin_names.txt
rm -rf builtin_names.txt.1
cp -f builtin_names.txt builtin_names.txt.bak
dot -Tpng -O ${app}_cg.dot
procfile="procedure_names.txt"
while read -r app2;
do
  cp -f ${app2}.dot ${app2}.orig.dot
  ${CDFG2HDL_PATH}/src/cdfg2hdl.exe  -vhd2vl -mpint -sched-asap -ieee -mti ${app2}.dot
  dot -Tpng -O ${app2}.orig.dot
  dot -Tpng -O ${app2}_cfg.dot
  cp -f ${app2}.vhd ${app2}.vhd.0
  ${CDFG2HDL_PATH}/contrib/ansic/fixncopy.exe -notabs <${app2}.vhd.0 >${app2}.vhd.1
  ${CDFG2HDL_PATH}/contrib/copt/copt.exe <${app2}.vhd.1 ${CDFG2HDL_PATH}/contrib/copt/vhdlmergestates >${app2}.vhd.2
  ${CDFG2HDL_PATH}/contrib/ansic/vhdlchainify.exe <${app2}.vhd.2 >${app2}.vhd.3
  cp -f ${app2}.vhd.3 ${app2}.vhd
  rm -rf ${app2}.vhd.0 ${app2}.vhd.1 ${app2}.vhd.2 ${app2}.vhd.3
done < ${procfile}

make -if ansic.mk clean
make -if ansic.mk
echo "Running main() for benchmark ${app}"
./main.exe >& ${app}_alg_test_results.txt.csim

chmod 777 -R ${app}.sh
./${app}.sh
cp -f ${app}_alg_test_results.txt ${app}_alg_test_results.txt.rsim

export XDIR="c:/XilinxISE/14.6/ISE_DS/ISE"
export ARCH="virtex6"
export PART="xc6vlx75t-ff484-1"
chmod 777 -R ${app}-syn.sh
./${app}-syn.sh

echo "### HERCULES RUN: ENDED ###"
exit 0

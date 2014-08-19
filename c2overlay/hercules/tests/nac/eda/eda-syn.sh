# File automatically generated by "cdfg2hdl".
# Filename: eda
# Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

#!/bin/bash

make -if ${CDFG2HDL_PATH}/syn/xst.mk clean
make -if ${CDFG2HDL_PATH}/syn/xst.mk PROJECT=eda SOURCES="${CDFG2HDL_PATH}/contrib/vhdl/std_logic_1164_tinyadditions.vhd ${CDFG2HDL_PATH}/contrib/vhdl/operpack_ieee.vhd eda_cdt_pkg.vhd eda.vhd" TOPDIR="../eda" TOP=eda eda.ngc
if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "The XST synthesis script has been running for $SECONDS $units."
exit 0

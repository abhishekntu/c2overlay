# File automatically generated by "cdfg2hdl".
# Filename: fir
# Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

vlib work
vcom $env(HLSTOP_WIN)/cdfg2hdl/contrib/vhdl/std_logic_1164_tinyadditions.vhd
vcom $env(HLSTOP_WIN)/cdfg2hdl/contrib/vhdl/std_logic_textio.vhd
vcom $env(HLSTOP_WIN)/cdfg2hdl/contrib/vhdl/operpack_ieee.vhd
vcom fir_cdt_pkg.vhd
vcom fir.vhd
vcom fir_tb.vhd
vsim fir_tb
onbreak {quit -f}
run -all
exit -f
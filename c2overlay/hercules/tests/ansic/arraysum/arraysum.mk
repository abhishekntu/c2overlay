# File automatically generated by "cdfg2hdl".
# Filename: arraysum
# Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

GHDL=ghdl
GHDLFLAGS=--ieee=standard -fexplicit --workdir=work
GHDLRUNFLAGS=--stop-time=2147483647ns

all : run

elab : force
	$(GHDL) -c $(GHDLFLAGS) -e arraysum_tb

run : force
	./arraysum.ghdl $(GHDLRUNFLAGS)

init : force
	mkdir work
	$(GHDL) -i $(GHDLFLAGS) ../../../cdfg2hdl/contrib/vhdl/std_logic_1164_tinyadditions.vhd
	$(GHDL) -i $(GHDLFLAGS) ../../../cdfg2hdl/contrib/vhdl/std_logic_textio.vhd
	$(GHDL) -i $(GHDLFLAGS) ../../../cdfg2hdl/contrib/vhdl/operpack_ieee.vhd
	$(GHDL) -i $(GHDLFLAGS) arraysum_cdt_pkg.vhd
	$(GHDL) -i $(GHDLFLAGS) arraysum.vhd
	$(GHDL) -i $(GHDLFLAGS) arraysum_tb.vhd
	$(GHDL) -m $(GHDLFLAGS) -o arraysum.ghdl arraysum_tb
force : 

clean :
	rm -rf *.o *.ghdl work
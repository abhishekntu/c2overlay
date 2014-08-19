# usage to compile mydir/mydir.v: make D=mydir flash

# flow directory
FLOW?=.

# directory for project files
DIR?=test

# prefix for file names
P?=$(DIR)/$(DIR)

# configuration variables
TRACKS?=2
ROWS?=2
COLS?=2
#PADVERSION?=clk

# file path configuration
BIN?=$(FLOW)/bin
#SCRIPTS?=$(FLOW)/scripts
#ARCH?=$(FLOW)/vpr5-k6-n4.template.xml
#PADS?=$(FLOW)/pads/pads-$(COLS)x$(ROWS)-$(PADVERSION).txt

# binary paths
#ODIN=$(BIN)/odin_ii
#ABC=$(BIN)/abc-vtr
#VPACK=$(BIN)/t-vpack
VPR=$(BIN)/vpr5
CFRONTEND_PATH="../hercules/gimple2nac"
CDFG2HDL_PATH="../hercules/cdfg2hdl"

.PHONY: clean flash verilog view netlist pdg dot nac clear par

.SECONDARY:

all: 
	python $(BIN)/c2nac.py
	python $(BIN)/nac2dot.py
	python $(BIN)/dot2pdg.py test
	mv test.dot test_dfg.dot        #test_dfg.dot is original dot generated from nac2cdfg.exe
	cp test_new.dot test_pdg.dot    #test_pdg.dot is the processed dot file generated from dot2pdg.py
	mv test_new.dot test.dot        #test.dot is the processed dot file which will be used to generate netlist using pdg2netlist.py
	python $(BIN)/pdg2netlist.py test
	$(VPR) $(P).net $(P).arch.xml $(P).place.out $(P).route.out -nodisp -timing_analysis off -route_chan_width $(TRACKS)
nac:
	python $(BIN)/c2nac.py

dot: 
	python $(BIN)/nac2dot.py

pdg: 
	python $(BIN)/dot2pdg.py test
	mv test.dot test_dfg.dot   	#test_dfg.dot is original dot generated from nac2cdfg.exe
	cp test_new.dot test_pdg.dot	#test_pdg.dot is the processed dot file generated from dot2pdg.py
	mv test_new.dot test.dot	#test.dot is the processed dot file which will be used to generate netlist using pdg2netlist.py

netlist:
	python $(BIN)/pdg2netlist.py test

clean:
	rm -f gc.txt *.echo $(DIR)/abc.cmd $(P).*.log $(P).*.blif $(P).*.out $(P).done $(P).bit $(P).uart-tb.v *.png  

clear:
	rm -rf *.png *.o *.txt *.gimple *.bak *.vhd *.exe *.nac *.dot *.net

#$(P).odin.blif: $(P).v
#	$(ODIN) -V $< -o $(P).odin.blif 2> $(P).odin.log > $(P).odin.log

#$(P).abc.blif: $(P).odin.blif
#	printf "read $<\nif -K 6\nsweep\nwrite_hie $< $@" > $(DIR)/abc.cmd
#	$(ABC) -f $(DIR)/abc.cmd  > $(P).abc.log

#$(P).awk.blif: $(P).abc.blif
#	cat $< | awk '{ if ($$1 == ".latch"){ print $$1, $$2, $$3, "re", "top^clk", $$4 } else { print $$0 } }' > $@

#$(P).net: $(P).awk.blif
#	$(VPACK) $< $@ -inputs_per_cluster 16 -cluster_size 4 -lut_size 6 > $(P).vpack.log

#$(P).arch.xml: $(ARCH)
#	sed 's/#ROWS#/$(ROWS)/g' $< | sed 's/#COLS#/$(COLS)/g' > $@

par: 
	$(VPR) $(P).net $(P).arch.xml $(P).place.out $(P).route.out -nodisp -timing_analysis off -route_chan_width $(TRACKS) 
#> $(P).vpr.log
#-fix_pins $(PADS) -timing_analysis off
#-route_chan_width $(TRACKS) > $(P).vpr.log
#	@test -e $(P).route.out

view: $(P).net $(P).arch.xml
	$(VPR) $(P).net $(P).arch.xml $(P).place.out $(P).route.out -timing_analysis off -route_chan_width $(TRACKS)
#-fix_pins $(PADS) -route_chan_width $(TRACKS) > $(P).vpr.log

#$(P).done: $(P).route.out
#	$(SCRIPTS)/fpga.py $(P).place.out $(P).route.out $(P).net $(P).abc.blif $(TRACKS) > $(P).bit
#	touch $@

#verilog: $(P).done
#	$(SCRIPTS)/program_bitstream.py --file $(P).bit --dry --sim $(P).uart-tb.v

#flash: $(P).done
#	$(SCRIPTS)/program_bitstream.py --file $(P).bit


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
CGRACOMPILER=$(BIN)/cgracompiler
CFRONTEND_PATH="../hercules/gimple2nac"
CDFG2HDL_PATH="../hercules/cdfg2hdl"

.PHONY: clean flash verilog view netlist pdg dot asm nac clear par config show run

.SECONDARY:

all: 
	python $(BIN)/c2nac.py
	python $(BIN)/nac2dot.py
	python $(BIN)/dot2pdg.py test > $(P).bench.log
	mv test.dot test_dfg.dot        #test_dfg.dot is original dot generated from nac2cdfg.exe
	cp test_new.dot test_pdg.dot    #test_pdg.dot is the processed dot file generated from dot2pdg.py
	mv test_new.dot test.dot        #test.dot is the processed dot file which will be used to generate netlist using pdg2netlist.py
	python $(BIN)/pdg2netlist.py test >> $(P).bench.log
	$(VPR) $(P).net $(P).arch.xml $(P).place.out $(P).route.out -auto 2 -place_cost_type linear -router_algorithm directed_search -bb_factor 3 -max_router_iterations 50 -initial_pres_fac 0.5 -timing_analysis off -route_chan_width $(TRACKS) > $(P).vpr.log
	python $(BIN)/par2config.py >> $(P).bench.log
nac:
	python $(BIN)/c2nac.py

dot: 
	python $(BIN)/nac2dot.py

pdg: 
	python $(BIN)/dot2pdg.py test
	mv test.dot test_dfg.dot   	#test_dfg.dot is original dot generated from nac2cdfg.exe
	cp test_new.dot test_pdg.dot	#test_pdg.dot is the processed dot file generated from dot2pdg.py
	mv test_new.dot test.dot	#test.dot is the processed dot file which will be used to generate netlist using pdg2netlist.py

asm:
	python $(BIN)/pdg2asm.py test

run:
	mv test.s config/test.s
	mv test.txt config/test.txt
	$(CGRACOMPILER)
	cat result/trace.txt

netlist:
	python $(BIN)/pdg2netlist.py test

config: 
	python $(BIN)/par2config.py

clean:
	rm -f gc.txt *.echo $(DIR)/abc.cmd $(P).*.log $(P).*.blif $(P).*.out $(P).done $(P).bit $(P).uart-tb.v *.png  

clear:
	rm -rf *.png *.o *.txt *.gimple *.bak *.vhd *.exe *.nac *.dot *.net *.ps *.pdf

show:  
	xdot test_dfg.dot &
	xdot test_pdg.dot &

#$(P).arch.xml: $(ARCH)
#	sed 's/#ROWS#/$(ROWS)/g' $< | sed 's/#COLS#/$(COLS)/g' > $@

par: 
	$(VPR) $(P).net $(P).arch.xml $(P).place.out $(P).route.out -nodisp -timing_analysis off -route_chan_width $(TRACKS) > $(P).vpr.log
#-router_algorithm breadth_first  > $(P).vpr.log
#-fix_pins $(PADS) -timing_analysis off
#-route_chan_width $(TRACKS) > $(P).vpr.log
#	@test -e $(P).route.out

view: $(P).net $(P).arch.xml
	$(VPR) $(P).net $(P).arch.xml $(P).place.out $(P).route.out -timing_analysis off -route_chan_width $(TRACKS) > $(P).vpr.log
#-fix_pins $(PADS) -route_chan_width $(TRACKS) > $(P).vpr.log

#$(P).done: $(P).route.out
#	$(SCRIPTS)/fpga.py $(P).place.out $(P).route.out $(P).net $(P).abc.blif $(TRACKS) > $(P).bit
#	touch $@

#verilog: $(P).done
#	$(SCRIPTS)/program_bitstream.py --file $(P).bit --dry --sim $(P).uart-tb.v

#flash: $(P).done
#	$(SCRIPTS)/program_bitstream.py --file $(P).bit


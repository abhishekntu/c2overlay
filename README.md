c2overlay
=========

This project presents a new design methodology to implement c functions on overlay architectures. 

It is a modular tool flow which uses HercuLeS HLS tool for C to DFG conversion and VPR for PAR.


Description of c2overlay v1.0, SCE, NTU
=======================================

Any questions, contact:

Abhishek Jain, abhishek013@ntu.edu.sg

Input: C file

Output: NAC, DOT, PDG, NETLIST and PAR files

Folders Structure:

1. bin/ 		-- Executable and Source files  
2. hercules/ 		-- HercuLeS HLS Tool for C to DOT conversion
3. test/ 		-- Test folder containing:

	3.1 benchmarks/ 	-- C benchmarks from Polybench Suite

	3.2 config/ 		-- Configuration folder for SCGRA scheduler

	3.3 result/ 		-- Resulting schedule from SCGRA scheduler

	3.4 Makefile		-- Makefile to change channel width

	3.5 test.arch.xml	-- Overlay architecture description in xml format 	

	3.5 test.c		-- test input file

4. Makefile		-- Makefile for complete tool flow


Design flow
===========

1. Go to test folder.
2. Copy a benchmark file from "benchmarks/c/XX.c" to "test.c" 	-- cp benchmarks/c/XX.x test.c 
   Where XX is the benchmark name
3. Generate NAC file					 	-- make nac
4. Generate DOT file						-- make dot
5. Generate PDG file						-- make pdg
6. Generate NETLIST file					-- make netlist
7. Generate PAR files						-- make PAR
8. View PAR output						-- make view
9. Generate ASM file for SCGRA scheduler			-- make asm
10. Run the SCGRA scheduler					-- make run
11. Clean HLS files						-- make clear
12. Clean PAR files						-- make clean


Overlay Architecture description 
================================

Described in xml format as test.arch.xml. 

We can change channel width and size of the overlay in the current version.

I/O count and locations are fixed for a logic block in the current version.

Logic block does have 1 input and 1 output pin in each direction.

Channel width can be changed in test/Makefile.

Size of the overlay can be changed in test/test.arch.xml.


TO DO 
=====

1. DSP Block based node-merging. Currently, tool is mapping one compute node of the DFG to one logic block and hence requiring comparatively large size overlay.
2. A pass for configuration generation after analyzing PAR files. 
3. Trace of Inputs arrival time at each node. Another pass to generate configuration of configurable registers and to analyze latency imbalance.
4. RTL of the overlay with reordering logic and latency balancing logic
5. Find out Area-time product of HLS, SCGRA and c2overlay implementations of benchmarks, compare and analyze.
  
   	 
	


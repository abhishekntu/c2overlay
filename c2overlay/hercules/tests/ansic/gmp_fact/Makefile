#
# Makefile for Free MP
#
#HLSTOP=/cygdrive/g/hercules
ifndef CC
CC = $(CC)
endif
#CC = gcc
CFLAGS=-Wall -O2 -DALGO -DTEST
INCLUDES= -I$(HLSTOP)/cdfg2hdl/contrib/fgmp/
LFLAGS= -L$(HLSTOP)/cdfg2hdl/contrib/fgmp/ -lfgmp
CC = gcc
EXE = .exe 

all: gmp_fact$(EXE)

gmp_fact$(EXE): gmp_fact.o
	$(CC) gmp_fact.o $(HLSTOP)/cdfg2hdl/contrib/fgmp/libfgmp.a $(LFLAGS) -o gmp_fact$(EXE)

gmp_fact.o: gmp_fact.c $(HLSTOP)/cdfg2hdl/contrib/fgmp/fgmp.h
	$(CC) $(CFLAGS) $(INCLUDES) -c gmp_fact.c

clean:
	rm -f gmp_fact$(EXE) *.o core *~

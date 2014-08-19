#
# Makefile for Free MP
#
#HLSTOP=/cygdrive/g/hercules
ifndef CC
CC = $(CC)
endif
#CC = gcc
CFLAGS=-Wall -O2
INCLUDES= -I$(HLSTOP)/cdfg2hdl/contrib/fgmp/
LFLAGS= -L$(HLSTOP)/cdfg2hdl/contrib/fgmp/
CC = gcc
EXE = .exe
#EXE = 

all: libfgmp.a gmp-fact$(EXE) gmp-fact2$(EXE) gmp-fib$(EXE) gmp-prime$(EXE) gmp-tetration$(EXE)

libfgmp.a: fgmp.o
	ar cq libfgmp.a fgmp.o
	ranlib libfgmp.a

gmp-fact$(EXE): gmp-fact.o
	$(CC) gmp-fact.o libfgmp.a $(LFLAGS) -o gmp-fact$(EXE)

gmp-fact2$(EXE): gmp-fact2.o
	$(CC) gmp-fact2.o libfgmp.a $(LFLAGS) -o gmp-fact2$(EXE)

gmp-fib$(EXE): gmp-fib.o
	$(CC) gmp-fib.o libfgmp.a $(LFLAGS) -o gmp-fib$(EXE)

gmp-prime$(EXE): gmp-prime.o
	$(CC) gmp-prime.o libfgmp.a $(LFLAGS) -o gmp-prime$(EXE)

gmp-tetration$(EXE): gmp-tetration.o
	$(CC) gmp-tetration.o libfgmp.a $(LFLAGS) -o gmp-tetration$(EXE)

gmp-fact.o: gmp-fact.c fgmp.h
	$(CC) $(CFLAGS) $(INCLUDES) -c gmp-fact.c

gmp-fact2.o: gmp-fact2.c fgmp.h
	$(CC) $(CFLAGS) $(INCLUDES) -c gmp-fact2.c

gmp-fib.o: gmp-fib.c fgmp.h
	$(CC) $(CFLAGS) $(INCLUDES) -c gmp-fib.c

gmp-prime.o: gmp-prime.c fgmp.h
	$(CC) $(CFLAGS) $(INCLUDES) -c gmp-prime.c

gmp-tetration.o: gmp-tetration.c fgmp.h
	$(CC) $(CFLAGS) $(INCLUDES) -c gmp-tetration.c

clean:
	rm -f gmp-fact$(EXE) gmp-fact2$(EXE) gmp-fib$(EXE) gmp-prime$(EXE) gmp-tetration$(EXE) *.o libfgmp.a core *~

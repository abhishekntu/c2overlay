CC = gcc
CFLAGS = -Wall -Wextra -pedantic -O2
EXE= .exe

all: kmul$(EXE)

kmul$(EXE): kmul.o
	$(CC) kmul.o -o kmul$(EXE)

kmul.o: kmul.c
	$(CC) $(CFLAGS) -c kmul.c

tidy:
	rm -f *.o

clean:
	rm -f *.o kmul$(EXE) kmul_*.nac kmul_u*.c kmul_s*.c


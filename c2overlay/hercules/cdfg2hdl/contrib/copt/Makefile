CC = gcc
CFLAGS = -O2 -Wall
EXE = .exe

all: copt$(EXE) fixasm$(EXE)

copt$(EXE): copt.o
	$(CC) $(CLFLAGS) copt.o -o copt$(EXE)

fixasm$(EXE): fixasm.o
	$(CC) $(CLFLAGS) fixasm.o -o fixasm$(EXE)

copt.o: 
	$(CC) $(CFLAGS) -c copt.c
	
fixasm.o: 
	$(CC) $(CFLAGS) -c fixasm.c
	
tidy:
	rm -f *.o

clean:
	rm -f *.o copt$(EXE) fixasm$(EXE)

# File automatically generated by "nac2cdfg".
# Filename: ansic.mk
# Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012

CC=gcc
CFLAGS=-O2

all : main

main : main.h
	$(CC) $(CFLAGS) -o main main.c popcount_nac.c 
clean :
	rm -rf *.o main main.exe

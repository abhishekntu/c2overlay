#!/bin/sh
echo "---------------------------------------" > bench.log
echo "Results:" >> bench.log
echo "---------------------------------------" >> bench.log
for bench in chebyshev sgfilter mibench qspline poly1 poly2 poly3 poly4 poly5 atax bicg gesummv trmm syrk
do
	#make clear
	#make clean
	echo "Runing" $bench
	cp benchmarks/c/$bench.c test.c
	make > log.txt
	echo $bench >> bench.log
	cat test.bench.log >> bench.log
	#cat bench.log
done

cat bench.log

#!/bin/sh
echo "---------------------------------------" > bench.log
echo "Results:" >> bench.log
echo "---------------------------------------" >> bench.log
for bench in chebyshev sgfilter mibench qspline poly1 poly2 poly3 poly5 atax bicg gesummv trmm syrk
do
	sed -i "s/\(TRACKS=\).*/\1$1/" Makefile
	echo "Runing" $bench
	cp benchmarks/c/$bench.c test.c
	make > log.txt
	echo $bench >> bench.log
	cat test.bench.log >> bench.log
	echo -n "Required Overlay Size:          " >> bench.log
	awk '$1=="The"{print $8 $9 $10}' test.vpr.log >> bench.log 
	echo "---------------------------------------" >> bench.log
	cd outputs
	if [ ! -d "$bench" ]; then 
		mkdir $bench	
	fi
	cd ..	
	mv test.c outputs/$bench/$bench.c
	mv test.nac outputs/$bench/$bench.nac
	mv test_dfg.dot outputs/$bench/"$bench"_dfg.dot
	mv test_pdg.dot outputs/$bench/"$bench"_pdg.dot
	mv test.dot outputs/$bench/"$bench".dot
	mv test.net outputs/$bench/"$bench".net
	mv test.place.out outputs/$bench/"$bench".place.out
	mv test.route.out outputs/$bench/"$bench".route.out
	mv rrgraph.dot outputs/$bench/"$bench"_rrgraph.dot
	mv test.bench.log outputs/$bench/"$bench".bench.log
	mv test.vpr.log outputs/$bench/"$bench".vpr.log
	rm -rf foo_ssa.nac
done

cat bench.log

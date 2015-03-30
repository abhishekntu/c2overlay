#/bin/sh
echo "---------------------------------------" > bench.log
echo "Results:" >> bench.log
echo "---------------------------------------" >> bench.log
#for bench in poly5 poly6 poly7 poly8 fft kmeans stencil conv radar mri spmv HornerBezier MotionVector SmoothTriangle
for bench in chebyshev sgfilter mibench qspline poly1 poly2 poly3 poly4 poly5 poly6 poly7 poly8 fft kmeans stencil radar mri spmv HornerBezier #MotionVector SmoothTriangle
#for bench in atax bicg trmm syrk
#for bench in chebyshev sgfilter mibench qspline poly1 poly2 poly3 #poly4 #poly5 poly6 poly7 poly8 atax bicg gemm gesummv mvt syr2k syrk trmm
#for bench in atax bicg gesummv trmm syrk
#for bench in poly5 poly7 poly8 #poly6
#for bench in fft kmeans stencil conv radar mri spmv
#for bench in arf ewf fir2 
#for bench in HornerBezier MotionVector SmoothTriangle
#chebyshev sgfilter mibench qspline poly1 poly2 poly3 poly5 poly6 poly7 poly8 atax bicg gemm gesummv mvt syr2k syrk trmm
do
	sed -i "s/\(TRACKS=\).*/\1$1/" Makefile
	echo "Running" $bench
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
	dot -Tpng test_pdg.dot > outputs/$bench/"$bench".png
	mv test_pdg.dot outputs/$bench/"$bench"_pdg.dot
	mv test.dot outputs/$bench/"$bench".dot
	mv test_fu.dot outputs/$bench/"$bench"_fu.dot
	mv test_fu.png outputs/$bench/"$bench"_fu.png
	mv test.net outputs/$bench/"$bench".net
	mv test.place.out outputs/$bench/"$bench".place.out
	mv test.route.out outputs/$bench/"$bench".route.out
	mv rrgraph.dot outputs/$bench/"$bench"_rrgraph.dot
	mv test.bench.log outputs/$bench/"$bench".bench.log
	mv test.vpr.log outputs/$bench/"$bench".vpr.log
	rm -rf foo_ssa.nac
done

cat bench.log

#!/bin/bash
directory=$(pwd)
for nstar in 0
do
	cd $directory
	cp nstar_$nstar/plumed.out plot-stat
        bash get_runavg.sh plot-stat > Nv.runavg.nstar_$nstar.dat
done

#!/bin/bash
directory=$(pwd)
for nstar in 25 20 15 10 5 0 -5
do
	cd $directory
	cd nstar_$nstar
        echo nstar_$nstar
	bash job.sh				
done

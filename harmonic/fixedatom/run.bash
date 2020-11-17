#!/bin/bash
directory=$(pwd)
i=1
k=0.98
cd $directory 
mkdir results
cd results
if [ -f info.dat ]
then
	rm info.dat
fi
touch info.dat
for nstar in 25 20 15 10 5 0 -5
do
	cd $directory
	cd nstar_$nstar	
	cat plumed.out | awk '{if ($1>200) print $1,$3}' > $directory/results/colvar_$i.dat
	cp water_npt_prod.tpr $directory/results/water_$i.tpr
	i=$(($i+1))	
	echo "$nstar $k" >> $directory/results/info.dat
done

cd $directory/results
#ls | grep ".tpr" | sort -n > tpr_files.txt
ls | grep ".dat" | sort -n > colvar_files.txt
paste colvar_files.txt info.dat > info.dat2
mv info.dat2 info.dat

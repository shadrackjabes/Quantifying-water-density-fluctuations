#!/bin/bash
module purge
module load intel/env/2018
module load intel/mpi/2018
module load fftw/intel/single/sse/3.3.8
module load gnuplot
module load gcc/7.3.1 gsl/gcc/2.5
source /home/sbarnabas/Packages/plumed2-2.5.2/sourceme.sh

directory=$(pwd)
for nstar in 25 20 15 10 5 0 -5
do
	cd $directory
	if [ -d nstar_$nstar ]
	then	
		echo "folder nstar_$nstar exists"
	else
		mkdir nstar_$nstar
	fi	
	cp *.itp topol.top  parameters_npt_prod.mdp water_density_equilibrated.gro  water.ndx nstar_$nstar/
	sed -e "s:NSTAR:$nstar:g" plumed.dat > nstar_$nstar/plumed.dat
	cd nstar_$nstar
	~/gmx2018/bin/gmx_mpi grompp -f parameters_npt_prod.mdp -c water_density_equilibrated.gro -r water_density_equilibrated.gro -p topol.top -o water_npt_prod.tpr -n water.ndx -maxwarn 2 > output_npt.txt 2> error_npt.txt
	cp $directory/job.sh .
	path=$(pwd)
	sed -e "s:filepath:$path:g" job.sh > job.sh2
        sed -i s/xxxx/nstar_$nstar/ job.sh2
	mv job.sh2 job.sh
	rm \#*
done

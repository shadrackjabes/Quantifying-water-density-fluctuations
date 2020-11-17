#!/bin/bash -x
#SBATCH --job-name=xxxx
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --time=96:00:00
#SBATCH --partition=batch

module purge
module load intel/env/2018
module load intel/mpi/2018
module load fftw/intel/single/sse/3.3.8
module load gnuplot
module load gcc/7.3.1 gsl/gcc/2.5
source /home/sbarnabas/Packages/plumed2-2.5.2/sourceme.sh
export PLUMED_NUM_THREADS=1

cd filepath
mpirun -np 24 ~/gmx2018/bin/gmx_mpi mdrun -v  -ntomp 1 -s water_npt_prod.tpr -o water.trr -e water.edr -c water.gro  --plumed plumed.dat 

#!/bin/bash -x
#SBATCH --job-name=0.005
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --output=out.%j
#SBATCH --error=err.%j
#SBATCH --time=96:00:00
#SBATCH --partition=batch

module purge
module load intel/env/2018
module load intel/mpi/2018
module load fftw/intel/single/sse/3.3.8
module load gnuplot
module load gromacs/nompi/cpu/intel/single/2018.4

cp -v md/* .
# minimize
gmx grompp -p topol.top -o em.tpr -c  data_spce.gro -f em.mdp -n index.ndx -maxwarn 2
gmx mdrun -pin on -nt 1 -v -s em.tpr -o traj.trr -e ener.edr

gmx trjconv -f traj.trr -o traj_em.gro -pbc whole -s em.tpr < select0
mv traj_em.gro traj.gro;
bash get_GROMACS_lasttraj.sh;
cp -v traj_last.gro em_last.gro;
cp -v traj_last.gro em_last.gro;
rm traj.gro;

# equilibration
gmx grompp -p topol.top -o eql1.tpr -c  em_last.gro -f eql1.mdp -n index.ndx -maxwarn 2 -r em_last.gro
gmx mdrun -pin on -nt 1 -v -s eql1.tpr -x traj.xtc -e ener.edr

gmx trjconv -f traj.xtc -o traj_eql1.gro -pbc whole -s eql1.tpr < select0
mv traj_eql1.gro traj.gro
bash get_GROMACS_lasttraj.sh
cp -v traj_last.gro eql1_last.gro
cp -v traj_last.gro eql1_last.gro;
rm traj.gro;

# equilibration
gmx grompp -p topol.top -o eql2.tpr -c  eql1_last.gro -f eql2.mdp -n index.ndx -maxwarn 2
gmx mdrun -pin on -nt 8 -v -s eql2.tpr -x traj.xtc -e ener.edr

gmx trjconv -f traj.xtc -o traj_eql2.gro -pbc whole -s eql2.tpr < select0
mv traj_eql2.gro traj.gro
bash get_GROMACS_lasttraj.sh
cp -v traj_last.gro eql2_last.gro
cp -v traj_last.gro eql2_last.gro;
rm traj.gro;

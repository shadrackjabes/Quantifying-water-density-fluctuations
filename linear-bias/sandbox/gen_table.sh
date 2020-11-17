rm r.U.*.txt smoothstep*txt neg_dU_dr.*.txt
num=$(awk 'BEGIN{for(i=0;i<=0.1;i+=0.005)print i}');
for n in $num;do

# generate potential, GNUPLOT
module unload matlab
module load gnuplot
boxl=5.5
sampleno=$(echo $boxl/0.0005 | bc)
cp -v gen_table.gnu a.gnu;
sed -i s/xxxx/$n/ a.gnu;
sed -i s/yyyy/$sampleno/ a.gnu
sed -i s/bbbb/$boxl/ a.gnu
gnuplot a.gnu;
echo $n;
cp -v smoothstep.$n.txt r.U.$n.txt;
sed -i '/#/d' ./r.U.$n.txt;
sed -i s/i// r.U.$n.txt;
sed -i s/o// r.U.$n.txt;

# generate force -dU/dr, MATLAB
module load matlab/R2019a
cp -v differentiate.m file.m;
sed -i s/xxxx/$n/ file.m;
matlab -nodisplay -nosplash -nodesktop -r "run('/work/scratch/sb37fege/project00930/copolymers/susesptibiliity/gen_table_codes/file.m');exit;"

# table potential GROMACS format, FORTRAN
# remove empty lines
sed -i '/^$/d'  r.U.$n.txt;
sed -i '/^$/d'  neg_dU_dr.$n.txt;
sed -i s/NaN/0.0/  r.U.$n.txt;
sed -i s/NaN/0.0/  neg_dU_dr.$n.txt;
cp -v neg_dU_dr.$n.txt neg_dU_dr.txt
cp -v r.U.$n.txt r.U.txt
cp -v gen_table_gromacs.f a.f
gfortran a.f;
./a.out;
mv table_P_OW.xvg table_P_OW.$n.xvg
done

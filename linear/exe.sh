num=$(awk 'BEGIN{for(i=0;i<=0.005;i+=0.005)print i}');
for n in $num;do
echo $n
mkdir $n
cd $n
# gro 
cp -v ../sandbox/data_spce.gro .

# topol
cp -v ../sandbox/topol.top .
cp -v ../sandbox/*itp .

# table
cp -v ../sandbox/table_P_OW.$n.xvg table_P_OW.xvg
cp -v ../sandbox/table.xvg table_P_P.xvg
cp -v ../sandbox/table.xvg table_OW_OW.xvg
cp -v ../sandbox/table.xvg .

# mdp
cp -r ../sandbox/md .

# index
cp -v ../sandbox/index.ndx .

# scripts
cp -v ../sandbox/get_GROMACS_lasttraj.sh .
cp -v ../sandbox/select0  .

# job script
cp -r ../sandbox/submit.sh .
sed -i s/xxxx/$n/ submit.sh

cd ../
done

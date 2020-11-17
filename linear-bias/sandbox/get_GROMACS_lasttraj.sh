var1=$(head -2 traj.gro|tail -1)
var2=$(($var1 + 3))
tail -$var2 traj.gro > traj_last.gro

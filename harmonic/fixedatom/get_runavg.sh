awk '{print $2 "\t" (S+=$3)/NR}' plot-stat

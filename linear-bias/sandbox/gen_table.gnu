set sample yyyy
set table "smoothstep.xxxx.txt"
strength=xxxx;
high_hydration=0.6;
low_hydration=0;
b=0.01;
set xran [0:bbbb];
s(x) = (strength*0.5)*( tanh((x-low_hydration)/b) - tanh((x-high_hydration)/b) );pl s(x) smo cspl
unset table

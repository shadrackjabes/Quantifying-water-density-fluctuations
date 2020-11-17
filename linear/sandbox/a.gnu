set sample 11000
set table "smoothstep.0.095.txt"
strength=0.095;
high_hydration=0.6;
low_hydration=0;
b=0.01;
set xran [0:5.5];
s(x) = (strength*0.5)*( tanh((x-low_hydration)/b) - tanh((x-high_hydration)/b) );pl s(x) smo cspl
unset table

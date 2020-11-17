cat plumed.out | tail -n 5000|
awk 'BEGIN{
  min1=0.2
  max1=37
  nb1=40;
  for(i1=0;i1<nb1;i1++) f[i1]=0.0;
}{
  i1=int(($3-min1)*nb1/(max1-min1));
  w=exp($NF/2.5);
  f[i1]+=w;
}
END{
  for(i1=0;i1<nb1;i1++){
  print min1+i1/nb1*(max1-min1), -2.5*log(f[i1]);
  print "";
}}'

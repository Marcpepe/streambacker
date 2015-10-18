colls=( Channel Game Stream Recording GameStamp StreamStamp )

for c in ${colls[@]}
do
  sed -i '1,1d; $d' $c.json
done

colls=( Channel Game Stream Recording GameStamp StreamStamp )

for c in ${colls[@]}
do
  mongoimport --db streambacker_db --file $c.json
done

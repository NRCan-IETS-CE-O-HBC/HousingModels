#!/bin/sh
#
line=0
rm head.txt keep.txt
head -n 1 out-VP-MartinThomas-Toronto*.csv | \
sed s/,/\\n/g | \
while read a;  do let line+=1; echo "$line -> $a" >> head.txt  \ 
done;  

cat head.txt | grep "all zones" >> keep.txt
cat head.txt | grep "day" >> keep.txt
cat head.txt | grep "hour" >> keep.txt
cat head.txt | grep "month" >> keep.txt
cat head.txt | grep "time step" >> keep.txt
cat head.txt | grep "air_point" >> keep.txt
cat head.txt | grep -E "zone 0[0-9]:supplied energy:cooling" >> keep.txt
cat head.txt | grep -E "zone 0[0-9]:supplied energy:heating" >> keep.txt
cat head.txt | grep -E "zone 0[0-9]:air point:relative humidity" >> keep.txt
cat head.txt | grep -E "zone 0[0-9]:air point:temperature" >> keep.txt
cat head.txt | grep "building:zone 08:surface 04:heat flux:radiation:shortwave:unit area" >> keep.txt
cat head.txt | grep "building:zone 08:surface 03:heat flux:radiation:shortwave:unit area" >> keep.txt
cat head.txt | grep "climate" >> keep.txt
cat head.txt | grep "electrical net:loads:occupant load" >> keep.txt
cat head.txt | grep "ideal DHW model" >> keep.txt
cat head.txt | grep "coil load" >> keep.txt
#cat head.txt | grep "" >> keep.txt

echo "========== Keeping these columns ======"
cat keep.txt



columns=`cat keep.txt | sed s/\-\>.*$//g | tr '\n' ','`
columns2=`echo $columns | sed s/\ //g | sed s/,$//g`

echo "========== Column Indicies are: ======"
echo "$columns2"

echo "========== Progress: ================="
rm TRIM*.csv
ls -1 *.csv | while read File ; do echo "Triming $File"; cat $File | cut -d, -f$columns2 > TRIM-$File ; done 

echo "========== Done ==---================="


#cat head.txt | \ 
#grep -v "total fuel" 




#grep -v "fuel" ; \
  

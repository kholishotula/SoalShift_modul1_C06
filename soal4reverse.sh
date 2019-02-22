#!/bin/bash
find /home/nandha/Desktop -name "*:* *-*-*"
echo "File mana yang mau di dekripsi? (inputkan nama file)"
read tggl
hour=$(echo ${tggl:0:2})
if [ $hour -lt 10 ]
then
hour=$(echo $hour | tr -d '0')
fi

a="abcdefghijklmnopqrstuvwxyz"
for ((i=1; i<=$hour; i=i+1))
do
 for ((j=1; j<=25; j=j+1))
 do
  swap=${a:$j:1}
  a=$(echo $a | tr $swap '0')
  swap2=${a:$j-1:1}
  a=$(echo $a | tr ${a:$j-1:1} $swap)
  a=$(echo $a | tr ${a:$j:1} $swap2)
 done
done


b="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
for ((i=1; i<=$hour; i=i+1))
do
 for ((j=1; j<=25; j=j+1))
 do
  sw=${a:$j:1}
  a=$(echo $a | tr $sw '0')
  sw2=${a:$j-1:1}
  a=$(echo $a | tr ${a:$j-1:1} $sw)
  a=$(echo $a | tr ${a:$j:1} $sw2)
 done
done
cat /home/nandha/Desktop/"$tggl".txt | tr  $a 'a-z'| tr  $b 'A-Z'> /home/nandha/Desktop/jawaban4reverse.txt

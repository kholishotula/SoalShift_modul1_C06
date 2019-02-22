#!/bin/bash
tggl=$(date +"%H:%M %d-%m-%y)
hour=$(date +"%H")
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

cat /var/log/syslog>/home/nandha/Desktop/tessoal4.txt
cat /home/nandha/Desktop/tessoal4.txt | tr 'a-z' $a | tr 'A-Z' $b > /home/nandha/Desktop/"$tggl".txt

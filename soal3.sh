#!/bin/bash
tes=$(cat /dev/urandom | tr -dc 'a-zA-z0-9' | head -c 12)
n=1
flag=0
while [ $flag==0 ]
do
 if [ $(find /home/nandha/Desktop/shift -name password$n.txt | wc -l) -gt 0 ]
 then
  cek=$(cat /home/user/nandha/shift/password$n.txt) 
  if [ $tes == $cek ] 
  then 
   until [ $tes != $cek] 
    do 
     tes=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 12) 
    done
  flag=0
  let n=$n+1
 else
  echo $tes > /home/nandha/Desktop/shift/password$n.txt
  flag=1
  break
 fi
done

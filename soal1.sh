#!/bin/bash

i=1
for var in /home/maya/sisop_mod1/nature/*.jpg
do
    base64 -d $var | xxd -r > /home/maya/sisop_mod1/soal1/$i.jpg
    i=$(($i + 1))
done

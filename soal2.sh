#!/bin/bash

echo "(2a)"
awk -F , '{ if ($7=='2012') i[$1]+=$10 } END {for(hasil in i) {print hasil}}' /home/maya/sisop_mod1/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=1 {print}'

echo "(2b)"
awk -F , '{if($7=='2012' && $1=="United States") i[$4]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' /home/maya/sisop_mod1/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3}'

echo "(2c)"
echo "-Personal Accessories-"
awk -F , '{if($7=='2012' && $1=="United States" && $4=="Personal Accessories") i[$6]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' /home/maya/sisop_mod1/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3, $4}'
echo "-Camping Equipment-"
awk -F , '{if($7=='2012' && $1=="United States" && $4=="Camping Equipment") i[$6]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' /home/maya/sisop_mod1/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3, $4}'
echo "-Outdoor Protection-"
awk -F , '{if($7=='2012' && $1=="United States" && $4=="Outdoor Protection") i[$6]+=$10} END {for(hasil in i) {print i[hasil], hasil}}' /home/maya/sisop_mod1/WA_Sales_Products_2012-14.csv | sort -nr | awk 'NR<=3 {print $2, $3, $4}'

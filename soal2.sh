#!/bin/bash

echo "--a--"
negara=$(awk -F ',' '{if($7 == '2012') a[$1]+=$10} END {for (i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -n | awk -F ',' '{print $1}' | tail -1)
echo "$negara"
printf "\n"

echo "--b--"
awk -F',' -v negara="$negara" '{if(($1==negara) && ($7 == 2012)) a[$4]+=$10} END{for(i in a) print a[i]","i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3
printf "\n"

echo "--c--"
produk1="Personal Accessories"
printf "Top 3 Product dari Personal Accessories : \n"
awk -F',' -v produk1="$produk1" '{if(($4==produk1) && ($7 == 2012)) a[$6]+=$10} END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3

produk2="Camping Equipment"
printf "\nTop 3 Product dari Camping Equipment : \n"
awk -F',' -v produk2="$produk2" '{if(($4==produk2) && ($7 == 2012)) a[$6]+=$10} END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3

produk3="Outdoor Protection"
printf "\nTop 3 Product dari Outdoor Protection : \n"
awk -F',' -v produk3="$produk3" '{if(($4==produk3) && ($7 == 2012)) a[$6]+=$10} END{for(i in a) print a[i]",",i}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $2}' | head -3


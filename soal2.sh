#!/bin/bash

echo "--a--"
negara=$(awk -F ',' '{if($7 == '2012') a[$1]+=$10} END {for (i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -n | awk -F ',' '{print $1}' | tail -1)
echo "$negara"
printf "\n"

echo "--b--"
awk -F',' -v negara="$negara" '{if(($1==negara) && ($7 == 2012)) a[$4]+=$10} END{for(i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -nr | awk -F ',' '{print $1}' | head -3
printf "\n"

echo "--c--"
produk1="Personal Accessories"
printf "Top 3 Product dari Personal Accessories : \n"
awk -F',' -v produk1="$produk1" '{if(($4==produk1) && ($7 == 2012)) a[$5]+=$10} END{for(i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -r | head -3 | awk -F, '{print $1}'

produk2="Outdoor Protection"
printf "\nTop 3 Product dari Outdoor Protection : \n"
awk -F',' -v produk2="$produk2" '{if(($4==produk2) && ($7 == 2012)) a[$5]+=$10} END{for(i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -r | head -3 | awk -F, '{print $1}'

produk3="Mountaineering Equipment"
printf "\nTop 3 Product dari Mountaineering Equipment : \n"
awk -F',' -v produk3="$produk3" '{if(($4==produk3) && ($7 == 2012)) a[$5]+=$10} END{for(i in a) print i",",a[i]}' WA_Sales_Products_2012-14.csv | sort -r | head -3 | awk -F, '{print $1}'

#!/bin/bash

#Field Separator -> Pemisah Field/data
jam=$(echo "$1" | cut -d':' -f1)

kecil=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
besar=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
geser=$((26-${jam}))

file=$(date "+%H:%M %d-%m-%y")
cat "$1" | tr "${kecil:0:26}" "${kecil:$geser:26}" | tr "${besar:0:26}" "${besar:$geser:26}" > "/home/yasinta/Documents/praktikum1/dekripsi$1"


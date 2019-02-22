#!/bin/bash

jam=$(date "+%H")
kecil=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
besar=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ

file=$(date "+%H:%M %d-%m-%y")
cat /var/log/syslog | tr "${kecil:0:26}" "${kecil:$jam:26}" | tr "${besar:0:26}" "${besar:$jam:26}" > "/home/yasinta/Documents/praktikum1/$file" 
############### misal tr [a-z] [fghijklmnopqrstuvwxyzabcde]


#!/bin/bash

i=1
file=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)

while [ -f ./password"$i".txt  ]
do
  if [ "$file" == "$(cat ./password"$i".txt)" ]
  then
    file=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12)
    i=1
  else
    let "i++"
  fi
done

echo "$file" > password"$i".txt

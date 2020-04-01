#!/bin/bash

for i in {1..7450}; do
    r=$(($RANDOM % 100));

    if [ "$r" -gt 25 ]; then
        # [$ip] Generate fake IPv4
        ip=$(($RANDOM % 239 + 1)); 
        for j in {1..3}; do 
            temp=$(($RANDOM % 256)); 
            ip="$ip.$temp"; 
        done 

        # [$password] Generate fake password
        randomLine=$(($RANDOM % 1000 + 1));
        password=$(sed "${randomLine}q;d" 1000word.txt);

        while [ "${#password}" -lt 8 ]; do
            randomLine=$(($RANDOM % 1000 + 1));
            temp=$(sed "${randomLine}q;d" 1000word.txt);
            password="$temp$password";
        done 

        # [sha1] Generate fake sha-1
        sha1=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 40 | head -n 1);

        echo "$i,$ip,$password,$sha1" >> pwned.txt;
    fi
done
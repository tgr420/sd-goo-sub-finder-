#!/bin/bash

#sudo /etc/init.d/tor restart
#torify

tar=$1
sfe=$(echo "$tar" | cut -d "." -f 1)
echo -n "+-www" > gsd-tmp.txt

while [ TRUE ]
do

for gsd in $(cat gsd-tmp.txt); do
g=$(curl "https://www.google.com/search?q=site:$tar$gsd" -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' -s | grep -Eoi '<a [^>]+>' |  grep -Eo 'href="[^\"]+"' |  grep -Eo '(http|https)://[^/"]+' | grep -i "$tar" | sort -u)

if echo "$g" | grep -i ".$tar" &> /dev/null;
  then
    echo "$g" | sed 's/https:\/\///g' | sed 's/http:\/\///g'
    echo "$g" | cut -d '/' -f 3 | cut -d "." -f 1 | sed 's/\<$sfe\>//g' | sed 's/^/+-/' | sort -u |tr -d '\n' >> gsd-tmp.txt
else
        exit 1
fi
done < gsd-tmp.txt
done
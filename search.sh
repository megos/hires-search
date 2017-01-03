#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage ./search.sh [artistname]"
  exit
fi

artist=$(echo $1 | nkf -wMQ | tr = %)
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0"
echo $artist
wget --user-agent="$UA" http://www.e-onkyo.com/search/search.aspx?q=${artist} -O test.html

cat test.html | grep -A 5 -F "<ContentTemplate>" | grep -vF "<ContentTemplate>" | grep -vF "searchResult" | grep -vF "alt=" | sed -e 's/.*href="\(.*\)" title=.*">\(.*\)<\/a>.*/\1,\2/' | sed -e "s/.*href='\(.*\)'>\(.*\)<\/a>.*/\1,\2/" > result.txt

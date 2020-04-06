#!/usr/bin/env bash

maxcounter=300 
counter=1

while $(curl --output /dev/null --silent --head --fail http://app:9000); do
    sleep 3
    >&2 echo "Php-fpm not initialized yet. Awaiting 3s ..."
    counter=`expr $counter + 1`
    if [ $counter -gt $maxcounter ]; then
        >&2 echo "We have been waiting for php-fpm too long already; failing."
        exit 1
    fi;
done

>&2 echo "Php-fpm server initialized. Starting application."
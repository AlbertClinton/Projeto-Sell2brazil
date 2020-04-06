#!/usr/bin/env bash

maxcounter=300
counter=1

while ! mysql -h "${MYSQL_HOST}" -P "${MYSQL_PORT}"  --protocol=tcp -u "${MYSQL_USER}" --password="${MYSQL_PASSWORD}" -D "${MYSQL_DATABASE}" -e "select 1;" > /dev/null 2>&1; do
    sleep 3
    >&2 echo "Mysql not initialized yet. Awaiting 3s ..."
    counter=`expr $counter + 1`
    if [ $counter -gt $maxcounter ]; then
        >&2 echo "We have been waiting for MySQL too long already; failing."
        exit 1
    fi;
done

>&2 echo "Mysql server initialized. Starting application."
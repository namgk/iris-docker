#!/bin/bash
httpd &

su - postgres -c 'pg_ctl -D /var/lib/pgsql/data -l logfile start'

iris_ctl init

HOST=206.12.15.195

cd /var/www/html/iris-client
sed -i "s|///|//$HOST/|g" *.properties
sed -i "s|///|//$HOST/|g" *.jnlp
sed -i "s/sonar.host=/sonar.host=$HOST/g" iris-client.properties

exec "$@"

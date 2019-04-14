#!/bin/bash

spawn-fcgi -a 127.0.0.1 -p 9000 ./fortran_fcgi

sed -e "s/\${PORT}/$PORT/" /etc/nginx/sites-available/default.template > /etc/nginx/sites-available/default

nginx -g 'daemon off;'

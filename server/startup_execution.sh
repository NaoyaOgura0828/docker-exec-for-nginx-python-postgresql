#!/bin/bash

# Start postgresql
service postgresql start

# Start nginx
nginx -g 'daemon off;'

tail -f /dev/null

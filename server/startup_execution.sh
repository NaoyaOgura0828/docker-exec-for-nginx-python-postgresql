#!/bin/bash

# Start postgresql
sudo service postgresql start

# Start nginx
sudo nginx -g 'daemon off;'

tail -f /dev/null

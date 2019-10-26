#!/bin/sh

cd /opt/yaofan

/usr/bin/gunicorn -w4 -b 0:35000 run:app

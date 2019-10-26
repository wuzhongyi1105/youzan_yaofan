#!/bin/sh

cd /opt/qiafan

/usr/bin/gunicorn -w4 -b 0:35000 run:app

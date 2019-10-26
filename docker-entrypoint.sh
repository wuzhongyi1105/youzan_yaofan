#!/bin/sh

cd /opt/yaofan && gunicorn -w4 -b 0:35000 run:app

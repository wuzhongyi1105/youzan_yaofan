FROM alpine:3.4

RUN apk upgrade --update \
 && apk add -t build-dependencies \
    python-dev \
    libffi-dev \
    build-base \
 && apk add \
    python \
    sqlite \
    openssl \
    ca-certificates \
    git \
 && git clone https://github.com/wuzhongyi1105/youzan_yaofan.git /opt/yaofan \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

WORKDIR /opt/yaofan

RUN pip install -r requirement.txt \
 && python run.py deploy

VOLUME /opt/yaofan

EXPOSE 35000

CMD /usr/bin/gunicorn -w4 -b 0:35000 run:app

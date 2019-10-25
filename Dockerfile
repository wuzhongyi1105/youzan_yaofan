FROM alpine:3.4

RUN apk upgrade --update \
 && apk add -t build-dependencies \
    python-dev \
    libffi-dev \
    build-base \
 && apk add \
    py-pip \
    python \
    sqlite \
    openssl \
    ca-certificates \
    git \
 && git clone https://github.com/wuzhongyi1105/youzan_yaofan.git /opt/yaofan \
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

VOLUME /opt/yaofan
WORKDIR /opt/yaofan

RUN pip install -r requirement.txt \
 && python run.py deploy

EXPOSE 35000

CMD gunicorn -w4 -b 0:35000 run:app

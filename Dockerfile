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
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

COPY app /app
COPY config.py
COPY requirement.txt
COPY run.py
COPY update.py

RUN pip install -r requirement.txt \
 && python run.py deploy

VOLUME /app/youzan
VOLUME /config.py

EXPOSE 35000

CMD /usr/bin/gunicorn -w4 -b 0:35000 run:app
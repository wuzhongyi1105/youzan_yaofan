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
 && apk del build-dependencies \
 && rm -rf /tmp/* /var/cache/apk/*

COPY app /app
COPY config.py /config.py
COPY requirement.txt /requirement.txt
COPY run.py /run.py
COPY update.py update.py

RUN pip install -r requirement.txt \
 && python run.py deploy

VOLUME /app/youzan

EXPOSE 35000

CMD /usr/bin/gunicorn -w4 -b 0:35000 run:app
FROM node:current-alpine3.20
LABEL maintainer="Ryan Kerry <rkerry1@gmail.com>"

ENV HUGO_VERSION 0.142.0
ENV HUGO_EXTENDED_BINARY hugo_extended_${HUGO_VERSION}_Linux-64bit

RUN npm install -g firebase-tools

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_EXTENDED_BINARY}.tar.gz /tmp/hugo.tar.gz
RUN mkdir /usr/local/hugo \
	&& tar xzf /tmp/hugo.tar.gz -C /usr/local/hugo/ \
	&& ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
	&& rm /tmp/hugo.tar.gz

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

CMD hugo version
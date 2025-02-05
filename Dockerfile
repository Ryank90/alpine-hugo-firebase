FROM --platform=linux/amd64 node:current-alpine3.20
LABEL maintainer="Ryan Kerry <rkerry1@gmail.com>"

RUN apk --no-cache add gcompat libc6-compat && \
  ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2

ENV HUGO_VERSION 0.143.1
ENV HUGO_EXTENDED_BINARY hugo_${HUGO_VERSION}_Linux-64bit

RUN npm install -g firebase-tools

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_EXTENDED_BINARY}.tar.gz /tmp/hugo.tar.gz
RUN mkdir /usr/local/hugo \
	&& tar xzf /tmp/hugo.tar.gz -C /usr/local/hugo/ \
	&& ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
	&& rm /tmp/hugo.tar.gz
	
CMD hugo version
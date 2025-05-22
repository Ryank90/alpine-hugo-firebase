FROM --platform=${BUILDPLATFORM} bitnami/minideb AS build

ENV HUGO_VERSION=0.147.5
ENV HUGO_EXTENDED_BINARY=hugo_extended_${HUGO_VERSION}_Linux-64bit

ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_EXTENDED_BINARY}.tar.gz /tmp/hugo.tar.gz

RUN tar xvzf /tmp/hugo.tar.gz -C /tmp/ && \
  mv /tmp/hugo /usr/bin

# ---

FROM --platform=${BUILDPLATFORM} node:lts-slim
LABEL maintainer="Ryan Kerry <rkerry1@gmail.com>"

COPY --from=build /usr/bin/hugo /usr/bin/hugo

WORKDIR /app

RUN apt-get update \
      && apt-get install -y ca-certificates curl \
      && rm -rf /var/lib/apt/lists/* \
      && npm install -g firebase-tools

CMD ["hugo"]

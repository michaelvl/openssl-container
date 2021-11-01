FROM alpine:3.14.2

RUN apk update && \
  apk add --no-cache openssl && \
  rm -rf "/var/cache/apk/*"

WORKDIR /work
VOLUME  /work

ENTRYPOINT ["openssl"]

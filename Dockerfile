FROM alpine:latest

WORKDIR /workspace

RUN apk update && apk add --no-cache \
      bison flex gcc g++ make musl-dev vim tree

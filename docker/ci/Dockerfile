FROM golang:1.6-alpine

ENV TERM=xterm

ADD rootfs/ /

RUN apk update && \
    apk upgrade && \
    apk add \
        bash \
        make \
        git

RUN go get github.com/alecthomas/gometalinter && \
    gometalinter --install --update

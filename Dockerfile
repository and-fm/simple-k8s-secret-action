FROM alpine:latest

RUN apk update
RUN apk add kubectl

ENTRYPOINT ["/entrypoint.sh"]
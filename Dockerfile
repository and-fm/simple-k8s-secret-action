FROM golang:latest as build

WORKDIR /app

COPY src/go.mod ./
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

COPY src .

RUN go build -ldflags "-w -s" -v -o /usr/local/bin/secretparse .

FROM alpine:latest

RUN apk update
RUN apk add kubectl

COPY --from=build /usr/local/bin/secretparse ./secretparse
RUN chmod +x /secretparse

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
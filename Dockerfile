FROM golang:latest as build

WORKDIR /app

COPY go.mod ./
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

COPY . .

RUN go build -ldflags "-w -s" -v -o /usr/local/bin/secret-parse .

FROM alpine:latest

RUN apk update
RUN apk add kubectl

COPY --from=build /usr/local/bin/secret-parse ./secret-parse

ENTRYPOINT ["/entrypoint.sh"]
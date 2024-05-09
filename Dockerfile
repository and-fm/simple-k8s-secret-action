# FROM golang:latest as build

# WORKDIR /app

# COPY src/go.mod ./
# ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

# COPY src .

# RUN go build -ldflags "-w -s" -v -o /usr/local/bin/secretparse .

FROM alpine/curl:latest

RUN curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /bin/kubectl
RUN chmod +x /bin/kubectl

# COPY --from=build /usr/local/bin/secretparse /bin/secretparse
# RUN chmod +x /bin/secretparse

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
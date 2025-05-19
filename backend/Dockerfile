FROM golang:latest AS build-stage

RUN apt-get update && apt-get install -y ca-certificates openssl
ARG cert_location=/usr/local/share/ca-certificates
# Get certificate from "proxy.golang.org"
RUN openssl s_client -showcerts -connect proxy.golang.org:443 </dev/null 2>/dev/null|openssl x509 -outform PEM >  ${cert_location}/proxy.golang.crt
# Update certificates
RUN update-ca-certificates

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN  CGO_ENABLED=0 GOOS=linux go build -o /gin-service

FROM alpine:latest
WORKDIR /bin
COPY --from=build-stage /gin-service /gin-service
EXPOSE 8081
# ENTRYPOINT /gin-service --port ${PORT}
ENTRYPOINT ["/bin/sh", "-c", "exec /gin-service --port 8081"]
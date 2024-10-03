# builder
FROM golang:1.22.6 AS builder
WORKDIR /src/
COPY go.mod /src/
COPY go.sum /src/
RUN --mount=type=cache,id=gomod,target=/go/pkg/mod \
  --mount=type=cache,id=gobuild,target=/root/.cache/go-build \
  go mod download && \
  go mod tidy
COPY . /src/
RUN --mount=type=cache,id=gomod,target=/go/pkg/mod \
  --mount=type=cache,id=gobuild,target=/root/.cache/go-build \
  CGO_ENABLED=0 go build -o dns-sd-proxy

# runtime
FROM ineva/alpine:3.10.3
LABEL maintainer="Steven <s@ineva.cn>"
WORKDIR /app
COPY --from=builder /src/dns-sd-proxy /app
ENTRYPOINT /app/dns-sd-proxy -name $SD_PROXY_NAME -service $SD_PROXY_SERVICE -domain=${SD_PROXY_DOMAIN:-local.} -ip $SD_PROXY_IP -wait 0 -port $SD_PROXY_PORT -host ${SD_PROXY_HOST:-docker-pc}

FROM registry.access.redhat.com/ubi9/go-toolset:1.25.8-1775724628 AS build

USER root

ADD . /app

RUN cd /app && CGO_ENABLED=0 go build -ldflags='-extldflags=-static' -o=projection ./cmd/consumer/main.go

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.7

COPY --from=build /app/projection /

ENTRYPOINT ["/projection"]

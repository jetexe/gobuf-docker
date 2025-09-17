# syntax=docker/dockerfile:1

FROM docker.io/library/golang:1.25.0-alpine3.21 AS builder

ENV PROTOC_GO=v1.36.9
ENV PROTOC_GO_GRPC=v1.5.1

RUN set -x \
 && go install google.golang.org/protobuf/cmd/protoc-gen-go@$PROTOC_GO \
 && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$PROTOC_GO_GRPC

FROM docker.io/bufbuild/buf:1.57.2

RUN mkdir /.cache && chmod 777 /.cache

COPY --from=builder /go/bin /usr/bin

LABEL org.opencontainers.image.source="https://github.com/jetexe/gobuf-docker"

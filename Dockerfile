FROM golang:1.20.4-alpine3.16 as builder

ENV PROTOC_GO=v1.35.1
ENV PROTOC_GO_GRPC=v1.5.1

RUN set -x \
 && go install google.golang.org/protobuf/cmd/protoc-gen-go@$PROTOC_GO \
 && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@$PROTOC_GO_GRPC

FROM bufbuild/buf:1.47.0

RUN mkdir /.cache && chmod 777 /.cache

COPY --from=builder /go/bin /usr/bin

LABEL org.opencontainers.image.source="https://github.com/jetexe/gobuf-docker"

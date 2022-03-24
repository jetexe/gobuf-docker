FROM golang:1.18.0-alpine3.15 as builder

WORKDIR /work

COPY ./ ./

RUN set -x \
 && go mod vendor \
 && go install ./vendor/google.golang.org/protobuf/cmd/protoc-gen-go \
 && go install ./vendor/google.golang.org/grpc/cmd/protoc-gen-go-grpc

FROM bufbuild/buf:1.1.1

RUN mkdir /.cache && chmod 755 /.cache

COPY --from=builder /go/bin /usr/bin

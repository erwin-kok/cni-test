# syntax=docker/dockerfile:1

FROM --platform=${BUILDPLATFORM} golang:1.21.0 AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /go/src/github.com/erwin-kok/cni-test

RUN --mount=type=bind,readwrite,target=/go/src/github.com/erwin-kok/cni-test \
    --mount=type=cache,target=/root/.cache \
    --mount=type=cache,target=/go/pkg \
    make GOARCH=${TARGETARCH} PKG_BUILD=1 DESTDIR=/tmp/install/${TARGETOS}/${TARGETARCH} build-container install-container-binary


COPY cni-plugin/install-cni-plugin.sh /tmp/install/${TARGETOS}/${TARGETARCH}


FROM alpine:3.14 AS release

ARG TARGETOS
ARG TARGETARCH

COPY --from=builder /tmp/install/${TARGETOS}/${TARGETARCH} /

CMD ["/opt/cni/bin/test-cni"]

FROM golang:1.8.4-jessie as builder
ENV buildpath=/usr/local/go/src/build/k8s-zk-announser
ARG build=notSet
RUN mkdir -p $buildpath
ADD . $buildpath
WORKDIR $buildpath

RUN make build/release

FROM debian:8
COPY --from=builder /usr/local/go/src/build/k8s-zk-announser/_release/k8s-zk-announser /k8s-zk-announser

ENTRYPOINT ["/k8s-zk-announser"]

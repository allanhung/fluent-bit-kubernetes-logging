FROM golang:1.12.7-stretch AS build
ENV CGO_ENABLED=1
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPATH=/go
RUN go get github.com/allanhung/fluent-bit-go-loki
RUN go get github.com/allanhung/fluent-bit-out-syslog || echo "ignore go get error!"
WORKDIR /go/src/github.com/allanhung/fluent-bit-go-loki
RUN make build
WORKDIR /go/src/github.com/allanhung/fluent-bit-out-syslog
RUN go build -buildmode c-shared -o out_syslog.so cmd/main.go

FROM fluent/fluent-bit:1.2
COPY --from=build /go/src/github.com/allanhung/fluent-bit-go-loki/out_loki.so /usr/lib/x86_64-linux-gnu/
COPY --from=build /go/src/github.com/allanhung/fluent-bit-out-syslog/out_syslog.so /usr/lib/x86_64-linux-gnu/
COPY conf/fluent-bit.conf \
     conf/parsers.conf \
     conf/parsers_java.conf \
     conf/parsers_extra.conf \
     conf/parsers_openstack.conf \
     conf/parsers_cinder.conf \
     conf/out_loki.conf \
     conf/out_syslog.conf \
     conf/plugins.conf \
     /fluent-bit/etc/

EXPOSE 2020

# Entry point
CMD ["/fluent-bit/bin/fluent-bit", "-c", "/fluent-bit/etc/fluent-bit.conf", "-e", "/usr/lib/x86_64-linux-gnu/out_loki.so", "-e", "/usr/lib/x86_64-linux-gnu/out_syslog.so"]


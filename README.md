## Build and push to repository
```
docker build -t allanhung/fluent-bit:1.4.2 .
docker push allanhung/fluent-bit:1.4.2
```

## deploy into kubernetes
```
kubectl create -f manifest/* -n logging
```

## Reference
  - [fluent-bit](https://github.com/fluent/fluent-bit)
  - [loki](https://github.com/grafana/loki)
  - [fluent-bit-out-syslog](https://github.com/pivotal-cf/fluent-bit-out-syslog)

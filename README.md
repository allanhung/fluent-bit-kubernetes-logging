## Build and push to repository
```
docker build -t allanhung/fluent-bit:1.4.2 .
docker push allanhung/fluent-bit:1.4.2
```

## deploy into kubernetes
```
kustomize build kustomize | kubectl apply -f -
```

## create your own deployment
```
kubectl create secret docker-registry example-registry --docker-server=example-registry.com --docker-username=user --docker-password=password --dry-run -o yaml > kustomize/overlays/example/secrets.yaml
kustomize build kustomize/overlays/example | kubectl apply -f -
```
## Reference
  - [fluent-bit](https://github.com/fluent/fluent-bit)
  - [loki](https://github.com/grafana/loki)
  - [fluent-bit-out-syslog](https://github.com/pivotal-cf/fluent-bit-out-syslog)

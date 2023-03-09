

```
curl  http://10.183.248.238:9981/debug/pprof/trace?seconds=30 > a.out
```

```
wget -O trace.out http://10.183.248.238:9981/debug/pprof/trace?seconds=30
```



```
go tool pprof -http=:8081  http://10.179.247.64:9981/debug/pprof/profile 
go tool pprof -http=:8082  http://10.179.247.64:9981/debug/pprof/block
wget -O trace.out http://localhost:9981/debug/pprof/trace?seconds=70
```


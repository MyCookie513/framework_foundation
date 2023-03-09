





```
go tool pprof http://10.169.198.242:9981/debug/pprof/profile
http://localhost:9981/debug/pprof/profile
```

```
wget https://dl.google.com/go/go1.20.linux-amd64.tar.gz
10.169.198.242

```



| 函数名 | 数值 | 占比 |
| ------ | ---- | ---- |
|        |      |      |
|        |      |      |



## 今天压测CPU几乎掉底！！！

### 25% CPU：GC

* <mark>alloc 1G 14% </mark>： GetApolloCallerUriPermConfig  
* <mark>alloc 4G 60% </mark>:  util.DefaultApolloHelper.GetJsonConfig(key)

### 8%  CPU：  GetApolloCallerUriPermConfig

![](/Users/didi/Library/Application Support/typora-user-images/image-20210910205726026.png)

### 25% CPU: getJsonConfig 

![image-20210910205748500](/Users/didi/Library/Application Support/typora-user-images/image-20210910205748500.png)








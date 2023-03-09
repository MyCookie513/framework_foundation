# 服务经常出现的问题： 

## 一 . CPU idle 过低 

> 查看是那些程序段落导致CPU占用： 
>
> go tool pprof http://10.166.203.165:9981/debug/pprof/profile
>
> top : 显示前几名
>
> list : 展示代码段
>
> web : 可视化展示  

```
go tool pprof -http=:8081  http://10.183.248.238:9981/debug/pprof/profile

go tool pprof http://localhost:9981/debug/pprof/profile --seconds=90
```



### GC 太频繁：

```

寻找哪几个源头一直在创建对象

查看是那些程序段落频繁分配对象： go tool pprof http://10.183.248.238:9981/debug/pprof/allocs

```

### Heap:

##### --inuse/alloc_space  |   --inuse/alloc_objects 区别

通常情况下：

- 用`--inuse_space`来分析程序常驻内存的占用情况;
- 用`--alloc_objects`来分析内存的临时分配情况，可以提高程序的运行速度。

### Goroutine 的数量太多：

```

调度器调度不过来

查看是那些程序段落一直在创建协程： go tool pprof http://10.183.248.238:9981/debug/pprof/goroutine

```





## 二 . Memory 打满 

### heap ：

```

查看堆中是哪里占用了内存

查看是那些对象比较大： go tool pprof http://10.183.248.238:9981/debug/pprof/heap

```



## 三 . 效率问题 

> Block : 程序中的阻塞问题 ：<mark>异步系统调用不算！！！例如网络请求，只是针对 mutex channel syscall  等block统计时间</mark>

```
go tool pprof http://10.183.248.238:9981/debug/pprof/block
```

> mutex ： 占用mutex太长的问题

```
go tool pprof http://10.183.248.238:9981/debug/pprof/mutex
```



## 生成火焰图：

```
go tool pprof -http=:8081 ~/pprof/pprof.samples.cpu.001.pb.gz
```

```
curl -w "\n time_total：%{time_total}\n"  "http://100.69.238.44:8000/gulfstream/key-service/core/getCityId?caller=test&token=MaWoq2AOWmiVVZkV_VMRNsY9Wc_CVefI5Kx0YTgUu08kzDmuwzAMQMG7vJowSMmURN7mL87SKECCVIbvHiCuppudqSR10UURppEmzEJWVw1hVtK6R4keoe6lCnMlVZhOgvBz8kuWsZa2WinmobUL_99uI3dej_fzbyNdVeMQLqQ1jzZGdxeuJFZH79aqj45wO9s7qccnAAD__w=="
```






## Sentinel

* sentinel 集群负责监控 redis cluster 
* 如果有挂机出现，进行故障转移



### 监控集群

![](https://img-blog.csdnimg.cn/2019121214584264.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70)

* sentinel的三个定时任务

  + 每10秒对master和slave进行info ，观察主从关系。
  + 每两秒sentinel相互之间交互信息（对redis节点的看法和自身信息）（通过消息订阅模式（通过master节点的channel））
  + 每一秒每个sentinel对sentinel和redis执行ping ，（观察是否有人下线了）

* sentinel 的主要配置信息

  > port ${port}
  > dir “/opt/soft/redis/data/”
  > logfile “${port}.log”
  > sentinel monitor masterName 127.0.0.1 7000 2 ------>标明了那个是你的主master，2 代表如果有两个的哨兵发现机器有故障才会进行故障转移；
  > sentinel down-after-milliseconds masterName 30000; ----->如果30秒始终ping 不通 ，则证明有故障
  > sentinel parallel-sync masterName 1 ; ------>并行复制的时候只能有一个进行；
  > sentinel failover-timeout masterName 180000 ; ------>进行故障转移的时间
  > 原文链接：https://blog.csdn.net/weixin_42353390/article/details/103508832



### sentinel 进行的故障转移

* 首先发现有节点下线的sentinel发起领导者选举，投票决定

  <img src="https://img-blog.csdnimg.cn/20191217155023354.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom:50%;" />

* 控制选取一个合适的节点进行主节点的替换

  <img src="https://img-blog.csdnimg.cn/20191217155851622.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom:50%;" />

  + 合适的节点

    ​	<img src="https://img-blog.csdnimg.cn/20191217155921224.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom: 33%;" />

* 节点上线归于原来的slave节点





### 客户端连接的流程

* 配置好sentinel节点的集合，和 masterName 的名字；
* 遍历 sentinel节点集合 获取一个可用的sentinel 节点（能够ping通）
* 通过sentinel获取主节点的地址；（通过主节点的地址，就可以获取整个集群的信息，然后进行交互）
* 验证获取到的节点的地址是否是想要的角色
* 客户端实时更新主从节点的角色变化；**（通过消息订阅的模式实现）**























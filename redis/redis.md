## redis

* 可进行事务操作
* 可以持久化
* 概念上的单线程

### 五种数据结构

<img src="https://img-blog.csdnimg.cn/20191128225857442.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom: 67%;" />

* String
* List
* map
* set
  + 可以从set集合中随机的pop一个或者多个元素
  + 不同的集合之间可以取交集差集并集；
* 加权排序sortset
  + 底层是一个list ，获取索引范围内的数据
  + 也可以获取制定分值段的数据或者count数量
  + 可以求并集和交集



### 常用的几种瑞士军刀工具

* 经纬度 地理位置 GEO
  + 添加位置： geoadd key 经度 纬度 位置名（member）
  + 获取位置信息： geopos key member
  + 获取两个地理位置之间的距离 ： geodist key member1 member2   15km
* 大体准确的计数器HyperLoglog :12kb的空间；
  + 利用巧妙的算法完成极小空间完成独立数量的统计（并不是特别准确）
  + 计算set集合中有的元素的总数。实质底层并没有存储这些元素。
* Bitmap : 就是对底层存储的bit 进行运算处理， 进行或与非之间的处理，或者改变某个bit 的值



### 两种特殊功能

* 发布订阅

  <img src="https://img-blog.csdnimg.cn/20191203175056318.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom:33%;" />

* 消息队列

  <img src="https://img-blog.csdnimg.cn/20191203180130456.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom: 33%;" />

### 两种持久化的方式

* AOF 记录操作日志

  + 每操作成功一个命令，**异步**的将命令写入到AOF ，所以这样数据是不容易丢失的

  + AOF进行重写的三种方式

    <img src="https://img-blog.csdnimg.cn/20191205103736803.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom:30%;" />

  + AOF 重写命令的触发条件

    <img src="https://img-blog.csdnimg.cn/20191205122023157.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom:30%;" />

    + 配置

      ```yml
      # aof 的相关配置
      appendonly yes
      appendfilename "appendonly-6382.aof"
      # 三种同步策略之一  按秒进行写入命令；
      appendfsync everysec
      #在进行重写的过程中如果有新的数据来是否还要往旧的AOF中的文件中写；
      no-appendfsync-on-rewrite yes
      # 配置重写的触发时机
      auto-aof-rewrite-percentage 100
      auto-aof-rewrite-min-size 64mb
      ```

* RDB 内存复制到硬盘

  + 可用命令save or bgsave 将redis中的内容持久化到当地硬盘
  + RDB自动触发
    +  全量复制 --也就是进行主从之间的复制的时候
    + save 60 10000 满足save条件时
    + shutdown
  + 缺点
    - 耗时，消耗性能。 o(n)
    - fork () 消耗内存
    - Disk I/O： I/O消耗
  + 优点
    + 速度快

* key具有过期失效的机制



### 集群分压方式

* 主从模式 缓解读压力

* hash分槽 缓解写压力

  ![](https://img-blog.csdnimg.cn/20190922103320430.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70)



### 集群模式

###  

### 手动建立集群的步骤

* 让多个节点meet 
* 设置节点之间的主从关系
* 给每个主节点进行分配槽点



### 集群下get和set 

<img src="https://img-blog.csdnimg.cn/20191226100226158.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MjM1MzM5MA==,size_16,color_FFFFFF,t_70" style="zoom: 50%;" />

* smart客户端；
  + 向集群中的一个节点获取信息；将cluster slots 的结果映射到本地， 为每个节点那创建jedispool


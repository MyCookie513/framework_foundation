### 进程和线程的区别

* 定义上的不同： **进程是操作系统资源分配的基本单位，线程是任务调度和执行的基本单位；**
* 内涵关系：          **操作系统中可以有多个进程在运行，一个进程中可以有多个线程在运行**
* 内存资源的分配： 系统为进程分配了内存资源，  进程内部的线程可以共享进程内部的资源，          **同时线程还有自己的栈和栈指针，程序计数器等寄存器。进程有自己独立的地址空间，而线程没有，线程必须依赖于进程而存在**  







##### netstat是一个监控tcp/ip信息的工具

* 查看某个端口被那个进程占用， 详细信息： 
* Netstate  -tunlp | grep XXX.  



##### 查看此时的某个进程瞬时所占用资源的信息

* ps aux | grep nginx 



##### 在一个文件中查找具体内容

* grep    -rn    "正则表达式"   filename

Fbx 3d 
revit

bm模型



### AWK命令-分割文本

* 是一个强大的文本分析工具

* 将文本分段进行输出

  + 默认的分割符 ： 空格  and tab     ---->awk '{print $1,$4}' log.txt
  + 自定义文本分割符 ：以逗号为分割符 ------  awk -F, '{print $1}'   test.txt

* 进行相关变量的操作

  + 对文本分段的的变量的运算: 

    > awk -va=1 '{print $1,$1+a}' log.txt

* 对每一行的文本字段进行条件过滤后输出

  + 过滤第一列大于2并且第二列等于’Are’的行

    ```shell
    awk '$1>2 && $2=="Are" {print $1,$2,$3}' 
    log.txt
    ```
  ```
    
    ![](https://img-blog.csdn.net/20180114142315510?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvamluOTcwNTA1/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
  ```

* 其他的具体的相关操作 [详细文章](https://blog.csdn.net/jin970505/article/details/79056457)

##### 配置多个分割符：

```
 awk -F '[()]' '{print $1,$2,$3}'
```







* curl 命令的文章[连接](https://www.jianshu.com/p/7965c56c5a2e)

* 这里利用curl命令 发送xml  数据 并且附带其他的  get 参数

  ```go
  echo '<xml>
    <ToUserName><![CDATA[to xiaohong  ]]></ToUserName>
    <FromUserName><![CDATA[ from xiaoming  ]]></FromUserName>
    <CreateTime>1348831860</CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[助力]]></Content>
    <MsgId>1234567890123456</MsgId>
  </xml>'| curl -X POST -H 'Content-type:text/xml'   -d @- "http://10.179.58.93:8080/webapp/platform/wxIndex/testA?srvno=kflower"
  ```

* Curl  命令查看耗时

  ```shell
  curl  -w "@curl-format.txt" -o /dev/null  你的请求
  
  curl-format.txt： 
      time_namelookup:  %{time_namelookup}\n
         time_connect:  %{time_connect}\n
      time_appconnect:  %{time_appconnect}\n
        time_redirect:  %{time_redirect}\n
     time_pretransfer:  %{time_pretransfer}\n
   time_starttransfer:  %{time_starttransfer}\n
                      ----------\n
           time_total:  %{time_total}\n
  
  ```

  







### TCP相关的命令行

* 监听一个端口

  > nc -l  8080

* 向一个端口发送数据

  > echo -e '{ json数据 }' | nc localhost 8080



### nginx 

* 命令 启动

  > nginx -c  指定配置文件 
  >
  > 单个 nginx 也能启动 ；

* 关闭命令

  > killall -9 nginx 

* 查看进程

  > ps -ef | grep nginx 

* 重新进行加载 

  > nginx -s reload 

* 检查nginx 配置文件是否符合规范

  > nginx -c -t 指定配置文件 





### redis

* 启动

  > redis-server  指定配置文件目录
  >
  > redis-cli -p 6380 

* 查看

  > ps -ef | grep redis 
  >
  > netstat -tunlp | grep redis 

```
grep "webapp_push_to_Alipay_result" /home/xiaoju/webroot/theone/log/webapp-v3/info.log.2020082621 | grep -v 10000 |awk -F '|' '{print $15}' | uniq -c | sort 
```



### 查看日志的常用命令 

* **grep '10.79.41.16' didi.log | grep '04-18' | awk -F '|' '{print $15}' | sort | uniq -c**

```
广州机房，个人账户即可执行ifind和irun命令
天津机房以及腾讯机房需要在中控机的rd账户下才能使用ifind和irun命令，切换到rd账户 sudo su - rd
```

* ifind 用于找机器和tag之间的对应关系

  * 列出线上的所有的tags 

    ```shell
    ifind --tags 
    ```

  * 寻找当前机器属于那个tag 

    ```sql
    `ifind -b ``'machineName'`
    ```

  * 寻找tag下面的所有的机器

    ```sql
    ifind -t 'tagName'   这样会以主机名返回
    dache-api-web00.qq
    dache-api-web01.qq
    dache-api-web02.qq
    dache-api-web03.qq
    ifind -t 'tagName' --ip  这样会以IP名返回
    10.242.154.18
    10.242.153.19
    ```
    
  * 根据odin命名空间进行查询

    ```sql
    ifind -n hna.openapi.gs.biz.didi.com
    biz-openapi-web00.gz01
    biz-openapi-web02.gz01
    ```

  * ifind -o 查询指定服务器/ip 所在节点的owner

    ```shell
    服务器所在节点: hna.gs-php.public.biz.didi.com
    节点研发接口人: caole
    节点SRE接口人: huoshengkun,chendong,lishuaigibran,chujitao,zhangdaoli
    ```

  * ifind -s 正则匹配

    ```shell
    ifind -s pay-web0[1-3]
    dache-pay-web01.qq
    dache-pay-web02.qq
    dache-pay-web03.qq
    dache-scanpay-web01.qq
    dache-scanpay-web02.qq
    dache-scanpay-web03.qq
    ```

  * 查看dsi信息

    ```shell
    根据机器名/ip查询dsi信息
    ifind --mdsi internal-api-sf-9e445-1.docker.us01
    
     输出结果:
    ----------------------------------------
    su: us01-v.ibt-falcon-internal_api
    port: main:8000;port2:8002
    默认weight: 100
    
    
    根据su查询dsi信息
    ifind --udsi us01-v.ibt-falcon-internal_api
    
    根据tag或odin节点信息查询dsi信息
    ifind --dsi us01-v.internal-api.falcon.ibt.didi.com
    ```

    

* irun 用于在一组机器上执行命令

  ```shell
  irun -h 
  
  -c cmds 远端执行的命令,长命令请用单引号,必选参数
  -p default=50 设定irun的并发数量，默认为50
  -u username 指定你有权限运行的账户，默认当前登录账户
  
  如:  irun -uxiaoju  -c " df -h |grep home " 
  ```
  
  
  
  ```sql
  irun -c  ' grep "6446aa145f3600f01eee0c8f05930002" /home/xiaoju/webroot/theone/log/webapp-v3/info.log'
  ```



* irun和issh的区别是  irun是并发执行且没有确认的步骤 ,所以 有些命令irun并不支持(如:rm/shutdown及通配符等)

 

* itail ---不会用

  ```shell
  查看ilist列表中机器nginx日志中200的流量单位s
  itail -s -f /home/xiaoju/nginx/logs/access.log -r '200' 
  ```

  

### xargs 

```shell
对缓存的命令转换成参数进行处理
https://www.jianshu.com/p/1d30c6d8c252
```





### find 查找文件命令

```shell
https://www.jianshu.com/p/a9651352f994
```

```shell
find [指定查找的名录] [查找的规则] [查找完成后要执行的action]
```

* [指定查找的名录]
  * 多个目录中间要加 空格
* [查找的规则]
  * 文件名  文件时间点 文件类型 文件大小 文件权限

* [查找完执行的action]

> -print                                 //默认情况下的动作
>  -ls                                     //查找到后用ls 显示出来
>  -ok  [commend]                //查找后执行命令的时候询问用户是否要执行
>  -exec [commend]              //查找后执行命令的时候不询问用户，直接执行

### 应用

* 找寻到此目录下所有的需要文件 （默认是递归的，但是可以限制递归的层数）

  ```shell
  find  .  -maxdepth 1  -name '*.txt'  |  xargs  -n  1  cat
  ```

  



### 统计 wc

- -c或--bytes或--chars 只显示Bytes数。
- -l或--lines 只显示行数。
- -w或--words 只显示字数。

```shell
wc testfile           # testfile文件的统计信息  
3 92 598 testfile       # testfile文件的行数为3、单词数92、字节数598 
```



### 去重 uniq

* -c或--count 在每列旁边显示该行重复出现的次数。

```shell
 sort testfile1 | uniq -c
   3 Hello 95  
   3 Linux 85 
   3 test 30
```



### 应用实例

```shell
#查处日志的一个请求量 
grep '10.79.41.16' didi.log | grep '04-18' | awk -F '|' '{print $15}' | sort | uniq -c
grep api_name xx.log| grep 500 | wc -l



示例： 
grep code2unionid /home/xiaoju/webroot/theone/log/webapp-v3/error.log.2020090211  | grep -oP 'errcode":\d+' | sort | uniq -c |sort -rn | head -n 2

grep -P 正则匹配 -o 仅仅打印匹配部分   | sort 之后按照字符排序之后才能 | uniq -c 进行不同的进行计数 | sort -n 按照number 进行匹配  -r 倒叙匹配  | head -n 10 取出前10行 ； 


```

```
grep pbs_webapp_message_reach /home/xiaoju/webapp-api/log/public.log |grep 'wxapp' | grep -v 'errcode=0' |grep -v 'errcode=43101' |grep -v 'errcode=10002' |grep -v 'errcode=43101' |grep -v '200003' |grep -v '200001' | grep -v '43004' | grep -oP 'errcode=\d+' |sort | uniq -c |sort -rn | head -n 10
```

```
grep pbs_webapp_message_reach /home/xiaoju/webapp-api/log/public.log |grep 'wxapp' | grep -v 'errcode=0' |grep -v 'errcode=43101' |grep -v 'errcode=10002' |grep -v 'errcode=43101' |grep -v '200003' |grep -v '200001' | grep -v '43004' | grep 47003
```





### 进行磁盘清理的相关操作

```shell
du -sh   查看当前文件夹的大小 
df -h 
```





```
sudo du -m --max-depth=1 .



139	./boot
6327	./etc
71704	./home
0	./lost+found
0	./media
0	./mnt
23	./opt
1	./root
1	./run
0	./srv
7435	./usr
501	./var

1	./sysadmin
1	./sysrd
1	./logger
66202	./xiaoju
5502	./odin








0	./.mozilla
6412	./work
54	./.composer
1	./.oracle_jre_usage
1	./.ssh
10	./apache-maven-3.3.9
180	./boostSDK
553	./ep
75	./git
26	./git-2.2.1
26	./godep
152	./gradle-2.9
1	./memcached
0	./perl5
20	./redis
17	./redis-old
21	./redis2.8
1019	./src
613	./tools
1	./user
45	./zookeeper-3.4.8
662	./.cache
1	./.dubbo
1051	./.glide
175	./.m2
568	./.nuwa
0	./.pki
289	./.rpc-tools
1	./.services
1	./.subversion
696	./athena-deploy
43	./charon
375	./cratos
77	./crius
43	./data-storage
543	./dbproxy_qiye
1	./didifarm_docker_set
1	./dos
0	./dpecosys
1	./elvish
1602	./es-tools
12	./es_api
1	./eslibs
7	./fastdev
57	./fastdev2
5230	./fukit
26	./geofence
280	./go
143	./hermes
1349	./iapetos
1	./iapetos_sh
4439	./kronos
0	./logs
28150	./mysql
6147	./mysql_qiye
212	./newpush
73	./newpushgo
61	./nginx
6	./nginx_qiye
14	./nuwa-php-code-coverage
107	./paris
164	./php
219	./php7
167	./pope
15	./redis_qiye
201	./search_qiye
0	./tmp
1	./tripcloud_docker_set
122	./unicorn
185	./zeus
115	./zeus-admin
45	./zeusworker
13	./env_detector
230	./buildEnvClient
189	./dws
0	./mis-script
2711	./athena
38	./dirpcgen
1	./xiaoju_cron_backup
0	./.config
156	./disf
0	./webroot
1	./.statsd
66202	.
```



### 待学习的命令： 

https://segmentfault.com/a/1190000015921775 

​        
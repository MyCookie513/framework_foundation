







## 目标：

> * 对于短时间的任务优先执行，可以提高整体任务的周转时间，而且IO交互型任务也需要我们高优跟进执行
> * 长时间的CPU密集型任务后置



## 两个指标：

* 周转时间
* 响应时间



## 几种调度方式：

* 先来先服务 ：周转时间比较高
* 最短任务优先 - 抢占式最短任务优先：响应时间较差
* 时间片轮转方式： 响应时间快，周转时间差
* 多级反馈队列（通过观察工作的运行来给出对应的调度优先级）：
  * 高优先级队列先执行
  * 在同一个队列中的任务，时间片轮转协议执行
  * 任务初始化时是最高优先级
  * 一个任务在运转完时间片后降一级，如果中途放弃则不降级
  * 每一个任务在一个队列中最长待得时间有限，到点必须降级，避免长期霸占高优队列
  * 经过一段时间后，重新评级，均移到高优队列（避免低级别队列长时间饥饿）
* 基于比例调度（彩票调度，步长调度）
  * 每个任务都有一个权重值，根据权重值来确定来调度谁以及调度多长时间
    * cfs-步伐调度： 根据总调度虚拟时间来确定调度谁，根据权重来确定调度多长时间
    * 彩票调度：调度时间都是一个时间片，调度谁是看谁中奖
* 多cpu
  * 每个cpu都有一个本地队列
  * 有steal机制





```

yanjianlong,liunaisen,zhangkunsvenkea,liyunfengk,chenzhanyuan,gengkang,xxukexin,kevinwangxiaoning,xiangkenan,liuleilucifer,zhouyugerry,nizeyang,zengzhi,qinguanri,zhangchengshuai,mingliuyiming,fairyliuming,liubofu,qinguanri,wencywuyuxuan,stoneshiyan,alexhan,gavinguobin,larrywangzhen,tanlianfang,songshiyun,xhuxu,zhaoguohao,tanlianfang,zhaoguohao,xusong,jiaoshupeng,zhangwenqi,duwei_i,wuhuan,lipeiran,zhenghang,dongliqiang,liangkeqiang,luoguohao,panjinlong,joewangxinlu,lizhengping,chenweishao,pengzhiwei

```












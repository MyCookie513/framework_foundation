## Ribbon 负载均衡   和 Retry 重试机制



### 负载均衡策略

* RandomRule ： 随机
* RoundRobinRule: 循环
* WeightedResponseTimeRule： 根据反应时间来定制权重，然后根据权重来挑选。
* BestAvailableRule： 公平原则，在可用的实例中，选取并发量最小的。
* hash分区  ，专人专用





### retry重试机制

* 配置

  ```yml
   ribbon:
      ConnectTimeout: 250 # Ribbon的连接超时时间
      ReadTimeout: 1000 # Ribbon的数据读取超时时间
      OkToRetryOnAllOperations: true # 是否对所有操作都进行重试
      MaxAutoRetriesNextServer: 1 # 切换实例的重试次数
      MaxAutoRetries: 1 # 对当前实例的重试次数
  ```


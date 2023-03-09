## Feign http客户端调用

​	

```java
@FeignClient("user-service")
public interface UserFeignClient {

    @GetMapping("/user/{id}")
    User queryUserById(@PathVariable("id") Long id);
}
```

* 首先这是一个接口，Feign会通过动态代理，帮我们生成实现类。这点跟mybatis的mapper很像

* 关键点

  + 集成了Ribbon的负载均衡以及retry机制
  + 集成了Hytrix的弹性熔断机制

* 配置

  ```yml
  ribbon:
    ConnectTimeout: 250 # 连接超时时间(ms)
    ReadTimeout: 2000 # 通信超时时间(ms)
    OkToRetryOnAllOperations: true # 是否对所有操作重试
    MaxAutoRetriesNextServer: 2 # 同一服务不同实例的重试次数
    MaxAutoRetries: 1 # 同一实例的重试次数
  hystrix:
    command:
    	default:
          execution:
            isolation:
              thread:
                timeoutInMillisecond: 6000 # 熔断超时时长：6000ms
  ```

  
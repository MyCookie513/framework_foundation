



* MaxIdle : 最大空闲数 

* IdleTimeout : 空闲超时时间

  ```
  在一个连接保持空闲 （IdleTimeout）时间后，我们将这个连接关闭。
  但是如果这个值设置为0的话，我们就不会将这个连接关闭。
  ```

* MaxActive : 最大活跃数

  ```
  Maximum number of connections allocated by the pool at a given time.
  When zero, there is no limit on the number of connections in the pool.
  ```

  * wait:是否是阻塞（只有在设置了最大活跃数之后才有效）

  ```
  在达到最大活跃限定值后，我们是否要继续进行等待，还是快速返回失败。
  ```

* MaxConnLifeTime : 最大的连接时长，可以理解为退休年龄

  

  


## Panic 

* 终止程序运行的一种函数

### 触发的时机

* 主动调用
* 系统自动调用
  + 程序在运行阶段碰到了内存异常的操作。 空指针，改写只读内存。



### 触发后进行的后续操作

* panic开始的地方启动终止程序操作。

* 调用当前触发panic函数里面的defer函数。

* 返回该函数的调用方，当作异常返回来处理，所以这一步也会调用调用方函数的defer，一直到没有调用方为止。

* 打印panic的信息。

* 打印堆栈跟踪信息，也就是我们看到的函数调用关系。

* 终止程序。



## recover 



* recover只能在defer函数中使用
* recover的使用必须与触发panic的协程是同一个。
* recover 将故障取出以后，程序继续正常运行。



### goroutine会维护自己的panic和recover 











## Panic：

1. 是否被终止（被其他的panic覆盖）
2. 是否被recover恢复
3. &nextPanic
4. Panic 参数





## recover：

1. Panic标记为被恢复，在跳出函数时从链表中被删除










## Sync.WaitGroup



### 实现思路：

有两个计数器: 等待协程数`v`，等待计数器`w`。

当执行`Add(n)`操作时，`v`加上传入的值，通常是1，表明有一个协程需要等待。

当执行`Wait`操作时，里面有一个死循环，会判断`v`的值是否为0。如果是，则表明等待的协程都执行完了，退出；如果不是0，则会将`w`计数器的值加1，执行`runtime_Semacquire`阻塞协程，减信号量。

当执行`Done`时，其本质是执行`Add(-1)`，这时候，将`v`减1。如果减了以后，`v`依然大于0，表明还有协程没完成，退出。否则，表明所有的协程都执行完成了，这时候会根据`w`数量，执行`runtime_Semrelease`加信号量。和前面的`runtime_Semacquire`方法一增一减，来控制等待，告知所有执行`Wait`阻塞的协程执行完毕了。

### 知识点准备：

##### Goroutine parking 让出调度函数

* runtime_Semrelease(s *uint32, lifo bool, skipframes int)
  * 对 s 这个信号量进行原子性增加，然后唤醒 acquire 的 Goroutine   

* runtime_Semacquire(s *uint32) 
  * 协程会阻塞到被唤醒，然后原子性减去 *S 信号量，然后Goroutine才原子性继续向下进行 ； 

##### 内存对齐： 

```c

import (
    "fmt"
    "unsafe"
)

type T struct {
    a byte // byte类型占用1个字节
    b int32 // int32占用4个字节
    c int8 // int8占用1个字节
}

func main() {
    t := T{}
    fmt.Printf("t size : %d, aligh = %d\n", unsafe.Sizeof(t), unsafe.Alignof(t))
}
```

按照各个类型占用的大小相加，1+4+1=6，可能会得出这个结构体占用6个字节的结论。然而实际上不是的，最终输出的结果是12！

* 为什么要将struct 中不足的变量也按照最大的变量所占用的内存块进行存储呢？

  >第一： 操作系统读取内存块的大小称为访问粒度，不同系统不一样；比如： 读取内存的时候，一次性读取4个字节
  >
  >第二： 如果不使用内存对齐的话，在访问该变量时，读取4个字节后，另外2个字节还需要额外剔除掉，这就会对性能造成一点点影响。如果执行内存对齐，则填充2个字节，只需要访问一次，不需要额外操作就可以获取该变量了。
  >
  >第三： 内存占用优化，小的变量放在一起



##### 利用unsafe.Pointer 类型强转直接操作内存： 

>任何指针类型都可以转换成Pointer，Pointer可以转换成任意的指针类型
>
>任意指针类型 -> Pointer -> 任意指针类型 
>
>- uintptr可以被转化为Pointer
>- Pointer可以被转化为uintptr

```c
a := [3]int32{1,2,3}

# 3 * 32位    
000...001   000...010   000...100      
  
# 利用Pointer转换成了另一种指针，重新对内存进行解释
b := (*uint64)(unsafe.Pointer(&a)) 
  
fmt.Println(*b) // 8589934593: 000...001  000...010
```



##### 内存寻址： 

```c
type T struct {
	noCopy struct{}
	state1 [3]uint32
}
# uintptr 会得到一个内存地址， 这个内存地址就是对在内存中 第多少个字节进行标注的；
0 byte
1 byte 等等
  ，，，
# 32位系统是   内存访问粒度 ： 4byte
# 64 位       内存访问粒度 ： 8byte 
# 所以： uintptr(unsafe.Pointer(&t.state1))  为一个8字节内存块的起点，所以 %8 == 0
```
























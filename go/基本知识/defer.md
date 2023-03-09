## defer 的使用详解



### 触发defer的时机

* 函数运行到末尾

* 函数进行return

* panic

  

### defer在匿名返回值和命名返回值函数中的不同表现

```go
func returnValues() int {
    var result int
    defer func() {
        result++
        fmt.Println("defer")
    }()
    return result
}

func namedReturnValues() (result int) {
    defer func() {
        result++
        fmt.Println("defer")
    }()
    return result
}
```



* 函数会在return之前进行触发defer的运行
* 匿名返回值
  + 将result赋值给返回值（可以理解成Go自动创建了一个返回值retValue，相当于执行retValue = result）
  + 然后检查是否有defer，如果有则执行
  + 返回刚才创建的返回值（retValue）
* 命名返回值
  + result就是retValue，defer对于result的修改也会被直接返回。



### 在for循环中连环使用defer 耗费一部分资源

```go
func deferInLoops() {
    for i := 0; i < 100; i++ {
        f, _ := os.Open("/etc/hosts")
        defer f.Close()
    }
}
```

* defer会对其后需要的参数进行内存拷贝，还需要对defer结构进行压栈出栈操作。





### 判断执行没有出错之后，在defer释放资源

>一些获取资源的操作可能会返回err参数，我们可以选择忽略返回的err参数，但是如果要使用defer进行延迟释放的的话，需要在使用defer之前先判断是否存在err，如果资源没有获取成功，即没有必要也不应该再对资源执行释放操作。如果不判断获取资源是否成功就执行释放操作的话，还有可能导致释放方法执行错误。

```go
resp, err := http.Get(url)
// 先判断操作是否成功
if err != nil {
    return err
}
// 如果操作成功，再进行Close操作
defer resp.Body.Close()
```



### os.Exit(0)时defer不会被执行

```go
func deferExit() {
    defer func() {
        fmt.Println("defer")
    }()
    os.Exit(0)
}
```



## defer历史演进：

1. 在堆上生成defer结构体链表，栈和堆之间来回copy

   -》 演进为单纯在栈上生成

   ​    -》 演进为编译器添加到函数底部（仍然会保留defer链表的模式（比如for循环defer的时候））



## 闭包 ：

> 是将变量和函数进行引用存储为一个struct。








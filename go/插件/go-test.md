## Go Test

### Test table 结果的正确率 

```
go test . 
```



### 查看代码的覆盖率

```shell
go test -coverprofile=coverprofile  //生成对覆盖率的分析文件
go tool cover -html=coverprofile
```



### test 代码的运行效率 

```
go test -bench . 
```



### 查看代码性能耗时在哪

```
go test -bench  . -cpuprofile cpu.out   //生成耗时文件

go tool pprof cpu.out //利用pprof 来解析这个文件 

(pprof) web > out.svg //形成耗能拓扑图
```



### 批量test：

```go
func BenchmarkDirectCall(b *testing.B) {
	c := Cat{Name: "draven"}
	for n := 0; n < b.N; n++ {
		// MOVQ	AX, (SP)
		// MOVQ	$6, 8(SP)
		// CALL	"".Cat.Quack(SB)
		c.Quack()
	}
}

func BenchmarkDynamicDispatch(b *testing.B) {
	c := Duck(Cat{Name: "draven"})
	for n := 0; n < b.N; n++ {
		// MOVQ	16(SP), AX
		// MOVQ	24(SP), CX
		// MOVQ	AX, "".d+32(SP)
		// MOVQ	CX, "".d+40(SP)
		// MOVQ	"".d+32(SP), AX
		// MOVQ	24(AX), AX
		// MOVQ	"".d+40(SP), CX
		// MOVQ	CX, (SP)
		// CALL	AX
		c.Quack()
	}
}
```

##### cpu 一个，每个test执行3遍 ， 执行时间为1s:

```go 
go test -gcflags=-N -benchmem -test.count=3 -test.cpu=1 -test.benchtime=1s -bench=. 
```




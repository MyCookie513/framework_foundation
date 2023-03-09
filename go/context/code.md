```c

package main

import (
	"context"
	"fmt"
	"sync"
	"time"
)

func LogT(msg string) {
	fmt.Println(time.Now().Format("2006-01-02 15:04:05") + " : " + msg)
}

func ToughJob(s time.Duration, ch chan int, name string) {
	time.Sleep(time.Second * s)
	LogT("job " + name + " Done")
	ch <- 1
}

// 能够在主进程超时之前完成任务
func A(ctx context.Context) {
	defer wg.Done()
	// 子节点 A
	aCtx, _ := context.WithCancel(ctx)
	fmt.Println("A task is doing")
	ch := make(chan int)
	//todo 但是这个结束了A函数，但是tough job 任务还是在执行啊？？？
	go ToughJob(2, ch, "A main")

	select {
	case <- ch:
		LogT("A Done")
		// 监测上游节点是否有结束的信息传来 ；
	case <- aCtx.Done():
		LogT("A Cancel notified by up point ")
	}
}

func B(ctx context.Context) {
	defer wg.Done()

	bCtx, cancel := context.WithCancel(ctx)

	fmt.Println(" B task is doing ")
	ch := make(chan int)
	go ToughJob(5, ch, "B")

	/*go func() {
		time.Sleep(time.Second)
		cancel()
	}()*/

	select {
	case <- ch:
		LogT("B main task Done")
		// do B1, B2   B的任务完成后， 有新加了 两个子任务 ；
		wg.Add(2)
		go Bb(bCtx, "B1")
		go Bb(bCtx, "B2")

		//  监控上游的取消任务 ；
	case <- ctx.Done():
		LogT("B task is Canceled by up point")
		cancel()
	}


}

func Bb(ctx context.Context, name string) {
	defer wg.Done()
	fmt.Println("B 子任务 "+name+" doing ")
	select {
	case <- time.After(time.Second * 2):
		LogT("B 子任务 job " + name + " Done")
	case <- ctx.Done():
		LogT(name + " 子任务 is Canceled by up point ")
	}
}

var wg = sync.WaitGroup{}

func main() {
	LogT("start")
	ctx, cancel := context.WithCancel(context.Background())
	wg.Add(2)


	go A(ctx)
	go B(ctx)

	//todo 超时限制 如果超时超过三秒   就手动进行取消
	go func() {
	   time.Sleep(time.Second*3)
	   cancel() //未完成的直接结束就ok了
	   LogT("main context timeout cancel ")
	}()

	// 进程执行到这里就parking 需要等待两个子进程执行完毕
	wg.Wait()

	LogT("end")

}

```


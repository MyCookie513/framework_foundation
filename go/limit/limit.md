



### 结构：

```go
type Limiter struct {
	limit Limit
	burst int // 桶的总大小

	mu     sync.Mutex
	tokens float64 // 桶中目前剩余的token数目，可以为负数。
	// last is the last time the limiter's tokens field was updated
	last time.Time
	// lastEvent is the latest time of a rate-limited event (past or future)
	lastEvent time.Time
}

```



### AllowN：

> 截止到某一时刻，目前桶中数目是否至少为 n 个，满足则返回 true，同时从桶中消费 n 个 token。
> 反之返回不消费 Token，false。

```go
func (lim *Limiter) Allow() bool
func (lim *Limiter) AllowN(now time.Time, n int) bool
```



##### Reservation 预定token： 

```go
type Reservation struct {
   ok        bool   // 是否能提供这些数量的token
   lim       *Limiter
   tokens    int   // 预定了多少个token
   timeToAct time.Time // 这些token在那个时间才能使用
   // This is the Limit at reservation time, it can change later.
   limit Limit
}
```



```go
lim.last = now    // 
lim.tokens = tokens
lim.lastEvent = r.timeToAct
```






















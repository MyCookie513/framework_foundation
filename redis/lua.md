### LUA 脚本运行





在 Lua 脚本中，可以使用两个不同函数来执行 Redis 命令，它们分别是：

- `redis.call()` : 在执行命令的过程中发生错误时，脚本会停止执行,并返回错误
- `redis.pcall()`: 在执行命令的过程中发生错误时，脚本不会停止执行，只是记录下错误

这两个函数的唯一区别在于它们使用不同的方式处理执行命令所产生的错误



redis 如果是集群的话：lua 脚本只能操作一个key ；





### 脚本的原子性:

Redis 使用单个 Lua 解释器去运行所有脚本，并且， Redis 也保证脚本会以原子性(atomic)的方式执行：当某个脚本正在运行的时候，不会有其他脚本或 Redis 命令被执行。这和使用 [MULTI](http://redisdoc.com/transaction/multi.html#multi) / [EXEC](http://redisdoc.com/transaction/exec.html#exec) 包围的事务很类似。在其他别的客户端看来，脚本的效果(effect)要么是不可见的(not visible)，要么就是已完成的(already completed)。

另一方面，这也意味着，执行一个运行缓慢的脚本并不是一个好主意。写一个跑得很快很顺溜的脚本并不难，因为脚本的运行开销(overhead)非常少，但是当你不得不使用一些跑得比较慢的脚本时，请小心，因为当这些蜗牛脚本在慢吞吞地运行的时候，其他客户端会因为服务器正忙而无法执行命令。





```
eval " redis.call('set',KEYS[1],'bar') redis.call('get','bar') redis.call('set','ok','ok1')" 1 foo
```

```
if redis.call('get',KEYS[1],ARGV[1],'EX',ARGV[2],'NX') then 
	        return 1 
        elseif redis.call('get',KEYS[1]) == ARGV[1] then 
	        if redis.call('expire',KEYS[1], ARGV[2]) then 
		        return 2 
	        else 
		        return 3 
	         end 
        else 
	         return 4
        end
        
        
        
        
        
        if redis.call('get',KEYS[1])  >= ARGV[1] then  
          return 10 // 票已经卖没了
        elseif redis.call('INCRBY',KEYS[1], ARGV[2]) > ARGV[1] then  // 有票 ，尝试去买票
          return 11 // 抢票过程中余票不够
        else 
          return 1  // 买票成功
        
        
        
        
```

```

    eval "if tonumber(redis.call('get',KEYS[1]) >= ARGV[1]) then return 10 else  return 0 end" 1 aaa 2
```

```


local total  = tonumber(ARGV[1]) 
local want  = tonumber(ARGV[2])
local current = tonumber(redis.call('get', KEYS[1]) or "0")
if current + want > total  then return 2  else return redis.call('INCRBY',KEYS[1],want)


```


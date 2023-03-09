

## 使用场景：

> 在DAO层 我们经常有这样的需求，
>
> 避免请求下游频繁， 对获取的数据加一层cache的功能，
>
> 但是 cache 是有有效期的， 当缓存无效时，会面临大量请求下游的情况
>
> 针对这种场景，我们可以 CacheCenter 组件来进行托管 来满足需求。

## 使用说明：

### 建议一个服务创建一个cache center：

```go
var c *cacheCenter.Center
var once = sync.Once{}

func NewCacheCenter() *cacheCenter.Center{
	once .Do(func() {
		 c = cacheCenter.NewCenter(redis.RedisClient,log.Trace)
	})
	return c
}
```



### 在DAO层进行使用：

* 请求下游函数

```go
func (c *DAO) GetWechatPopupManagerByIDFromDB(ctx context.Context, id int64) (*popupManager.WechatPopupManager, error) {
	ret := &popupManager.WechatPopupManager{}
	err := c.DB.Where("id = ?", id).First(&ret).Error
	if err != nil {
		if !gorm.IsRecordNotFoundError(err) {
			log.Trace.Errorf(ctx, legoTrace.DLTagMysqlFailed, "id=%d||err=%s", id, err)
		}
	}
	return ret, err
}
```

* 增加cacheCenter功能：

```go
func (c *DAO) GetWechatPopupManagerByIDFromCache(ctx context.Context, id int64) (*popupManager.WechatPopupManager, error) {

  // 缓存中进行存储的key值名称，以及最终取得结果放入v值中
	k := fmt.Sprintf(cacheConsts.PopupManagerIdTpl, id)
	v := popupManager.WechatPopupManager{}

  // 底层进行获取数据的方法
	getValueFunc := func() (interface{}, error) {
		return c.GetWechatPopupManagerByIDFromDB(ctx, id)
	}

  // 会将从cache中获取的值Unmarshal到 v 中
	err := util.NewCacheCenter().NewCacheKey(ctx, k, getValueFunc).GetValue(ctx, &v).Err

	return &v, err
}
```



### 扩展：

* 将数据Unmarshal到 v 值，同时将运转的详细信息返回，比如 运行出错信息，缓存不可用错误(会自动打印日志，降级处理)，Unmarshal错误等

```go
	detail := util.NewCacheCenter().NewCacheKey(ctx, k, getValueFunc).GetValue(ctx, &v)
```

```go
// 获取value的详情结果
type Details struct {
	Err        error // 运行出错，获取value失败
	through    bool  // 是否击穿缓存
	degradeErr error // cache 组件不可用导致的降级处理，依旧能够获取到结果，此错误不为nil标识已降级，解释降级原因
}
```

*  上报 metric : 多少次击穿缓存 ，多少次运行出错 

```go
	detail.ReportMetric(v.TableName())
```

*  CacheManager 可实现 MissedKey 接口，自定义判定IsMissedKeyError

```go
type MissedKey interface {
   IsMissedKeyError(err error) bool
}
```






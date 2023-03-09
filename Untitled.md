<<<<<<< HEAD

=======
>>>>>>> 
>>>>>>>
>>>>>>> 







## 计算机网络：

<<<<<<< HEAD
```
https://leetcode-cn.com/leetbook/detail/networks-interview-highlights/

【计算机网络笔记Part1 概述】      https://blog.csdn.net/weixin_45067603/article/details/106974036
【计算机网络笔记Part2 物理层（Physical Layer）】    https://blog.csdn.net/weixin_45067603/article/details/106974965
【计算机网络笔记Part3 数据链路层（Data Link Layer）】    https://blog.csdn.net/weixin_45067603/article/details/106980441
【计算机网络笔记Part4 网络层（Network Layer）】    https://blog.csdn.net/weixin_45067603/article/details/106993253
【计算机网络笔记Part5 传输层（Transport Layer）】    https://blog.csdn.net/weixin_45067603/article/details/107034202
【计算机网络笔记Part6 应用层（Application Layer）】    https://blog.csdn.net/weixin_45067603/article/details/107053479
https://www.bilibili.com/video/BV19E411D78Q?from=search&seid=9455518873909912088&spm_id_from=333.337.0.0
```
=======
## 计算机网络：
>>>>>>> 6fdd9221f97d36b3d7247534a17db67d5efccdc3

```
https://leetcode-cn.com/leetbook/detail/networks-interview-highlights/

【计算机网络笔记Part1 概述】      https://blog.csdn.net/weixin_45067603/article/details/106974036
【计算机网络笔记Part2 物理层（Physical Layer）】    https://blog.csdn.net/weixin_45067603/article/details/106974965
【计算机网络笔记Part3 数据链路层（Data Link Layer）】    https://blog.csdn.net/weixin_45067603/article/details/106980441
【计算机网络笔记Part4 网络层（Network Layer）】    https://blog.csdn.net/weixin_45067603/article/details/106993253
【计算机网络笔记Part5 传输层（Transport Layer）】    https://blog.csdn.net/weixin_45067603/article/details/107034202
【计算机网络笔记Part6 应用层（Application Layer）】    https://blog.csdn.net/weixin_45067603/article/details/107053479
https://www.bilibili.com/video/BV19E411D78Q?from=search&seid=9455518873909912088&spm_id_from=333.337.0.0
```




## mysql：

<<<<<<< HEAD
```
https://www.bilibili.com/video/BV19v411N7kU?p=2
https://www.bilibili.com/video/BV1Hy4y177B4?from=search&seid=12673040666182293959&spm_id_from=333.337.0.0
=======
## mysql：
>>>>>>> 6fdd9221f97d36b3d7247534a17db67d5efccdc3

```
https://www.bilibili.com/video/BV19v411N7kU?p=2
https://www.bilibili.com/video/BV1Hy4y177B4?from=search&seid=12673040666182293959&spm_id_from=333.337.0.0

主从同步原理：
https://www.bilibili.com/video/BV1yv41187tV?p=14
https://www.bilibili.com/video/BV1Ut411k7XU?from=search&seid=6548217999121214627&spm_id_from=333.337.0.0

主从同步原理：
https://www.bilibili.com/video/BV1yv41187tV?p=14
https://www.bilibili.com/video/BV1Ut411k7XU?from=search&seid=6548217999121214627&spm_id_from=333.337.0.0


rpc ： 
https://www.bilibili.com/video/BV1Fm4y1Q7KT?from=search&seid=2886594472820475023&spm_id_from=333.337.0.0
```

<<<<<<< HEAD
## Code : 

```
package logic

import (
	"context"
	"encoding/base64"
	"fmt"
	"math"
	error2 "routerApi/idl/error"
	"strconv"
)

func getCidFromOid(ctx context.Context, oid string) (cid int64, err error) {

	var tmp []byte
	tmp, err = base64.StdEncoding.DecodeString(oid)
	if err != nil {
		return 0, err
	}
	
	tmp, err = base64.StdEncoding.DecodeString(string(tmp))
	if err != nil {
		return 0, err
	}
	
	oidNumber, err := strconv.ParseInt(string(tmp), 10, 64)
	if err != nil {
		return 0, err
	}
	
	oid = decbin(float64(oidNumber))
	oidByte := []byte(oid)
	sDistrict, err := strconv.ParseInt(string(oidByte[19:33]), 2, 64)
	sDistrictStr := fmt.Sprintf("%04d", sDistrict)
	if err != nil {
		return 0, err
	}
	sDistrictByte := []byte(sDistrictStr)
	if sDistrictByte[0] == '0' && sDistrictByte[1] == '0' {
		sDistrictStr = fmt.Sprintf("%03d", sDistrict)
	}
	
	if cid, ok := cityList[sDistrictStr]; ok {
		return cid, nil
	}
	return 0, error2.GrpcNOMAPCID
}

func decbin(oid float64) (res string) {

	for oid != 0 {
		div := oid / 2
		intNumber, frac := math.Modf(div)
		oid = intNumber
		math.Ceil(frac)
		res = fmt.Sprintf("%f%s", math.Ceil(frac), res)
	}
	strNum := fmt.Sprintf(res, "s")
	
	zero := 64 - len(strNum)
	var tmp string
	for i := 0; i < zero; i++ {
		tmp = fmt.Sprintf("%s%c", tmp, '0')
	}
	res = fmt.Sprintf("%s%s", res, strNum)
	return
}

```
=======
rpc ： 
https://www.bilibili.com/video/BV1Fm4y1Q7KT?from=search&seid=2886594472820475023&spm_id_from=333.337.0.0
```

## Code : 

```
https://leetcode-cn.com/company/tencent/problemset/
```
>>>>>>> 6fdd9221f97d36b3d7247534a17db67d5efccdc3





1. 盛水最多的容器
2. 相交链表
3. 排序链表









```

curl -X POST http://localhost:8080/uploadImages \
  -F "upload=@/Users/didi/Documents/WechatIMG18.jpeg" \
  -F "upload=@/Users/didi/Documents/WechatIMG20.jpeg" \
  -F "upload=@/Users/didi/Documents/WechatIMG22.jpeg" \
  -H "Content-Type: multipart/form-data"
  
  
  
```


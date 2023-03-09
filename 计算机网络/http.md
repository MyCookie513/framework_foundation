

## HTTP



### http错误码：

>1xx :  信息提示： 服务受到请求后希望客户端能够继续操作
>
>* 例如： 希望切换为http的更高版本的协议
>
>2xx : 服务端接受并且成功处理了请求
>
>3xx : 服务端表示这个url重定向到了另一个地址
>
>* 301 ： 永久性重定向
>* 302 ： 临时性重定向

* 请求过程中，出现错误了，是谁的问题呢？
  * 4xx ：客户端的问题，客户端发送的请求协议不搭配等问题
    * 400 : bad request , 请求发起的语法错误，服务端无法理解
    * 401 : 客户端没有进行身份认证 
    * 403 : forbidden , 服务端被禁止的
    * 404 : url 错误
    * 405 : 请求方法错误
    * 499 : 客户端设置的超时时间短提前返回了
  * 5xx : 服务端的锅
    * 500 ： 服务端内部出现了panic
    * 501 ； 服务器未实现这个功能
    * 502 ： gateway feel bad ， 网关收到无法解析的请求
    * 503 ： 服务器在维护中
    * 504 ： timeOut , 网关发现 server 处理超时，给客户端回执 504 网关超时
    * 505 ： http协议的版本不支持





### 请求报文

*  请求行
  + 来记录当前发起请求的信息，比如URI,请求方法，HTTP版本等
* 请求的首部字段
* 请求实体内容



### 响应报文

* 响应行
  + 内部记录了响应结果的状态码，成功/失败的原因说明，以及服务端返回的HTTP版本等
* 响应首部
* 响应实体



### HTTP首部字段

##### 通用首部字段：即请求报文和响应报文都可以配置的首部字段

* cache-control ： 缓存行为控制

  > Cache-Control: private, no-cache, no-store, proxy-revalidate, no-transform

  ![img](https://pic2.zhimg.com/80/v2-43a10fcb90be475b8e5b171925c520a9_1440w.jpg)

+ date : 创建报文的时间



##### 当客户端发起请求的时候特有的首部

+ Accept ： 用户代理可以处理的媒体类型

  ![img](https://pic1.zhimg.com/80/v2-0eb9878c5fcba809fdba9461f1986d2c_1440w.jpg)

+ Accept-charset : 优先的字符集

+ Accept-Encode : 优先的内容编码

+ Accept-language:优先的语言

+ User-agent : 用户端发起请求使用的工具

+ Referer ：

+ Origin: http://manage.leyou.com

##### 响应的首部字段

+ accept-Ranges ： bytes

预检请求的响应header： 

+ Access-Control-Allow-Origin：可接受的域，是一个具体域名或者*，代表任意
- Access-Control-Allow-Methods：允许访问的方式
- Access-Control-Allow-Headers：允许携带的头
- Access-Control-Max-Age：本次许可的有效时长，单位是秒


​       允许客户端可以携带Cookie
- Access-Control-Allow-Credentials：是否允许携带cookie，默认情况下，cors不会携带cookie，除非这个值是tru





##### 实体配置首部字段：为了传输实体而出现的属性配置

+ content-type ： 实体的媒体类型

  > Content-Type:multipart/form-data       or      application/json  。。。   

+ content-length ： 实体的大小byte

+ content-language：实体对应的语言

+ content-Encode: 实体的编码方式

+ Last-modify ： 实体的最后修改时间

+ Expire ： 实体的过期时间



### Https:

![preview](https://pic1.zhimg.com/v2-3a29fa5933d6440f25a394a3337590cb_r.jpg?source=1940ef5c)
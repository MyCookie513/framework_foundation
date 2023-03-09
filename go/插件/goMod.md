## go mod 使用



### GO111MODULE 环境变量

* 1.11(及其以上版本将会自动支持gomod) 默认GO111MODULE=auto(auto是指如果在gopath下不启用mod)

  ```
  off ： GOPATH 模式，自动vendor 和gopath的目录下去寻找文件 
  
  on  ： 屏蔽GOPATH目录， module模式
  
  auto： 如果此目录不在GOPATH目录下，并且有xxx.mod 文件，这样的话就是module模式，否则为GOPATH模式
  ```

  

### 常用的几个命令

>go mod download  下载模块到本地缓存，缓存路径是 `$GOPATH/pkg/mod/cache`
>
>go mod graph 把模块之间的依赖图显示出来
>
>go mod init 初始化模块（例如把原本dep管理的依赖关系转换过来）
>
>go mod tidy 增加缺失的包，移除没用的包

> go build    or    go test 
>
> 下载并且添加依赖到 go.mod 文件中 

>go list -m all 

### **GOSUMDB 变量的意义**

![image-20200810134220310](../image/image-20200810134220310.png)


















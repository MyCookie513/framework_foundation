## php中关键字区别理解





## new static 和new self的区别

* new self
  + 返回的是写这段代码归属的类（new self ）
* new static 
  + 返回的是调用这段代码的类





### require 和 include

* 从名字可以看出容错性不同，处理文件错误的机制上面不同
  + require() :如果文件不存在，会报出一个fatal error.脚本停止执行;
  + include() : 如果文件不存在，会给出一个 warning，但脚本会继续执行;
* require只初始化一次，include每次调用都要重新加载
  对include()来说，在include()执行时文件每次都要进行读取和评估;
  对require()来说，文件只处理一次(实际上，文件内容替换了require()语句)。








sim 上游的rewrite 

```nginx 
 rewrite ^/common/(.*)$ /$1 break;
```





### 线上 和docker 环境的对比 ？？？：

* 线上

```nginx
        location ~ ^/(webapp|internal/webapp) {
            rewrite ^/(.*)$ /theone/webapp-v3/index.php/$1 break;
            root /home/xiaoju/webroot/;
            fastcgi_index index.php;
            fastcgi_pass 127.0.0.1:9000;
            include fastcgi.conf;
        }

```

* docker 

```nginx
location ~ ^/webapp/(wallet|platform|config|pages|activities|security) {
            rewrite ^/webapp/(.*)$ /theone/webapp-v3/index.php/$1 break;
            root /home/xiaoju/webroot/;
            fastcgi_index index.php;
            fastcgi_pass 127.0.0.1:9000;
            include fastcgi.conf;
}
```



* Test 

  ```
  curl   -X POST 10.96.81.8:8080/webapp2/testA/orderInfo.php
  ```

  


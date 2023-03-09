## PHP Router 





### 单一入口思路

* 访问http://framework.app/about.php这条路径时，nignx进行重写，先进入到 `index.php` 中
* 然后在 `index.php` 中会通过一些方法去找到与这条路由对应需要执行的文件，一般我们会把这些文件放到控制器中。



### Router.php

```php
<?php
class Router
{
    protected $routes = [
        'GET'   => [],
        'POST'  => []
    ];
    public function get($uri, $controller)
    {
        $this->routes['GET'][$uri] = $controller;
    }
    // 当定义POST路由时候，把对应的$uri和$controller以健值对的形式保存在$this->routes['POST']数组中
    public function post($uri, $controller)
    {
        $this->routes['POST'][$uri] = $controller;
    }
    /**
     * 赋值路由关联数组
     * @param $routes
     */
    public function define($routes)
    {
        $this->routes = $routes;
    }
    /**
     * 分配控制器路径
     * 通过用户输入的 uri 返回对应的控制器类的路径
     * @param $uri
     * 这里的 $requestType 是请求方式，GET 或者是 POST
     * 通过请求方式和 $uri 查询对应请求方式的数组中是否定义了路由
     * 如果定义了，则返回对应的值，没有定义则抛出异常。
     * @return mixed
     * @throws \Exception
     */
    public function direct($uri, $requestType)
    {
        if(array_key_exists($uri, $this->routes[$requestType]))
        {
            return $this->routes[$requestType][$uri];
        }
       // 不存在，抛出异常，以后关于异常的可以自己定义一些，比如404异常，可以使用NotFoundException
        throw new Exception('No route defined for this URI');
    }
    public static function load($file)
    {
        $router = new static;
        // 调用 $router->define([]);
        require ROOT . DS . $file;
        // 注意这里，静态方法中没有 $this 变量，不能 return $this;
        return $router;
    }
}
```

### routes.php 规则

```php
$router->get('', 'controllers/index.php');
$router->get('about', 'controllers/about.php');
$router->get('contact', 'controllers/contact.php');
$router->post('tasks', 'controllers/add-task.php');
```



### index.php 入口文件实际调用过程

```php
<?php
// 定义分隔符常量
define('DS', DIRECTORY_SEPARATOR);
// 定义根目录常量  // D:\xampps\htdocs\web\Frame
define('ROOT', dirname(__FILE__));
$query = require ROOT . DS . 'core/bootstrap.php';
**加载router配置规则，然后跟据这次请求找到匹配到的目标文件进行运行**
require Router::load('routes.php')
    ->direct(Request::uri(), Request::method());
```









### composer 自动加载

* **将namespace//classname => 与实际的文件目录所对应起来。 这样use namespace//classname这个时候就能加载这个文件。**
* 只能将类文件自动加载，其他文件不会进行引入的，如 function.php不会被引入，如果需要，则仍需要使用手动 require 引入
* `composer dump-autoload` 来重新生成`autoload_classmap.php`文件


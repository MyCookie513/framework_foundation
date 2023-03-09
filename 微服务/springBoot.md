## SpringBoot 

* *@configuration配置在类上，就相当于spring的xml文件的《beans》标签。作用为配置spring 容器（应用上下文）*



### SpringBoot的特点

* 解决了大部分框架复杂的配置的问题
* 解决了各个版本包之间的复杂匹配的问题
  + *spring-boot-starter-parent配置，里面已经对各种常用依赖（并非全部）的版本进行了管理，我们的项目需要以这个项目为父工程，这样我们就不用操心依赖的版本问题了，需要什么依赖，直接引入坐标即可！*

### SpirngBoot中配置的引入



* 创建配置类

  ```java
  @ConfigurationProperties(prefix = "jdbc")
  public class JdbcProperties {
      private String url;
      private String driverClassName;
      private String username;
      private String password;
      // ... 略
      // getters 和 setters
  }
  ```

* 在创建Bean的时候启用这个配置类

  ```java
  @Configuration
  @EnableConfigurationProperties(JdbcProperties.class)
  public class JdbcConfig {
  
      @Bean
      public DataSource dataSource(JdbcProperties jdbc) {
          DruidDataSource dataSource = new DruidDataSource();
          dataSource.setUrl(jdbc.getUrl());
          dataSource.setDriverClassName(jdbc.getDriverClassName());
          dataSource.setUsername(jdbc.getUsername());
          dataSource.setPassword(jdbc.getPassword());
          return dataSource;
      }
  }
  ```

* 引入这个配置类的方法有

  + @Autowired 属性注入
  + @Bean标注的方法参数的引入
  + 构造器参数引入



* 还有一种比较方便的引入配置文件的方式

  ```java
  @Configuration
  public class JdbcConfig {
      
      @Bean
      // 声明要注入的属性前缀，SpringBoot会自动把相关属性通过set方法注入到DataSource中
      @ConfigurationProperties(prefix = "jdbc")
      public DataSource dataSource() {
          DruidDataSource dataSource = new DruidDataSource();
          return dataSource;
      }
  }
  ```





### SpringBoot自动配置原理

* *SpringBoot内部对大量的第三方库或Spring内部库进行了默认配置，这些配置是否生效，取决于我们是否引入了对应库所需的依赖，如果有那么默认配置就会生效*

* 其实在我们的项目中，已经引入了一个依赖：spring-boot-autoconfigure，其中定义了大量自动配置类：非常多，几乎涵盖了所有的主流框架的配置；

* 已经配置好的是这些配置属性是否起作用的判断条件：

  ```java
  `@ConditionalOnWebApplication(type = Type.SERVLET)`
  `@ConditionalOnClass({ Servlet.class, DispatcherServlet.class, WebMvcConfigurer.class })`
  `@ConditionalOnMissingBean(WebMvcConfigurationSupport.class)`
  
  ```

  




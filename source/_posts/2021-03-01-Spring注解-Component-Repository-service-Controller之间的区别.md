---
title: Spring注解 @Component @Repository @service @Controller之间的区别
comments: true
date: 2021-03-01 17:58:07
tags:
    - Java
    - Spring
    - 注解
categories:
    - [指尖飞舞, Project]
---
__摘要：__
[待完善] 这四个注解主要作用。
<!-- more -->


### 区别与联系
`@Component` 、 `@Repository` 、 `@Service` 、 `@Controller` 都是用来自动注册bean的。
在 `SpringApplication.run()` 启动的时候，spring会自动创建一个IOC容器，并且为IOC容器自动扫描配置类所在包以及子包下的所有被以上四个注解标注的类。
区别在于：
`@Service` 用于标注业务层组件 
`@Controller` 用于标注控制层组件（如struts中的action），处理请求。
`@Repository` 用于标注数据访问组件，即DAO组件
`@Component` 泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注，在以上三种任意地方使用。

{% note primary %}
__转载链接：__ [呵呵一笑很倾城 | 知乎](https://zhuanlan.zhihu.com/p/28346387)
{% endnote %}
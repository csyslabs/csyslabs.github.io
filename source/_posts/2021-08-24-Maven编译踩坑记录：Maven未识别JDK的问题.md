---
title: Maven编译踩坑记录：Maven未识别JDK的问题
comments: true
date: 2021-08-24 10:40:52
tags:
    - 工程
    - Maven
    - 异常
categories:
    - [指尖飞舞, 工程, 异常]
---
__摘要：__
记一次mvn编译时踩的坑。
<!-- more -->

### 情况描述

当我在使用 `mvn tomcat7:run` 编译的时候，出现提示：
`No compiler is provided in this environment. Perhaps you are running on a JRE rather than a JDK?`

### 问题解决
问题在于没有配置JDK环境变量。
1. 查看JDK目录，执行：`$ /usr/libexec/java_home -V`
得到：
```bash
Matching Java Virtual Machines (2):
    1.8.301.09 (x86_64) "Oracle Corporation" - "Java" /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
    1.8.0_301 (x86_64) "Oracle Corporation" - "Java SE 8" /Library/Java/JavaVirtualMachines/jdk1.8.0_301.jdk/Contents/Home
/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
```
可知，我们的JDK目录位于：
```
1.8.0_301 (x86_64) "Oracle Corporation" - "Java SE 8" /Library/Java/JavaVirtualMachines/jdk1.8.0_301.jdk/Contents/Home
```
2. 配置JDK环境变量，执行：
```bash
$ open -e .bash_profile
```
3. 在.bash_profile中添加：
```
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_301.jdk/Contents/Home
```
4. 执行：`$ source .bash_profile`使之生效.
5. 执行：`echo $JAVA_HOME`查看是否生效。

### 问题回溯

其实问题的本质就是maven找不到JDK，配置一下JDK环境变量即可。

{% note primary %}
__参考：__ [Mac 配置JDK环境变量](https://juejin.cn/post/6844903878694010893)
{% endnote %}
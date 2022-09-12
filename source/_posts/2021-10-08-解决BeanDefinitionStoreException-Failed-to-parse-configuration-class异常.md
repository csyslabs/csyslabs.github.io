---
title: '解决BeanDefinitionStoreException: Failed to parse configuration class异常'
comments: true
date: 2021-10-08 16:37:36
tags:
    - 工程
    - Maven
    - 异常
categories:
    - [指尖飞舞, 工程, 异常]
---
__摘要：__
解决一个由重复生成的bean导致的bean冲突异常。
<!-- more -->

### 场景
在某次发版前夕，pull了最新代码之后，项目神奇般的无法启动了，疯狂报“BeanDefinitionStoreException: Failed to parse configuration class异常”，拉取最新代码或者拉取之前迭代的代码都卡在这里。
看了一下，在项目编译之后，会在target目录下生成两个相同类。

### 解决
执行Mavean的 `mvn clean` 将临时文件清理即可。

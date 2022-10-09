---
title: Windows同一台计算机不同用户之间转移hexo运行环境
comments: true
date: 2020-04-15 18:47:56
tags:
    - HeXo
    - 博客
categories:
    - [不亦乐乎, 博客]
---
__部署hexo的用户：A__
__新用户：B__

在Windows平台由A切换B之后，A配置的hexo没法直接使用。

__解决方法__
> + 将`C:\Users\A\AppData\Roaming`下的`npm`目录拷贝到`C:\Users\B\AppData\Roaming`。
>> 这里是hexo的安装目录，在新用户下不用重新安装。
> + 将`C:\Users\A`下的`.ssh`目录拷贝到`C:\Users\B`。
>> 这里存放着用于连接Github的ssh公钥和私钥。
> + 将`C:\Users\A`下的`node_modules`目录拷贝到`C:\Users\B`。
>> 这里是安装node之后用来存放`npm`下载的各种包的地方，我们不用重新执行`npm install`，直接拷贝即可。
> + 将`C:\Users\B\AppData\Roaming\npm`添加到B的用户环境变量。
>> 这一步可以让我们在新用户B下直接执行`hexo`命令。
> + 将`T:\Git\root\Git\cmd`添加到B的用户环境变量。
>> 这样可以在B下执行`git`命令。

同一台计算机不同不同用户之间转移hexo运行环境要比不同计算机之间更加方便。

##### 参考：
> https://hexo.io/zh-cn/docs/ 
> https://zhuanlan.zhihu.com/p/35668237
> https://www.zhihu.com/question/21193762 
> https://m.html.cn/qa/node-js/12146.html
> https://www.ruanyifeng.com/blog/2016/01/npm-install.html


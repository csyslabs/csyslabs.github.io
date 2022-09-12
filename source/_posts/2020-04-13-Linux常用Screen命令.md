---
title: Linux常用Screen命令
comments: true
date: 2020-04-13 09:59:32
tags:
    - Linux
    - Screen
categories:
    - [不亦乐乎, Linux]
---
Screen是一个可以在多个进程之间多路复用一个物理终端的窗口管理器。Screen中有会话的概念，用户可以在一个screen会话中创建多个screen窗口，在每一个screen窗口中就像操作一个真实的telnet/SSH连接窗口那样。在使用过程中可以退出screen，甚至可以关掉登录窗口，下次再进去重新挂上screen会话，所有工作全部都会恢复。

> + __安装__
> `sudo apt install screen`
>
> + __创建新会话__
> `screen -S 0x0`
> 创建一个名为「0x0」的会话，可以在其中执行任务。
>
> + __让会话独立（Detached）__
> 在当前会话中按住`Ctrl + A + D`，即可让其独立。此时我们可以在终端执行其他任务或退出终端。
>
> + __重新连接会话__
> `screen -r 0x0`
> 回到名为「0x0」的会话中。
>
> + __查看会话列表__
> `screen -ls`
> 
> + __结束会话__
> `screen -X -S 0x0 quit`强制结束「0x0」会话。
> 在「0x0」会话中按住`Ctrl + D`结束当前会话。
>
> + __清除死亡会话__
> `screen -wipe`

##### 参考
> https://zhuanlan.zhihu.com/p/40133139
> https://www.cnblogs.com/xinzaibing/archive/2012/04/08/2437431.html

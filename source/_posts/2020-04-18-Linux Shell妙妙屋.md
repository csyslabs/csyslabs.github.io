---
title: Linux基础知识
comments: true
date: 2020-04-18 14:11:44
tags:
    - Linux
    - Shell
categories:
    - [Linux]
---

### 基础命令
+ `cd ~` 进入家目录，家目录的定义为 home下的用户名目录；
+ `cd -` 进入上一次目录；
+ `Ctrl + C` 结束当前进程进或当前行的属于进入下一行；
+ `Ctrl + U` 清空当前行输入；
+ `Tab` 补全命令、文件、路径，底层是Trie前缀树实现；
+ `pwd` 显示当前所在目录
+ `ls -l` 显示当前目录下文件和目录详情，l表示 long list；
+ `ls -h` 人性化显示当前目录下文件和目录详情，h表示 human readable；
+ `ls -a` 显示当前目录下所有文件和目录，包括.开头的隐藏目录，a表示 all；
+ `cp src dst` 复制并重命名路径src到dst；
+ `mv src dst` 移动并重命名路径src到dst；
+ `touch` 创建一个文件，后面可以加空格并列创建多个；
+ `mkdir` 创建一个文件夹，后面可以加空格并列创建多个；
+ `history` 显示用过的历史命令；
+ `rm` 删除文件或文件夹，删除文件夹时一般加 -r参数递归删除子目录，r表示recursive；
+ `cat` 查看文件；

### 功能性命令汇总
#### 查找当前目录及子目录特定文件（夹）并删除
`find . -name "*.zip" -type f -print -exec rm {} \;`
+ `.`即从当前目录递归查找
+ `-name '*.zip'`查找以`.zip`文件名结尾的对象
+ `-type f`该对象为文件
+ `-print`屏幕输出
+ `-exec`查找之后执行
+ `rm`删除
如果希望删除目录，可以`-type d`，其表示对象为目录。另外如果希望递归删除，可以`rm -r`。如果希望递归强制删除，可以`rm -rf`。

#### 查找当前目录及子目录特定文件并移动到目标目录
`find . -name "*.mp4" -type f -print -exec mv -t /home/AriaGo/ {} +;`
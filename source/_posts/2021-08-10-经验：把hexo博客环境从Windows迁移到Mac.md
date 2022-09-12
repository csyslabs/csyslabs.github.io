---
title: 经验：把hexo博客环境从Windows迁移到Mac
comments: true
date: 2021-08-10 19:10:05
tags:
    - 博客
    - Hexo
categories:
    - [不亦乐乎, 博客]
---
__摘要：__
记录一下自己把hexo博客环境从Windows迁移到Mac的过程。
<!-- more -->


### Implements

1. 第一步，准备一碟花生米。
2. 在Windows环境中，压缩hexo文件夹，拷贝到Mac电脑中。OK，在Windows系统上的操作到此为止。
3. 接下来咱们在Mac上操作。在Mac上部署hexo需要Homebrew，nvm，node.js(v12.22.4)，hexo.
4. 安装Homebrew（略）。
5. 安装nvm（通过Homebrew安装nvm）。
> `brew install nvm`
> `echo "source $(brew --prefix nvm)/nvm.sh" >> .bash_profile`
> `. ~/.bash_profile`
> `nvm -v`查看nvm版本
6. 查看当前已安装的node.js版本
> `nvm list`
> 如果存在已安装的node.js，建议彻底删除卸载。具体方法略。
7. 接下来安装node.js
> `nvm ls-remote` 查看可安装的node.js版本。
> `nvm install 12.22.4` 不要安装最新版本。
> `node -v` 查看安装的node版本。
> `npm -v`  在node安装之后，咱们的npm也默认安装好了。
8. 安装hexo，
> `sudo npm install -g hexo`
9. 到此为止，崭新的hexo环境已配好。咱们可以建一个测试博客。
> cd 到测试文件夹。
> `hexo init`
> `hexo g`
> `hexo s`
> 如果终端显示url及端口号，则说明环境和配置没问题。
10. 配置新的SSHkey。因为咱们是用git往GitHub上push代码，那么，配置SSH是有必要的。我建议用新的SSH key。
> `ssh-keygen -t rsa -C "youremail@example.com"`
> 前往/Users/etoa/，按command+shift+.显示隐藏文件夹，看有无.ssh文件夹。
> 打开.ssh文件夹，以文本打开id_rsa.pub，将咱们的public key拷贝下来，千万别拷贝id_rsa中的key，这里面是私钥，不能放到GitHub上。
> 打开GitHub官网，登录自己的账号。
> 前往Setting页面，选择SSH and GPG keys。
> 点击New SSH key，将public key复制到这里，并命名。
11. 打开第2步拷贝的hexo压缩文件，将themes中的_config.yml中的所有Windows绝对路径替换成当前Mac的路径。
12. 终端定位到hexo根目录，执行：
> `hexo s`
见证奇迹的时刻，耶～
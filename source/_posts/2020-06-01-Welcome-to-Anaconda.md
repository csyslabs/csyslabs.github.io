---
title: Welcome to Anaconda
comments: true
date: 2020-06-01 13:52:17
tags:
    - Anaconda
categories:
    - [不亦乐乎]
---
### 为什么要用Anaconda
Anaconda解决了官方Python的两大痛点。
+ 提供了包管理功能，Windows平台安装第三方包经常失败的场景得以解决。
+ 提供环境管理的功能，功能类似Virtualenv，解决了多版本Python并存、切换的问题。

### 下载安装conda
```Shell
wget https://repo.anaconda.com/archive/Anaconda3-2019.07-Linux-x86_64.sh
bash  Anaconda3-2019.07-Linux-x86_64.sh
```
### 把conda加入PATH
```Shell
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/root/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/root/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/root/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/root/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
```

##### 参考 
> + https://www.zhihu.com/question/58033789
> + https://www.bobobk.com/32.html
---
title: 使用youtube-dl下载YouTube频道所有视频
comments: true
date: 2020-10-19 21:44:42
tags:
    - YouTube
    - youtube-dl
categories:
    - [不亦乐乎]
---
__摘要：__
使用youtube-dl一键下载指定YouTube频道所有视频。
<!--more-->
`youtube-dl -f "bestvideo[width>=<resolution width such as: 3840>]+bestaudio/best" -ciw -o "%(title)s.%(ext)s" -v <channel url like: xxx/channel/xxx> --download-archive downloaded.txt`

> -f, --format FORMAT
    video format code. with adding `bestvideo[width>=3840]+bestaudio/best` youtube-dl will pick the quality >= 4K

> -c, --continue                   
    force resume of partially downloaded files

> -i, --ignore-errors              
    continue on download errors, for example to skip unavailable videos in a channel 

> -w, --no-overwrites
    do not overwrite files

> -o, --output
    Output filename template, this example functions similarly to the old --title option

> -v, --verbose
    print various debugging information

> with --download-archive download.txt flag you gonna archive all videos' info so that you can ezlly resume download.
-f 

_reference:_
> https://askubuntu.com/questions/856911/using-youtube-dl-to-download-entire-youtube-channel 

---
title: 记录对hexo yilia主题的个性定制
comments: true
date: 2020-10-30 22:37:34
tags:
    - 博客
    - Hexo
categories:
    - [不亦乐乎, 博客]
---
__摘要：__
记录在使用hexo-yilia主题时的一些定制选项。
<!-- more -->
### 1. 隐藏多余的「展开更多」
> + 打开hexo\themes\yilia\layout\_partial\article.ejs
> + 定位到`<a class=".article-more-a" href="<%- url_for(post.path) %>#more">`
> + 行内添加`style=“display: none;”`

###  2. 显示文章阅读次数
> + 打开hexo\themes\yilia\layout\_partial\article.ejs
> + 定位到`<div class="article-inner">`
> + 定位到`<header class="article-header">`
> + 在`<%- partial('post/title', {class_name: 'article-title'}) %>`下添加：
> ```Html
<!--显示阅读次数-->
<% if (!index && post.comments){ %>
    <br/>
    <a class="cloud-tie-join-count" href="javascript:void(0);" style="color:gray;font-size:14px;">
    <span class="icon-sort"></span>
    <span id="busuanzi_container_page_pv" style="color:#696969;font-size:14px;">
            阅读数: <span id="busuanzi_value_page_pv"></span>次 &nbsp;&nbsp;
    </span>
    </a>
<% } %>
<!--显示阅读次数-->
> ```

### 3. 添加文章字数统计和阅读时长
> + 安装wordcount插件: `npm i –save hexo-wordcount`
> + 打开theme\yilia\layout\_partial\post，创建`word.ejs`文件
> + 在`word.ejs`中写入:
> ```Html
    <div style="margin-top:10px;">
    <span class="post-time">
      <span class="post-meta-item-icon">
        <i class="fa fa-keyboard-o"></i>
        <span class="post-meta-item-text">  字数统计: </span>
        <span class="post-count"><%= wordcount(post.content) %>字</span>
      </span>
    </span>

    <span class="post-time">
      &nbsp; | &nbsp;
      <span class="post-meta-item-icon">
        <i class="fa fa-hourglass-half"></i>
        <span class="post-meta-item-text">  阅读时长: </span>
        <span class="post-count"><%= min2read(post.content) %>分</span>
      </span>
    </span>
    </div>
> ```
> + 打开hexo\themes\yilia\layout\_partial\article.ejs
> + 在`<%- partial('post/title', {class_name: 'article-title'}) %>`下添加：
> ```Html
<!--显示文章字数统计以及阅读时长-->
<% if(theme.word_count && !post.no_word_count){ %>
    <%- partial('post/word') %>
    <% } %>
<!--显示文章字数统计以及阅读时长-->
> ```

### 4. 添加页面顶部加载条
> + 打开theme\yilia\layout\_partial\head.ejs
> + 定位到：
> ```Html
> <title><% if (title){ %><%= title %> | <% } %><%= config.title %></title>
> <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
> ```
> + 在其下方添加：
> ```Html
<!--顶部加载条-->
  <script src="//cdn.bootcss.com/pace/1.0.2/pace.min.js"></script>
  <link href="//cdn.bootcss.com/pace/1.0.2/themes/pink/pace-theme-flash.css" rel="stylesheet">
    <style>
    .pace .pace-progress {
        background: #6d6d6d; /*进度条颜色*/
        height: 2px;
    }
    .pace .pace-progress-inner {
         box-shadow: 0 0 10px #1E92FB, 0 0 5px     #6d6d6d; /*阴影颜色*/
    }
    .pace .pace-activity {
        border-top-color: #6d6d6d;    /*上边框颜色*/
        border-left-color: #6d6d6d;    /*左边框颜色*/
    }
  </style>
<!--顶部加载条-->
> ```

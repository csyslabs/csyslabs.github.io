---
title: 【AcWing算法基础】第三讲-搜索与图论-DFS AcWing 842. 排列数字
comments: true
date: 2023-07-15 14:46:52
tags:
    - 算法
    - AcWing 
    - DFS
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第三讲搜索与图论]
---
__摘要：__
DFS入门题。
<!-- more -->


### 题目
给定一个整数 $n$，将数字 $1∼n$ 排成一排，将会有很多种排列方法。

现在，请你按照字典序将所有的排列方法输出。

__输入格式__
共一行，包含一个整数 $n$。

__输出格式__
按字典序输出所有排列方案，每个方案占一行。

__数据范围__
$1≤n≤7$

__输入样例：__
> 3

__输出样例：__
> 1 2 3
> 1 3 2
> 2 1 3
> 2 3 1
> 3 1 2
> 3 2 1

### 代码

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;

const int N = 10;
int n;
int path[N];
bool st[N];

void dfs(int u)
{
    if (u == n)
    {
        // overflow
        for (int i = 0; i < n; ++i) cout << path[i] << " ";
        cout << endl;
        return;
    }
    for (int i = 1; i <= n; ++i)
    {
        if (!st[i])
        {
            path[u] = i;
            st[i] = true;
            dfs(u + 1);
            st[i] = false;
        }
    }
}

int main()
{
    cin >> n;
    dfs(0);
}
```
<!-- endtab -->

<!-- tab Java -->
```java

```
<!-- endtab -->
{% endtabs %}

### 理解
本题核心思想是使用递归全量枚举暴搜。
按照深度优先进行下一位数字的搜索操作。每搜索到一个节点，使用path数组记录节点值。当路径中记录的数字数量到达预计值的时候，输出路径并递归返回。
为了每个节点可以使用新的数字而不至于重复，将当前路径已经使用过的数字使用额外数组记下，在下一层调用的时候跳过已使用的数字。
需要注意的是，在递归回来的时候，需要将已被标记的当前入口节点使用状态重置。因为标记的目的是为了下一层跳过，那么从下一层递归回来当然需要还原。


{% note primary %}
__原题链接：__ [AcWing 842. 排列数字](https://www.acwing.com/problem/content/844/)
{% endnote %}
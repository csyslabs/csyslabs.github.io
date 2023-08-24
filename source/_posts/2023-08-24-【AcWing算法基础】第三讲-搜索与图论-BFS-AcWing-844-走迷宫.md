---
title: 【AcWing算法基础】第三讲-搜索与图论-BFS AcWing 844. 走迷宫
comments: true
date: 2023-08-24 23:45:43
tags:
    - 算法
    - AcWing 
    - DFS
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第三讲搜索与图论]
---
__摘要：__
BFS模板题，边权恒为1的最短路搜索。
<!-- more -->

### 题目
给定一个 $n \times m$ 的二维整数数组，用来表示一个迷宫，数组中只包含 $0$ 或 $1$，其中 $0$ 表示可以走的路，$1$ 表示不可通过的墙壁。

最初，有一个人位于左上角 $(1,1)$ 处，已知该人每次可以向上、下、左、右任意一个方向移动一个位置。

请问，该人从左上角移动至右下角 $(n,m)$ 处，至少需要移动多少次。

数据保证 $(1,1)$ 处和 $(n,m)$ 处的数字为 $0$，且一定至少存在一条通路。

__输入格式__
第一行包含两个整数 $n$ 和 $m$。

接下来 $n$ 行，每行包含 $m$ 个整数（$0$ 或 $1$），表示完整的二维数组迷宫。

__输出格式__
输出一个整数，表示从左上角移动至右下角的最少移动次数。

__数据范围__
$1≤n,m≤100$

__输入样例：__
> 5 5
> 0 1 0 0 0
> 0 1 0 1 0
> 0 0 0 0 0
> 0 1 1 1 0
> 0 0 0 1 0

__输出样例：__
> 8

### 代码

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
/**
 * author: zxy
 * code at: 2023-8-24 23:51:52
 */
#include <bits/stdc++.h>

using namespace std;

struct vec2_t {
    int r, c;
};

int n, m;
const int N = 110;
int g[N][N];
int d[N][N];
vec2_t q[N * N];
int hh = 0, tt = -1;
int dr[4] = {1, 0, -1, 0};
int dc[4] = {0, -1, 0, 1};

int main()
{
    cin >> n >> m;
    for (int r = 0; r < n; ++ r)
        for (int c = 0; c < m; ++ c)
            cin >> g[r][c];
    
    memset(d, -1, sizeof d);
    q[++tt] = {0, 0};
    d[0][0] = 0;
    for (; hh <= tt;)
    {
        vec2_t cur = q[hh++];
        for (int i = 0; i < 4; ++i)
        {
            int ne_r = cur.r + dr[i];
            int ne_c = cur.c + dc[i];
            if (ne_r >= 0 && ne_r < n && ne_c >= 0 && ne_c < m && g[ne_r][ne_c] == 0 && d[ne_r][ne_c] == -1)
            {
                q[++tt] = {ne_r, ne_c};
                d[ne_r][ne_c] = d[cur.r][cur.c] + 1;                
            }
        }
    }
    cout << d[n - 1][m - 1] << endl;
}
```
<!-- endtab -->

<!-- tab Java -->
```java

```
<!-- endtab -->
{% endtabs %}

### 思考
使用BFS思想遍历图中所有节点, 因为图中边权为 $1$，所以BFS可以拿到最短路径。
将每一个节点的下一层节点入队，并记录下一层所有可用节点的步长。
搜索注意判断可达点的条件，可以利用步长数组判断是否已达。

{% note primary %}
__原题链接：__ [AcWing 844. 走迷宫](https://www.acwing.com/problem/content/description/846/)
{% endnote %}
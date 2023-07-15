---
title: 【AcWing算法基础】第三讲-搜索与图论-DFS AcWing 843. n-皇后问题
comments: true
date: 2023-07-15 17:00:08
tags:
    - 算法
    - AcWing 
    - DFS
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第三讲搜索与图论]
---
__摘要：__
经典的DFS问题，n-皇后。
<!-- more -->

### 题目
$n$−皇后问题是指将 $n$ 个皇后放在 $n \times n$ 的国际象棋棋盘上，使得皇后不能相互攻击到，即任意两个皇后都不能处于同一行、同一列或同一斜线上。

![n-queen](https://cdn.acwing.com/media/article/image/2019/06/08/19_860e00c489-1_597ec77c49-8-queens.png)

现在给定整数 $n$，请你输出所有的满足条件的棋子摆法。

__输入格式__
共一行，包含整数 $n$。

__输出格式__
每个解决方案占 $n$ 行，每行输出一个长度为 $n$ 的字符串，用来表示完整的棋盘状态。

其中 `.` 表示某一个位置的方格状态为空，`Q` 表示某一个位置的方格上摆着皇后。

每个方案输出完成后，输出一个空行。

注意：行末不能有多余空格。

输出方案的顺序任意，只要不重复且没有遗漏即可。

__数据范围__
$1≤n≤9$

__输入样例：__
$4$

__输出样例：__
> .Q..
> ...Q
> Q...
> ..Q.
> 
> ..Q.
> Q...
> ...Q
> .Q..


### 代码

{% tabs g_tab0 %}
<!-- tab C++/行递归搜索 -->
```c++
/**
 * author: zxy
 * code at: 2023-7-15 17:18:56
 */
#include <bits/stdc++.h>
 
using namespace std;

int n;
const int N = 10;
bool col[N], dg[N], ndg[N];
char g[N][N];

void dfs(int r)
{
    if (r == n) 
    {
        // finds a valid solution if overflow
        for (int i = 0; i < n; ++i)
        {
            cout << g[i] << endl;
        }
        cout << endl;
        return;
    }
    
    for (int c = 0; c < n; ++c)
    {
        if (!col[c] && !dg[c + r] && !ndg[c - r + n])
        {
            // valid grid to put queen
            g[r][c] = 'Q';
            col[c] = dg[c + r] = ndg[c - r + n] = true;
            // step into the next row
            dfs(r + 1);
            // back track to restore context
            col[c] = dg[c + r] = ndg[c - r + n] = false;
            g[r][c] = '.';
        }
    }
}

int main()
{
    cin >> n;
    for (int i = 0; i < n; ++i)
    {
        for (int j = 0; j < n; ++j)
        {
            g[i][j] = '.';
        }
    }
    
    dfs(0);
}
```
<!-- endtab -->

<!-- tab C++/按每个格子放与不放枚举搜索 -->
```c++
#include <bits/stdc++.h>
 
using namespace std;

int n;
const int N = 10;
bool row[N], col[N], dg[N], ndg[N];
char g[N][N];

void dfs(int r, int c, int s)
{
    // the colums overflows, set to the next row
    if (c >= n)
    {
        c = 0;
        ++r;
    }
    if (r >= n)
    {
        if (s >= n) 
        {
            // consider a valid solution
            for (int i = 0; i < n; ++i) 
            {
                cout << g[i] << endl;
            }
            cout << endl;
        }    
        return;
    }
    

    // try not put queen
    g[r][c] = '.';
    dfs(r, c + 1, s);
    
    // try put queen
    if (!row[r] && !col[c] && !dg[r + c] && !ndg[r - c + n])
    {
        g[r][c] = 'Q';
        row[r] = col[c] = dg[r + c] = ndg[r - c + n] = true;
        // step into next columns
        dfs(r, c + 1, s + 1);
        // back track to restore context
        g[r][c] = '.';
        row[r] = col[c] = dg[r + c] = ndg[r - c + n] = false;
    }
}

int main()
{
    cin >> n;
    for (int i = 0; i < n; ++i)
    {
        for (int j = 0; j < n; ++j)
        {
            g[i][j] = '.';
        }
    }
    
    dfs(0, 0, 0);
}
```
<!-- endtab -->

<!-- tab Java -->
```java

```
<!-- endtab -->
{% endtabs %}

### 按行递归搜索
从第一行开始向右遍历放入第一个 `Q`，记下冲突位置， 即记下竖和两个斜对角占用，横冲突不需要考虑因为我们按行搜索，每一行只会放置一个 `Q`。

此时递归进入下一行，根据冲突记录找到不冲突的点，放置 `Q`。依次往下一行递归，当递归到某一行没有能够找到位置放置 `Q`，可以认为方案不合法。此时递归函数回溯。进行上一行，对下一个可能放置 `Q` 的位置进行尝试。

当递归到行越界的时候，可以认为该路径上的所有 `Q` 合法，输出方案。

需要注意的是记录两个对角线冲突状态时，我们使用一元二次方程 $r = c + d$ 和 $r = c - d$ 中截距 $d$ 来表示一条对角线，其中：

$d = r + c$

$d = r - c$

在数组中维护 $d$ 的值时，对于第二种情况，可能下标取到负值。由于 $r - c$ 最小可以取到 $-c$ 即 $-n$ 的位置，我们将整个 $d = r - c$ 向右偏移 $n$ 位，即可解决数组下标为负数的问题。

### 按每个格子放与不放枚举搜索
思想是每个格子都尝试放与不放两种选择，从最后一个格子开始，作为放置 `Q` 的起点向后递归。不满足的话回溯到倒数第二个格子放置 `Q`，依次类推。

该方法存在大量重复尝试，每一个格子作为放置 `Q` 的起点向后递归的时候，都会和其他起点的路径存在重复。

对比按行递归搜索方法，该方法复杂度更高。

{% note primary %}
__原题链接：__ [AcWing 843. n-皇后问题](https://www.acwing.com/problem/content/description/845/)
{% endnote %}
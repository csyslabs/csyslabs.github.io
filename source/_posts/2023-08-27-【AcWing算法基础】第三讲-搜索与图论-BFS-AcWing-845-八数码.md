---
title: 【AcWing算法基础】第三讲-搜索与图论-BFS AcWing 845. 八数码
comments: true
date: 2023-08-27 23:47:32
tags:
    - 算法
    - AcWing 
    - BFS
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第三讲搜索与图论]
---
__摘要：__
BFS方法解决以抽象状态变化为基础的搜索问题。
<!-- more -->

### 题目
在一个 $3 \times 3$ 的网格中，$1∼8$ 这 $8$ 个数字和一个 `x` 恰好不重不漏地分布在这 $3 \times 3$ 的网格中。

例如：

> 1 2 3
> x 4 6
> 7 5 8

在游戏过程中，可以把 `x` 与其上、下、左、右四个方向之一的数字交换（如果存在）。

我们的目的是通过交换，使得网格变为如下排列（称为正确排列）：

> 1 2 3
> 4 5 6
> 7 8 x

例如，示例中图形就可以通过让 `x` 先后与右、下、右三个方向的数字交换成功得到正确排列。

交换过程如下：

> 1 2 3
> x 4 6
> 7 5 8

to

> 1 2 3
> 4 x 6
> 7 5 8

to

> 1 2 3
> 4 5 6
> 7 x 8

to

> 1 2 3
> 4 5 6
> 7 8 x

现在，给你一个初始网格，请你求出得到正确排列至少需要进行多少次交换。

__输入格式__
输入占一行，将 $3 \times 3$ 的初始网格描绘出来。

例如，如果初始网格如下所示：

> 1 2 3 
> x 4 6 
> 7 5 8 

则输入为：`1 2 3 x 4 6 7 5 8`

__输出格式__
输出占一行，包含一个整数，表示最少交换次数。

如果不存在解决方案，则输出 $−1$。

__输入样例：__
> 2 3 4 1 5 x 7 6 8

__输出样例__
> 19

### 代码

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
/**
 * author: zxy
 * code at: 2023-8-27 11:59:50
 */
#include <bits/stdc++.h>

using namespace std;

unordered_map<string, int> d;
queue<string> q;
int dr[4] = {-1, 0, 1, 0}, dc[4] = {0, 1, 0, -1};
int res = -1;

void bfs(string graph)
{
    q.push(graph);
    d[graph] = 0;
    
    string final_graph = "12345678x";
    
    for (; q.size(); )
    {
        string cur = q.front();
        q.pop();
        int distance = d[cur];
        if (cur == final_graph)
        {
            res = distance;
            return;
        }
        
        int pos = cur.find('x');
        int r = pos / 3, c = pos % 3;
        
        for (int i = 0; i < 4; ++ i)
        {
            int ner = r + dr[i], nec = c + dc[i];
            
            if (ner >= 0 && ner < 3 && nec >= 0 && nec < 3)
            {
                int ne_pos = ner * 3 + nec;
                // creates virtual node move
                swap(cur[pos], cur[ne_pos]);
                
                if (d[cur] == 0)
                {
                    q.push(cur);
                    d[cur] = distance + 1;
                }
                
                swap(cur[pos], cur[ne_pos]);
            }
        }
    }
}

int main()
{
    string start;
    for (char c; cin >> c; start += c);
    bfs(start);
    cout << res << endl;
}
```
<!-- endtab -->

<!-- tab Java -->
```java

```
<!-- endtab -->
{% endtabs %}

### 理解
仔细阅读题目可以看出这道题涉及到方格状态的演变，状态不断叠加直到产生正确的结果。这和在棋盘上从某点到某点的搜索过程类似。

在使用BFS搜索棋盘从某点到某点的路径时，点的一次移动可视为状态的一次变化。在此处BFS的思想体现在点向四个方向移动进行搜索尝试直到找到路径。

而本题可将从当前地图状态到 $x$ 与周围的某个数字发生一次位置交换后的状态视为状态的一次变化。注意这里和上述路径搜索不同的地方在于状态的变化。此处为地图的当前布局到移动数字后的一次布局，而上述路径搜索则很直观地体现在点的移动。

我们使用BFS思想不断尝试 $x$ 周围的点与 $x$ 进行交换，直到找到目标状态。

在使用BFS前，我们思考如何将棋盘的一个布局视为BFS的一个虚拟节点。以及如何存放状态变化过程中进行的次数。

我们可将矩阵按行拆分拼成一行，转化为字符串，将某个字符串视为一个节点，每一次状态变化后，将字符串放入队列。
我们可维护一个哈希表，key为矩阵字符串，value为状态转移过程中进行的次数。

本题有个小技巧：$m \times n$ 的矩阵中某点 $x$ 的横纵坐标 $r, c$ 可以看成将矩阵按行排成一行后，$x$ 的下标 $i$ 进行如下处理：
```c++
int r = i / m;
int c = i % m;
```
相反：
```c++
int i = r * m + c;
```


{% note primary %}
__原题链接：__ [AcWing 845. 八数码](https://www.acwing.com/problem/content/847/)
{% endnote %}

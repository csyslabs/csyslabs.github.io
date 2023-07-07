---
title: 【AcWing算法基础】第二讲-数据结构-堆 AcWing 839. 模拟堆
comments: true
date: 2023-07-08 00:51:33
tags:
    - 算法
    - AcWing
    - 堆
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
数组模拟堆。
<!-- more -->


### 题目
维护一个集合，初始时集合为空，支持如下几种操作：
+ $I \quad x$，插入一个数 $x$；
+ $PM$，输出当前集合中的最小值；
+ $DM$，删除当前集合中的最小值（数据保证此时的最小值唯一）；
+ $D \quad k$，删除第 $k$ 个插入的数；
+ $C \quad k \quad x$，修改第 $k$ 个插入的数，将其变为 $x$；
现在要进行 $N$ 次操作，对于所有第 $2$ 个操作，输出当前集合的最小值。

__输入格式__
第一行包含整数 $N$。

接下来 $N$ 行，每行包含一个操作指令，操作指令为 $I \quad x$, $PM$, $DM$, $Dk$ 或 $C \quad k \quad x$ 中的一种。

__输入格式__
对于每个输出指令 $PM$，输出一个结果，表示当前集合中的最小值。

每个结果占一行。

__数据范围__
+ $1≤N≤10^5$
+ $−10^9≤x≤10^9$

数据保证合法。

__输入样例：__
> 8
> I -10
> PM
> I -10
> D 1
> C 2 8
> I 6
> PM
> DM

__输出样例：__
> -10
> 6

### 代码
{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
/**
 * author: zxy
 * code at: 2023-7-8 01:37:00
 */
#include <bits/stdc++.h>

using namespace std;

const int N = 1000010;
int h[N], ph[N], hp[N];

int n, idx;

void heap_swap(int u, int i)
{
    int k1 = hp[u];
    int k2 = hp[i];
    ph[k1] = i;
    ph[k2] = u;
    hp[u] = k2;
    hp[i] = k1;
    swap(h[u], h[i]);
}

void heap_swap_1(int a, int b)
{
    swap(ph[hp[a]],ph[hp[b]]);
    swap(hp[a], hp[b]);
    swap(h[a], h[b]);
}

void down(int i)
{
    int u = i;
    if (i * 2 <= idx && h[i * 2] < h[i]) u = i * 2;
    if (i * 2 + 1 <= idx && h[i * 2 + 1] < h[u]) u = i * 2 + 1;
    if (u != i)
    {
        heap_swap(u, i);
        down(u);
    }
}

void up(int i)
{
    for (; i >> 1 && h[i >> 1] > h[i];) 
    {
        heap_swap(i, i >> 1);
        i >>= 1;
    }
}

int main()
{
    cin >> n;
    for (; n--;)
    {
        string ops;
        cin >> ops;

        int k, x;
        if (ops == "I")
        {
            static int insert_cnt = 0;
            ++insert_cnt;
            cin >> x;
            h[++idx] = x;
            ph[insert_cnt] = idx;
            hp[idx] = insert_cnt;
            up(idx);
        }
        else if (ops == "PM")
        {
            cout << h[1] << endl;
        }
        else if (ops == "DM")
        {
            heap_swap(1, idx);
            --idx;
            down(1);
        }
        else if (ops == "D")
        {
            cin >> k;
            int k_idx = ph[k];
            heap_swap(k_idx, idx);
            --idx;
            up(k_idx);
            down(k_idx);
        }
        else if (ops == "C")
        {
            cin >> k >> x;
            int k_idx = ph[k];
            h[k_idx] = x;
            up(k_idx);
            down(k_idx);
        }
    }
}
```
<!-- endtab -->

<!-- tab Java -->
```java

```
<!-- endtab -->
{% endtabs %}

### 理解
数组模拟堆，建堆逻辑见这篇文章：[AcWing 838. 堆排序](https://ntifs.com/2023/06/25/【AcWing算法基础】第二讲-数据结构-堆-AcWing-838-堆排序/)

相比较，本题额外需要支持删除和修改第k个插入的数。那么我们需要维护一个数据结构可以对应找到第 $k$ 个插入的数在堆数组中的位置。

我们用 $ph$ 数组维护该映射关系，`int u = ph[k]` 表示第 $k$ 个插入的数在堆数组 $h$ 中的下标为 $u$。

仔细思考不难发现，当我们交换堆数组中两个元素数值的位置时，如果用传统的 $swap$ 方法交换数组数值位置，会打乱第 $k$ 个插入数在下标K和堆数组数值下标的映射关系。所以交换时我们也必须要同时交换这个映射关系。

继续思考容易想到，在我们交换两个数插入次序和值下标映射关系时，需要知道两个值下标对应的 $k$ 是多少，因为我们交换函数的入参只有两个值在堆数组中的下标。那么我们需要维护一个数据结构可以根据堆数组数值下标找到其插入次序。

我们用 $hp$ 数组维护该映射关系，`int k = hp[u]` 表示堆数组下标为 $u$ 的数是第 $k$ 次插入的。

重构交换函数，逻辑是：
1. 先根据两个值在堆数组中的下标找到两个数分别是第几次插入的（用到未交换次序的 $hp$ 数组），再根据两者的插入次序交换其对应在堆数组中的下标，完成第一次 $ph$ 映射交换；
2. 接着根据两个值在数组中的下标交换其对应的插入次序，完成第二次 $hp$ 映射交换；
3. 进行堆数组数值交换。


{% note primary %}
__原题链接：__ [AcWing 839. 模拟堆](https://www.acwing.com/problem/content/841/)
{% endnote %}
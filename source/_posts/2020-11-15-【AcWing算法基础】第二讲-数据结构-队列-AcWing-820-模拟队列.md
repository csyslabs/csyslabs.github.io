---
title: 【AcWing算法基础】第二讲-数据结构-队列 AcWing 820. 模拟队列
comments: true
date: 2020-11-15 22:47:39
tags:
    - 算法
    - AcWing
    - 队列
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
数组模拟队列模板题。
<!-- more -->

### 题目
实现一个队列，队列初始为空，支持四种操作：

1. `push x` – 向队尾插入一个数 $x$；
2. `pop` – 从队头弹出一个数；
3. `empty` – 判断队列是否为空；
4. `query` – 查询队头元素。

现在要对队列进行 $M$ 个操作，其中的每个操作 $3$ 和操作 $4$ 都要输出相应的结果。

__输入格式__
第一行包含整数 $M$，表示操作次数。
接下来 $M$ 行，每行包含一个操作命令，操作命令为 `push x`，`pop`，`empty`，`query` 中的一种。

__输出格式__
对于每个 `empty` 和 `query` 操作都要输出一个查询结果，每个结果占一行。
其中，`empty` 操作的查询结果为 `YES` 或 `NO`，`query` 操作的查询结果为一个整数，表示队头元素的值。

__数据范围__
+ $ 1≤M≤100000 $,
+ $ 1≤x≤109 $,
+ 所有操作保证合法。

__输入样例：__
> 10
> push 6
> empty
> query
> pop
> empty
> push 3
> push 4
> pop
> query
> push 6

__输出样例：__
> NO
> 6
> YES
> 4

___

### 思路
维护一个数组，用于存放队列中的数；维护一个头指针，一个尾指针，分别用于指向队列的头部和尾部。我们在尾部放入元素，在头部取出元素。当头指针位置在尾指针左侧意味着队列非空，可以初始化头指针和尾指针分别为0和-1.

### 代码

{% tabs g_tab %}
<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

const int N = 100010;
int q[N], hh, tt;

int query()
{
    return q[hh];                               
}

bool empty()
{
    return tt < hh;                                         
}

void push(int x) 
{
    q[++ tt] = x;                                               
}

void init()
{
    hh = 0, tt = -1;                                              // 1         
}

int main()
{
    init();
    int m;
    cin >> m;
    for (; m--;) {
        string op;
        cin >> op;
        int x;
        if (op == "push") {
            cin >> x;
            push(x);
        } else if (op == "pop") {
            hh ++;
        } else if (op == "empty") {
            cout << (empty() ? "YES" : "NO") << endl;
        } else {
            cout << query() << endl;
        }
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

> 1. 初始化头指针和尾指针，值不一定非得是`0,-1`。当我们初始化为`0,-1`时，头指针在尾指针右边，表明当前队列为空。为什么初始化 `hh` 要在 `tt` 右边呢？一般来说，因为考虑队列仅有一个值的情况，此时必须要让 `hh` 和 `tt` 指向同一个值（重叠），所以初始化 `tt` 要在 `hh` 左边偏移一位，这样我在第一次 `push` 的时候, `tt++` ，和 `hh` 刚好重叠。也正因为如此，可以用 `hh` 与 `tt` 的相对位置来判空。

{% note primary %}
__原题链接：__[AcWing 820. 模拟队列](https://www.acwing.com/problem/content/831/)
{% endnote %}

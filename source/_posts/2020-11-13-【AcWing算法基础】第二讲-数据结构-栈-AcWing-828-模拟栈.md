---
title: 【AcWing算法基础】第二讲-数据结构-栈 AcWing 828. 模拟栈
comments: true
date: 2020-11-13 12:13:18
tags:
    - AcWing 
    - 算法
    - 栈
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
数组模拟栈模板题。
<!-- more -->

### 题目
实现一个栈，栈初始为空，支持四种操作：

1. `push x` – 向栈顶插入一个数 $x$；
2. `pop` – 从栈顶弹出一个数；
3. `empty` – 判断栈是否为空；
4. `query` – 查询栈顶元素。

现在要对栈进行 $M$ 个操作，其中的每个操作 $3$ 和操作 $4$ 都要输出相应的结果。

__输入格式__
第一行包含整数 $M$，表示操作次数。
接下来 $M$ 行，每行包含一个操作命令，操作命令为 `push x`，`pop`，`empty`，`query`中的一种。

__输出格式__
对于每个 `empty` 和 `query` 操作都要输出一个查询结果，每个结果占一行。
其中， `empty` 操作的查询结果为 `YES` 或 `NO`，`query` 操作的查询结果为一个整数，表示栈顶元素的值。

__数据范围__
+ $1≤M≤100000$,
+ $1≤x≤10^9$
+ 所有操作保证合法。

__输入样例：__
> 10
> push 5
> query
> push 6
> pop
> query
> pop
> empty
> push 4
> query
> empty

__输出样例：__
> 5
> 5
> YES
> 4
> NO

___

### 思路

维护一个数组和一个指针，数组存储所有入栈的数，指针指向栈顶元素。
入栈：指针右移，将数放入新的位置。
出栈：指针左移一位。
获取栈顶元素：直接返回指针指向的数、
判空：如果指针>=0即非空。

以上为数组模拟栈的基本操作，可见数组模拟栈是非常简单的。当然还可以进行很多魔改。比如当前出栈是不返回任何结果的，但是我们可以让它返回出栈的元素；以及各种边界条件判断等等。用C++ STL的栈能实现的，用数组都可以实现，而用数组可以实现更多STL栈所实现不了的。

__在算法竞赛中，由于数据量往往很大，用STL容器（包括链表，hashmap等）会很慢。__

### 代码

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

const int N = 100010;
int stk[N], tt;                         // 1

void push(int x)
{
    stk[++tt] = x;
}

void pop()
{
    tt--;    
}

bool empty()
{
    return tt >= 0;    
}

int query()
{
    return stk[tt];
}

int main()
{
    int n;
    cin >> n;
    tt = -1;                            // 2
    for (; n --;) {
        string op;
        int x;
        cin >> op;
        if (op == "push") {
            cin >> x;
            push(x);
        } else if (op == "pop") {
            pop();
        } else if (op == "empty") {
            cout << (empty() ? "NO" : "YES") << endl;
        } else {    // query
            cout << query() << endl;
        }
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

> 1. `tt`为栈顶指针。
> 2. 让栈从数组下标为0处放入数据，因为`tt`是栈顶指针，在`push`的时候必须先向右移动一位，所以这里初始化为 `-1` 。当然也可以让`tt`初始化为  `0` ，这样从数组下标1处放入数据，在判空的时候可以 `tt ? "NO" : "YES"` ，看个人习惯吧。

{% note primary %}
__原题链接：__ [AcWing 828. 模拟栈](https://www.acwing.com/problem/content/830/)
{% endnote %}





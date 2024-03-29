---
title: 【AcWing算法基础】第二讲-数据结构-单调栈 AcWing 830. 单调栈
comments: true
date: 2020-11-14 14:02:29
tags:
    - 算法
    - AcWing
    - 单调栈
    - 栈
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
一道经典的单调栈模板题。
<!-- more -->
### 题目
给定一个长度为N的整数数列，输出每个数左边第一个比它小的数，如果不存在则输出 $-1$。

__输入格式__
第一行包含整数 $N$，表示数列长度。
第二行包含 $N$ 个整数，表示整数数列。

__输出格式__
共一行，包含 $N$ 个整数，其中第 $i$ 个数表示第 $i$ 个数的左边第一个比它小的数，如果不存在则输出 $-1$。

__数据范围__
+ $1≤N≤10^5$ 
+ $1≤$ 数列中元素 $≤10^9$

__输入样例：__
> 5
> 3 4 2 7 5

__输出样例：__
> -1 3 -1 2 2

___

### 思路

和双指针思想类似，我们先想一想暴力算法。可以使用两层循环，外层遍历整个数组，对于每一个数，内层循环向左寻找第一个小于这个数的数。
接着我们利用单调栈对暴力算法进行优化，我们可以在外层循环的过程中，维护一个元素大小单调递增的栈。对于原数组的每一个元素，我们将其与栈顶元素进行比较，如果比栈顶元素大，那么栈顶元素就符合要求，另外要将当前数组元素入栈，此时栈内元素保持了递增。
否则将栈顶元素弹出，依次比较栈中所有元素，直到找出第一个比当前数组元素小的。由于栈内元素是递增的，所以比较次数一定是最少的，这就实现了优化。在将栈顶元素弹出的过程，栈顶指针是向左移动的，在这个过程中，栈一直在被破坏、被削减，但是我们不必在意，因为之前的栈内元素已经帮助我们找到了之前数组元素的目标值了，我们将栈顶元素弹出，直到找到或者栈为空，此时的栈将保持维护栈的递增特性，继续为我们当前及以后的数组元素服务。
真是个美妙的思路。

### 关键点

> 1. Q: 为什么要保持栈内元素大小的单调递增特性？
> A: 由于栈内元素是递增的，所以比较次数一定是最少的，这就实现了优化。
> 2. Q: 如何保持栈内元素大小的递增性？
> A: 在依次出栈比较栈顶元素和当前数组元素大小的时候，如果栈顶元素小，那么找到目标值，将当前数组元素入栈，这样保持了栈内元素大小的递增性；如果栈顶元素大，那么栈顶指针左移，直到找到目标值，再将当前数组元素入栈，这样就保持了栈内元素大小的递增性。我们不必在意这个过程破坏了栈的结构，因为之前的数已经找到之前数组元素对应的目标值了。
> 3. Q: 为什么栈顶元素若比当前数小则一定是左边最近的？
> A: 因为栈内元素是按照原数组顺序递增排序的，那么栈顶如果比当前元素小，则一定是最近的。

注意，维护栈内元素的递增，并非是将栈内元素排序，排序是打乱了原来元素的先后顺序，而我们必须要保证栈内元素的先后顺序不变。

### 代码
{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

const int N = 100010;
int stk[N], tt;

int main()
{
    ios::sync_with_stdio(false);
    int n;
    cin >> n;
    for (; n --;) {
        int x;
        cin >> x;
        for (; tt && stk[tt] >= x; --tt) ;      // 1
                                                // 2
        if (!tt) cout << -1 << " ";             
        else cout << stk[tt] << " ";
        stk[++ tt] = x;                         // 3
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

> 1. 比较栈顶元素和当前元素，栈为空时不必比较。
> 2. 此时找到目标值，或者栈为空。
> 3. 入栈保持栈的递增。

### 思考
对于这种需要维护一个性质的问题，通常可以这样思考：先假设有这样一个性质，再考虑如何构造和维护这个性质。

{% note primary %}
__原题链接：__ [AcWing 830. 单调栈](https://www.acwing.com/problem/content/832/)
{% endnote %}

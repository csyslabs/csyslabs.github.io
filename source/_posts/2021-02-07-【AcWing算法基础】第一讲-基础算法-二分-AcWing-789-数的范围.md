---
title: 【AcWing算法基础】第一讲-基础算法-二分 AcWing 789. 数的范围
comments: true
date: 2021-02-07 20:40:35
tags:
    - 算法
    - AcWing
    - 二分查找
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
二分查找模板题。
<!-- more -->

### 题目
给定一个按照升序排列的长度为 $n$ 的整数数组，以及 $q$ 个查询。
对于每个查询，返回一个元素 $k$ 的起始位置和终止位置（位置从 $0$ 开始计数）。
如果数组中不存在该元素，则返回 “$-1 -1$”。

__输入格式__
第一行包含整数 $n$ 和 $q$，表示数组长度和询问个数。
第二行包含 $n$ 个整数（均在 $[1,10000]$ 范围内），表示完整数组。
接下来 $q$ 行，每行包含一个整数 $k$，表示一个询问元素。

__输出格式__
共 $q$ 行，每行包含两个整数，表示所求元素的起始位置和终止位置。
如果数组中不存在该元素，则返回“$-1 -1$”。

__数据范围__
+ $ 1≤n≤100000 $
+ $ 1≤q≤10000 $
+ $ 1≤k≤10000 $

__输入样例：__
> 6 3
> 1 2 2 3 3 4
> 3
> 4
> 5

__输出样例：__
> 3 4
> 5 5
> -1 -1

___

一段升序数组，找到某数字的左右边界。比如对于 $[1, 2, 2, 3, 3, 4]$, 找到 $2$ 的左右边界。

那么要想找到左边界，它的左边满足条件 $nums[i] < 2$，右边满足条件 $nums[i] >= 2$.
按照这个规则去二分查找，则一定只能找到左边界而不会找到右边界去。

要想找到右边界，它的左边满足条件 $nums[i] <= 2$, 右边满足条件 $nums[i] > 2$.
那么按照这一规则去二分查找，找到的一定是右边界而非左边界。

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

static const int N = 1e5 + 7;
static int n, q, a[N], qry;

int main()
{
    ios::sync_with_stdio(false), cin.tie(0);
    cin >> n >> q;
    for (int i = 0; i < n; i++) cin >> a[i];
    
    for (; q--;) 
    {
        cin >> qry;
        int lo = 0, hi = n - 1;
        for (; lo < hi;)
        {
            int mid = lo + hi >> 1;
            if (a[mid] < qry) lo = mid + 1;
            else hi = mid;
        }
        if (a[lo] == qry) 
        {
            cout << lo << " ";
            
            lo = 0, hi = n - 1;
            for (; lo < hi;) 
            {
                int mid = lo + hi + 1 >> 1;
                if (a[mid] > qry) hi = mid - 1;     // 注意如果出现 mid - 1的情况，则上面mid 需要 lo + hi + 1操作。这是进过严格验证的。
                else lo = mid;
            }            

            cout << hi << endl;
        } 
        else {
            cout << -1 << " " << -1 << endl;
        }
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

{% note primary %}
__原题链接：__ [AcWing 789. 数的范围](https://www.acwing.com/problem/content/791/)
{% endnote %}


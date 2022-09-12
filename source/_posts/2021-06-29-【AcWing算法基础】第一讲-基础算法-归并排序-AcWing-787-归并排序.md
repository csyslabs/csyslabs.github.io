---
title: 【AcWing算法基础】第一讲-基础算法-归并排序 AcWing 787. 归并排序
comments: true
date: 2021-06-29 11:52:06
tags:
    - 算法
    - AcWing
    - 排序
    - 归并排序
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
经典归并排序模板。
<!-- more -->

### 题目

给定你一个长度为 $n$ 的整数数列。

请你使用归并排序对这个数列按照从小到大进行排序。

并将排好序的数列按顺序输出。

__输入格式__

输入共两行，第一行包含整数 $n$。

第二行包含 $n$ 个整数（所有整数均在 $1∼10^9$ 范围内），表示整个数列。

__输出格式__

输出共一行，包含 $n$ 个整数，表示排好序的数列。

__数据范围__

+ $1≤n≤100000$

__输入样例：__
> 5
3 1 2 4 5

__输出样例：__
> 1 2 3 4 5

___

### 归并排序

归并排序的核心思想是递归地将原数组划分成两段，在不可再分的时候（一对数或一个数）进行第一次双指针排序。
然后在「归」的过程利用上一层已经排序好的两段，将它们使用双指针合并排序。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;

constexpr int N = 100010;
int a[N], tmp[N];

void ms(int lo, int hi)
{
    if (lo >= hi) return;
    int mid = lo + hi >> 1;
    ms(lo, mid), ms(mid + 1, hi);
    int i = lo, j = mid + 1;
    int idx = 0;
    for (; i <= mid && j <= hi;) {              // 对于两段升序子数组，用双指针进行合并排序
        if (a[i] <= a[j]) tmp[idx++] = a[i++];
        else tmp[idx++] = a[j++];
    }
    // 如果某一段较另一段提前完成，需要将另一段加入到已排序临时数组后面。注意另一段数组元素一定大于等于已排序的临时数组
    for (; i <= mid;) tmp[idx++] = a[i++];
    for (; j <= hi; ) tmp[idx++] = a[j++];
    // 将已排序的临时数组覆盖原数组
    for (int re = lo, t = 0; re <= hi;) a[re++] = tmp[t++];
}

int main()
{
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) cin >> a[i];
    ms(0, n - 1);
    for (int i = 0; i < n; i++) cout << a[i] << ' ';
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

{% note primary %}
__原题链接：__ [AcWing 787. 归并排序](https://www.acwing.com/problem/content/789/)
{% endnote %}
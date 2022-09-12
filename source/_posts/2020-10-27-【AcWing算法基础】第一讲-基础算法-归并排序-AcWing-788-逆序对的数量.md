---
title: 【AcWing算法基础】第一讲-基础算法-归并排序 AcWing 788. 逆序对的数量
comments: true
date: 2020-10-27 18:06:57
tags:
    - 算法
    - AcWing
    - 排序 
    - 归并排序
    - 树状数组
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
归并排序模板题。
<!--more-->

### 题目
给定一个长度为 $n$ 的整数数列，请你计算数列中的逆序对的数量。

逆序对的定义如下：对于数列的第 $i$ 个和第 $j$ 个元素，如果满足 $i < j$ 且 $a[i] > a[j]$，则其为一个逆序对；否则不是。

__输入格式__
第一行包含整数 $n$ ，表示数列的长度。

第二行包含 $n$ 个整数，表示整个数列。

__输出格式__
输出一个整数，表示逆序对的个数。

__数据范围__
+ $1≤n≤100000$

__输入样例：__
> 6
> 2 3 4 5 6 1

__输出样例：__
> 5

___

### 归并排序

两种写法，一种是先利用归并排序已排好的左右两组升序子数组单调递增的特性，利用双指针找到当前两组子数组中所有逆序对。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;

constexpr int N = 100010;
int a[N], tmp[N];
long long res;

void helper(int lo, int hi)
{
    if (lo >= hi) return;
    int mid = lo + hi >> 1;
    helper(lo, mid), helper(mid + 1, hi);
    int i = lo, j = mid + 1;

    for (; i <= mid && j <= hi; j++) {
        for(; i <= mid && a[i] <= a[j]; i++);
        if (i <= mid) {
            res += mid - i + 1;
        }
    }
    
    i = lo, j = mid + 1;

    int t = 0;
    for (; i <= mid && j <= hi;) {
        if (a[i] <= a[j]) tmp[t++] = a[i++];
        else tmp[t++] = a[j++];
    }
    for (; i <= mid;) tmp[t++] = a[i++];
    for (; j <= hi;) tmp[t++] = a[j++];
    for (t = 0, i = lo; i <= hi;) a[i++] = tmp[t++];
}

int main()
{
    cin.tie(nullptr)->sync_with_stdio(false);
    int n;
    cin >> n;
    for (int i = 0; i < n; i++) cin >> a[i];
    
    helper(0, n - 1);
    //for (int i = 0; i < n; i++) cout << a[i] << ' ';
    cout << res << endl;
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

另一种是在归并排序的左右两组判断的过程中，顺便记录逆序对的数量。

{% tabs g_tab1 %}
<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

typedef long long LL;
const int N = 100010;
int n;
int nums[N];
int tmp[N];
LL res = 0;

void helper(int lo, int hi)
{
    if (lo >= hi) return;
    int mid = lo + hi >> 1;
    helper(lo, mid), helper(mid + 1, hi);
    int i = lo, j = mid + 1;
    int t = 0;
    for (;i <= mid && j <= hi;) 
    {
        if (nums[i] <= nums[j]) tmp[t++] = nums[i++];
        else 
        {
            tmp[t++] = nums[j++];
            res += mid - i + 1;
        }
    }
    for (;i <= mid;) tmp[t++] = nums[i++];
    for (;j <= hi;) tmp[t++] = nums[j++];
    for (int i = lo, j = 0; i <= hi;) nums[i++] = tmp[j++];
}

int main()
{
    scanf("%d", &n);
    for (int i = 0; i < n; i ++) scanf("%d", &nums[i]);
    helper(0, n - 1);
    cout << res << endl;
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

显然后者省去了只用了一次双指针，而前者则是多了一次双指针过程。
实测后者比前者快一倍。

{% note primary %}
__原题链接：__ [AcWing 788. 逆序对的数量](https://www.acwing.com/problem/content/790/)
{% endnote %}
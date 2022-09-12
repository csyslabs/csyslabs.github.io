---
title: 【AcWing算法基础】第一讲-基础算法-双指针算法 AcWing 800. 数组元素的目标和
comments: true
date: 2020-11-11 13:43:09
tags:
    - 算法
    - AcWing
    - 双指针
    - 二分查找
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
一道双指针题目。
<!--more-->

### 题目
给定两个升序排序的有序数组 $A$ 和 $B$，以及一个目标值 $x$。

数组下标从 $0$ 开始。

请你求出满足 $A[i] + B[j] = x$ 的数对 $(i, j)$。

数据保证有唯一解。

__输入格式__

第一行包含三个整数 $n$ ，$m$，$x$，分别表示 $A$ 的长度，$B$ 的长度以及目标值 $x$。
第二行包含 $n$ 个整数，表示数组 $A$。
第三行包含 $m$ 个整数，表示数组 $B$。

__输出格式__
共一行，包含两个整数 $i$ 和 $j$。

__数据范围__
+ 数组长度不超过 $100000$。
+ 同一数组内元素各不相同。
+ $1≤$数组元素$≤10^9$

__输入样例：__
> 4 5 6
> 1 2 4 7
> 3 4 6 8 9

__输出样例：__
> 1 1

___

### 双指针
类似夹逼准则。充分利用两个数组都是递增的特性。
维护两个指针，指针 `i` 从数组1的低位向高位遍历，指针 `j` 从数组2的高位向低位遍历，一直向正确的数值逼近。
`j` 先向左移动，直到找到一个数，使得与 `i` 对应的数之和小于目标值，此时排除掉 `j` 右侧所有数，正确的 `i` 和 `j` 应该分别分布在 `i` 的右侧和 `j` 的左侧。
`i` 再向右移动，直到找到一个数，使得与 `j` 对应的数之和小于目标值，此时排除掉 `i` 左侧所有数，正确的 `i` 和 `j` 应该分布在 `i` 的右侧和 `j` 的左侧。
A数组：`i____________________________________`
B数组：`______________________________<-j`
A数组：`i____________________________________`
B数组：`____________________j_____被排除_____`
A数组：`i->____________________________________`
B数组：`____________________j_____被排除_____`
A数组：`____被排除____i____________________________`
B数组：`____________________j_____被排除_____`
重复上述过程，直到找到正确的 `i` 和 `j`。

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
/*
 * 2021-7-6 01:11:38
 * author: etoa
 */
#include <bits/stdc++.h>

using namespace std;

using LL = long long;

constexpr int N = 100010;
LL a[N], b[N];

int main()
{
    cin.tie(nullptr)->sync_with_stdio(false);
    int n, m;
    cin >> n >> m;
    int x;
    cin >> x;
    for (int i = 0; i < n; i++) cin >> a[i];
    for (int i = 0; i < m; i++) cin >> b[i];
    
    int lo = 0, hi = m - 1;
    for (; lo < n && hi >= 0 && a[lo] + b[hi] != x;) {
        for (; a[lo] + b[hi] > x; --hi);
        for (; a[lo] + b[hi] < x; ++lo);
    }
    cout << lo << ' ' << hi << endl;
    return 0;
}
```
<!-- endtab -->

<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

const int N = 1e5 + 10;

int n, m, x;
int a[N], b[N];

int main()
{
    scanf("%d%d%d", &n, &m, &x);
    for (int i = 0; i < n; i ++ ) scanf("%d", &a[i]);
    for (int i = 0; i < m; i ++ ) scanf("%d", &b[i]);

    for (int i = 0, j = m - 1; i < n; i ++ )
    {
        while (j >= 0 && a[i] + b[j] > x) j -- ;
        if (j >= 0 && a[i] + b[j] == x) cout << i << ' ' << j << endl;
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

因为 `i` 和 `j` 最多共执行 $N$ 次，所以算法复杂度为：$O(N)$.

### 二分查找

对于数组1中的每个数，通过目标数计算出应该存在于数组2中的值，再用二分查找的方式在数组2中查找。
该方法只利用了一个数组的单调性。

{% tabs g_tab1 %}
<!-- tab C++ -->
```C++
#include <iostream>

using namespace std;

const int N = 100010;

int a[N], b[N];


int find(int t, int m)
{
    int l = 0, r = m - 1;
    for (; l < r;) {
        int mid = l + r >> 1;
        if (b[mid] >= t) r = mid;
        else l = mid + 1;
    }
    if (b[l] != t) return -1;
    else return l;
}

int main()
{
    int n, m, x;
    cin >> n >> m >> x;
    for (int i = 0; i < n; i ++ ) scanf("%d", &a[i]);
    for (int i = 0; i < m; i ++ ) scanf("%d", &b[i]);
    for (int i = 0; i < n; i ++ ) {
        int t = x - a[i];
        // finds t in b
        int j = find(t, m);
        if (j != -1) {
            cout << i << ' ' << j << endl;
        }
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

遍历一遍数组共计算 $N$ 次，每次进行一次复杂度为 $O(LogN)$ 的二分查找，所以总的复杂度为：$O(NLogN)$

{% note primary %}
__原题链接：__ [AcWing 800. 数组元素的目标和](https://www.acwing.com/problem/content/description/802/)
{% endnote %}

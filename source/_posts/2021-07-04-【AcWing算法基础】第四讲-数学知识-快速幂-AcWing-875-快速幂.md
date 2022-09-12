---
title: 【AcWing算法基础】第四讲-数学知识-快速幂 AcWing 875. 快速幂
comments: true
date: 2021-07-04 23:46:47
tags:
    - 算法
    - AcWing
    - 数学
    - 数论
    - 快速幂
    - 位运算
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第四讲数学知识]
---
__摘要：__
经典快速求幂的算法。
<!-- more -->

### 题目

给定 $n$ 组 $a_i$, $b_i$, $p_i$，对于每组数据，求出 $a_i^{b_i} \bmod p_i$ 的值。

__输入格式__

第一行包含整数 $n$。

接下来 $n$ 行，每行包含三个整数 $a_i$, $b_i$, $p_i$。

__输出格式__

对于每组数据，输出一个结果，表示 $a_i^{b_i} \bmod p_i$ 的值。

每个结果占一行。

__数据范围__
+ $1≤n≤100000$,
+ $1≤a_i, b_i, p_i≤2×10^9$

__输入样例：__
> 2
3 2 5
4 3 9

__输出样例：__
> 4
1

___

### 二进制反复平方

本题是模意义下取幂，我们知道取模运算不会干涉乘法运算。所以我们核心关注如何求 $a^b$.

如果我们可以将 $b$ 拆分成 $2^{x_1} + 2^{x_2} + ... + 2^{x_i}$，那么

$a^b = a^{2^{x_1} + 2^{x_2} + ... + 2^{x_i}}$ (即$a^b = a^{2^{x_1}} \times a^{2^{x_2}} \times ... \times a^{2^{x_i}}$).

显然这是将 $b$ 转化为 $2$ 进制后进行 $10$ 进制展开的结果，很轻松可以做到。

那么现在考虑如何快速获得 $a^{2^{x_1}} \times a^{2^{x_2}} \times ... \times a^{2^{x_i}}$ 的值。

我们可以很方便地预处理出来 $a^{2^0}, a^{2^1}, a^{2^2} ... a^{2^{log_2b}}$ 的序列。其中最后一项 $a^{2^{log_2b}}$ 需要刚好小于等于 $a^{b}$.

有了这样一个序列，我们就可以从中选择需要的数字相乘即可得到最终答案。显然，当 $b$ 的二进制位为1的时候就是对应需要的值（如果二进制位为 $0$，则 $10$ 进制展开的时候是 $0 \times 2^{x_i}$，相加的时候被忽略）。

在预处理过程中，每一项都是由前一项平方得到，那么整个算法的时间复杂度为 $O(logb)$.

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;
using LL = long long;

inline LL ksm(int &a, int &b, int &p)
{
    LL res = 1; // 2的零次幂
    while (b) {
        // 如果b的最后一位是1，那么将b拆成2进制表示再分解成若干个2的xi次幂因式的时候，某一个因式对应着该位
        if (b & 1) res = res * a % p;  // a,b >= 1，所以至少需要算一下第一次a的2的0次幂(等于a)，所以res初始化为1. 随后的计算, a被更新成对应a的2的若干次幂
        // 不管b最后一位是否是1，都需要反复求a的平方，直到a的2的x次幂 > a的b次幂，此时一共计算了log_2b次
        a = (LL)a * a % p;  // 下一次a更新成本次a的平方，其中a = a的2的xi次幂
        b >>= 1;    // b右移一位，直到为0退出循环
    }
    return res;
}

int main()
{
    cin.tie(nullptr)->sync_with_stdio(false);
    int n;
    cin >> n;
    int a, b, p;
    while (n--) {
        cin >> a >> b >> p;
        cout << ksm(a, b, p) << endl;    
    }
    
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

现在证明模意义下取幂的正确性：
根据模运算性质可知，
$x \times y \bmod p = x \bmod p \times y \bmod p$.

那么，$a^b \bmod p = (a^{2^{x_1}} \times a^{2^{x_2}} \times ... \times a^{2^{x_i}}) \bmod p$.

即$a^b \bmod p = (a^{2^{x_1}} \bmod p \times a^{2^{x_2}} \bmod p \times ... \times a^{2^{x_i}} \bmod p) \bmod p$.

那么每次 $a$ 的迭代 $\bmod p$ 一次，对应上式中每一项 $\bmod p$，每次 $res$ 计算的时候 $\bmod p$ 一次对应上式中最后面的 $\bmod p$.

取模运算不会干涉乘法运算。

{% note primary %}
__原题链接：__ [AcWing 875. 快速幂](https://www.acwing.com/problem/content/description/877/)
{% endnote %}
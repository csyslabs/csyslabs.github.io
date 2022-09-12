---
title: 【LeetCode周赛248】C LeetCode 5802. 统计好数字的数目
comments: true
date: 2021-07-05 01:14:16
tags:
    - 算法
    - LeetCode
    - 竞赛
    - 数学
    - 数论
    - 快速幂
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛, 248]
---
__摘要：__
经典模意义下快速幂应用。
<!-- more -->

### 题目

我们称一个数字字符串是 __好数字__ 当它满足（下标从 $0$ 开始）__偶数__ 下标处的数字为 __偶数__ 且 __奇数__ 下标处的数字为 __质数__ （$2$，$3$，$5$ 或 $7$）。

+ 比方说，$2582$ 是好数字，因为偶数下标处的数字（$2$ 和 $8$）是偶数且奇数下标处的数字（$5$ 和 $2$）为质数。但 $3245$ __不是__ 好数字，因为 $3$ 在偶数下标处但不是偶数。

给你一个整数 $n$ ，请你返回长度为 $n$ 且为好数字的数字字符串 __总数__ 。由于答案可能会很大，请你将它对 $10^9 + 7$ __取余后返回__ 。

一个 __数字字符串__ 是每一位都由 $0$ 到 $9$ 组成的字符串，且可能包含前导 $0$ 。

__示例 1：__

> 输入：n = 1
输出：5
解释：长度为 1 的好数字包括 "0"，"2"，"4"，"6"，"8" 。

__示例 2：__

> 输入：n = 4
输出：400

__示例 3：__

> 输入：n = 50
输出：564908303
 
__提示：__

+ $1 <= n <= 10^{15}$

___

### 快速幂

对于长度为 $n$ 的数字，偶数位对应着 $0, 2, 4, 6, 8$ 共 $5$ 种选择；奇数位对应着 $2, 3, 5, 7$ 共 $4$ 种选择。

偶数位共有 $\lceil n / 2 \rceil$ 个，奇数位共有 $\lfloor n / 2 \rfloor$ 个。

那么答案应该是 $5^{\lceil n / 2 \rceil} \times 4^{\lfloor n / 2 \rfloor} \bmod (10^9 + 7)$.

使用模意义下的快速幂可以在 $O(log(\lceil n / 2 \rceil + \lfloor n / 2 \rfloor))$ 复杂度内算出。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
using LL = long long;
constexpr int MOD = 1'000'000'007;

class Solution {
public:
    inline LL ksm(LL a, LL b, LL MOD) {
        LL res = 1;
        while (b) {
            if (b & 1) res = res * a % MOD;
            a = a * a % MOD;
            b >>= 1;
        }
        return res;
    }
    
    int countGoodNumbers(LL n) {
        LL even = n + 1 >> 1;
        LL odd = n >> 1;
        return (ksm(5, even, MOD) * ksm(4, odd, MOD)) % MOD;
    }
};
```
<!-- endtab -->
{% endtabs %}


{% note primary %}
__原题链接：__ [LeetCode 5802. 统计好数字的数目](https://leetcode-cn.com/problems/count-good-numbers/)
{% endnote %}
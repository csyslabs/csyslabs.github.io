---
title: LeetCode 168. Excel表列名称
comments: true
date: 2021-06-29 10:10:42
tags:
    - 算法
    - LeetCode
    - 蓝桥杯
    - 进制转换
categories:
    - [指尖飞舞, 算法, LeetCode]
---
__摘要：__
稍微复杂点的26进制问题。本题来自第八届蓝桥杯省赛C++C组。
<!-- more -->

### 题目

给定一个正整数，返回它在 Excel 表中相对应的列名称。

例如，
```
    1 -> A
    2 -> B
    3 -> C
    ...
    26 -> Z
    27 -> AA
    28 -> AB 
    ...
```

__示例 1:__

输入: 1
输出: "A"

__示例 2:__

输入: 28
输出: "AB"

__示例 3:__

输入: 701
输出: "ZY"

### 找规律

因为对于给定的 $10$ 进制，在直接换算成 $16$ 进制的时候，会遇到余数为 $0$ 的问题。而 $0$ 无法对应 $26$ 进制中的某一个数。

通过观察规律，不难发现，一个十进制数 $n$ 可以拆分成 $x \times 26 + y$ 的形式，其中 $x >= 0, 0 <= y <= 26$.
+ 当 $x = 0$ 时，不予考虑；
+ 当 $x <= 26$ 时，它对应 $[A,Z]$ 的一个字母；
+ 当 $x > 26$ 时，递归地将 $x$ 拆成 $xx \times 26 + yy$ 的形式；
+ 当 $y = 0$ 时，对应 $26$，需要从 $x$ 借 $1$ 位；
+ 当 $0 < y < 26$ 时，对应 $[A,Z]$ 的一个字母。

举例：
> 根据如上规律，对 $703$ 进行拆分：
>
> $703 = (1 \times 26 + 1) \times 26 + 1$
> 
> 即 $AAA$.

> 对 $702$ 进行拆分：
> 
> $702 = 26 \times 26 + 26$
>
> 即 $ZZ$


{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
class Solution {
public:

    string convertToTitle(int n) {
        string res = "";
        vector<int> t;
        helper(n, t);
        for (int i = t.size() - 1; i >= 0; i--) {
            res += t[i] - 1 + 'A';
        }
        return res;
    }

    // x * 26 + y
    void helper(int n, vector<int> &t) {
        if (n <= 26) {
            t.push_back(n);
            return;
        }
        int x = n / 26, y = n % 26;
        if (!y) x--, y = 26;
        t.push_back(y);
        helper(x, t);
    }
};
```
<!-- endtab -->
{% endtabs %}

{% note primary %}
__原题链接：__ [LeetCode 168. Excel表列名称](https://leetcode-cn.com/problems/excel-sheet-column-title/)
{% endnote %}
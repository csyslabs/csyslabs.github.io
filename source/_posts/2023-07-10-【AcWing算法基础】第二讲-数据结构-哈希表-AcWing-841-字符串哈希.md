---
title: 【AcWing算法基础】第二讲-数据结构-哈希表-AcWing 841. 字符串哈希
comments: true
date: 2023-07-10 22:54:09
tags:
    - 算法
    - AcWing 
    - 字符串哈希
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
字符串前缀哈希法。
<!-- more -->

### 题目
给定一个长度为 $n$ 的字符串，再给定 $m$ 个询问，每个询问包含四个整数 $l1,r1,l2,r2$，请你判断 $[l1,r1]$ 和 $[l2,r2]$ 这两个区间所包含的字符串子串是否完全相同。
字符串中只包含大小写英文字母和数字。

__输入格式__
第一行包含整数 $n$ 和 $m$，表示字符串长度和询问次数。

第二行包含一个长度为 $n$ 的字符串，字符串中只包含大小写英文字母和数字。

接下来 $m$ 行，每行包含四个整数 $l1,r1,l2,r2$，表示一次询问所涉及的两个区间。

注意，字符串的位置从 $1$ 开始编号。

__输出格式__
对于每个询问输出一个结果，如果两个字符串子串完全相同则输出 $Yes$，否则输出 $No$。

每个结果占一行。

__数据范围__
$1≤n,m≤10^5$

__输入样例：__
> 8 3
> aabbaabb
> 1 3 5 7
> 1 3 6 8
> 1 2 1 2

__输出样例：__
> Yes
> No
> Yes

### 代码

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;
using ull = unsigned long long;

int n, m;
string s;

constexpr int P_VAL = 131;
constexpr int N = 1e5 + 10;
ull h[N], p[N];

void create_string_hash()
{
    if (n < 1) return;
    p[0] = 1; h[0] = 0;
    for (int i = 1; i <= n; ++ i)
    {
        p[i] = p[i - 1] * P_VAL;
        h[i] = h[i - 1] * P_VAL + s[i - 1]; 
    }
}


// the unsigned long long value overflow will equivalent to the value mod max value of unsigned long long 
ull get_hash_val(int l, int r)
{
    if (false) 
    {
        l = l ^ r;
        r = l ^ r;
        l = l ^ r;
    }
    return h[r] - h[l - 1] * p[r - l + 1];
}

int main()
{
    cin >> n >> m;
    cin >> s;
    create_string_hash();
    for (; m--;)
    {
        int l1, r1, l2, r2;
        cin >> l1 >> r1 >> l2 >> r2;
        ull hash_val_1 = get_hash_val(l1, r1);
        ull hash_val_2 = get_hash_val(l2, r2);
        //cout << hash_val_1 << " " << hash_val_2 << endl;
        if (hash_val_1 == hash_val_2) cout << "Yes" << endl;
        else cout << "No" << endl;
    }
}
```
<!-- endtab -->

<!-- tab Java -->
```java

```
<!-- endtab -->
{% endtabs %}


### 理解
字符串前缀哈希法，本质就是不把字符串当字符串看待，而是把字符串看成一个 $P$ 进制的数。

假设有字符串 `12345678`， 我们把它看做一个 $P = 10$ 进制的数。

现在我们规定一个示例哈希算法为：每个字符的哈希值为当前字符减 `1` 这个字符得到的结果。

那么在整个字符串中，位于 $1$ 到 $8$ 区间内的字符串哈希值 $Hash(1, 8) = 12345678$.

下面我们研究子串的哈希关系。

位于 $1$ 到 $6$ 区间内的字符串哈希值 $Hash(1, 6) = 123456$.

显然位于 $7$ 到 $8$ 区间内的字符串哈希值: 
$$Hash(7, 8) = 78 = 12345678 - 12345600 = 12345678 - 123456 \times 10^2$$
$$=$$
$$Hash(1, 8) - Hash(1, 6) \times 10^{8 - 7 + 1}$$

有结论：
对于一个 $P$ 进制字符串，它的 $l$ 到 $r$ 下标之间的子串哈希值满足如下公式：
$$Hash(l, r) = Hash(1, r) - Hash(1, l - 1) \times P^{r - l + 1}$$

在本题中，预处理前缀哈希数组 $h$，$h[i]$ 表示位于 $1$ 到 $i$ 之间的字符串哈希值。
根据上述结论有：

$$Hash(i, i) = Hash(1, i) - Hash(1, i - 1) \times P^{1}$$

其中 $Hash(i, i)$ 为第 $i$ 个字符的哈希值。
即 $h[i] = Hash(i, i) + h[i - 1] \times P$.

__小技巧__
> 1. 根据经验，本题 $P$ 值 可以取值 $131$ 或 $13331$。
>
> 2. 如果字符串超长，那么哈希得到的值会溢出，需要取模，我们使用 `unsigned long long` 溢出特性来自动对该类型最大值取模。

{% note primary %}
__原题链接：__ [AcWing 841. 字符串哈希](https://www.acwing.com/problem/content/843/)
{% endnote %}
---
title: 【AcWing算法基础】第二讲-数据结构-Trie AcWing 143. 最大异或对
comments: true
date: 2022-09-16 21:50:45
tags:
    - 算法
    - AcWing
    - 字典树
    - Trie
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
Trie字典树不仅可以存储字符串，也可以存储二进制数，所以理论上Trie可以存储任意信息。
<!-- more -->

### 题目
在给定的 $N$ 个整数 $A_1，A_2……A_N$ 中选出两个进行 $xor$（异或）运算，得到的结果最大是多少？

__输入格式__
第一行输入一个整数 $N$。

第二行输入 $N$ 个整数 $A_1～A_N$。

__输出格式__
输出一个整数表示答案。

__数据范围__
$1≤N≤10^5$,

$0≤A_i<2^{31}$

__输入样例：__
> 3
> 1 2 3

__输出样例：__
> 3
___
### Trie

暴力做法是遍历数组，对每个数，在剩余数中遍历找到和它异或最大的值。

可以对遍历找到最大异或值的步骤进行优化。

如果不考虑最大异或值的取值范围，某个数最大异或值，一定是其二进制每一位都不同的数。然而在这里取值范围是所有其他的数。

对该数二进制从左到右，我们在剩余数中找到一个数，使得其对应位的二进制值不同，如果没有则取相同。

可以使用 `Trie` 实现。构建 `Trie` 时，将每个数的二进制位从根节点开始插入。
查询某个数的最大异或值时，从根节点查找，如果存在二进制值相反的节点则选择该节点，不存在则选择二进制值相同的节点。


{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;
using ll = long long;

const int N = 100009;
int n, numbers[N];
int trie[31 * N][2];
int idx;


void build_trie(int &num)
{
    int p = 0;
    for (int i = 30; ~i; --i)
    {
        int u = num >> i & 1;
        if (!trie[p][u]) trie[p][u] = ++idx;
        p = trie[p][u];
    }
}

ll query(int &num)
{
    int p = 0;
    ll target = 0;
    for (int i = 30; ~i; --i)
    {
        int u = num >> i & 1;
        if (trie[p][!u]) 
        {
            target = (target << 1) + !u;
            p = trie[p][!u];
        }
        else 
        {
            target = (target << 1) + u;
            p = trie[p][u];
        }
    }
    return target;
}

int main() 
{
    cin.tie(nullptr)->sync_with_stdio(false);
    cin >> n;
    for (int i = 0; i < n; ++i) cin >> numbers[i];
    
    ll res = 0;
    for (int i = 0; i < n; ++i)
    {
        int cur = numbers[i];
        build_trie(cur);
        res = max(res, query(cur) ^ cur);
    }
    cout << res << endl;
    return 0;
}


```
<!-- endtab -->
{% endtabs %}

我们选择的是先对每个数拆分成二进制构建 `Trie`，再对每个数从 `Trie` 中查询最大异或值。
注意下 `Trie` 数组取值，因为最多 $10^5$ 个数，每个数最多 $31$ 位，所以数组行最多 $10^5 \times 31$，因为每个节点只存在两种值，$0$ 和 $1$，所以数组列为 $2$.

{% note primary %}
__原题链接：__ [AcWing 143. 最大异或对](https://www.acwing.com/problem/content/description/145/)
{% endnote %}
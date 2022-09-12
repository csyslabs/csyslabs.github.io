---
title: 【AcWing算法基础】第二讲-数据结构-Trie字符串统计 AcWing 835. Trie字符串统计
comments: true
date: 2022-09-07 10:56:22
tags:
    - 算法
    - AcWing
    - 前缀树
    - Trie
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
Trie模板题
<!-- more -->


### 题目

维护一个字符串集合，支持两种操作：

`I` `x` 向集合中插入一个字符串 `x`；
`Q` `x` 询问一个字符串在集合中出现了多少次。
共有 $N$ 个操作，输入的字符串总长度不超过 $10^5$，字符串仅包含小写英文字母。

__输入格式__
第一行包含整数 $N$，表示操作数。

接下来 $N$ 行，每行包含一个操作指令，指令为 `I` `x` 或 `Q` `x` 中的一种。

__输出格式__
对于每个询问指令 `Q` `x`，都要输出一个整数作为结果，表示 `x` 在集合中出现的次数。

每个结果占一行。

__数据范围__
$1 ≤ N ≤ 2 \times 10^4$

__输入样例：__
> 5
> I abc
> Q abc
> Q ab
> I ab
> Q ab

__输出样例：__
> 1
> 0
> 1

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include "bits/stdc++.h"


using namespace std;

const int N = 1e5 + 10;
int son[N][26], cnt[N], idx;

// son buffer -> stores the row of child node 
// a d c    a d e
static void build_tree(string &s)
{
    int p = 0;
    for (int i = 0, len = s.size(); i < len; ++i) {
        int c = s[i] - 'a';
        if (!son[p][c]) son[p][c] = ++idx;
        p = son[p][c];
    }
    // 以p行结束(叶子节点的"子节点"行)的字符串计数
    cnt[p]++;
}

static int query(string &s)
{
    int p = 0;
    for (int i = 0, len = s.size(); i < len; ++i) {
        int c = s[i] - 'a';
        if (!son[p][c]) return 0;
        p = son[p][c];
    }
    return cnt[p];
}

int main()
{
    cin.tie(nullptr)->sync_with_stdio(false);
    string t; cin >> t;
    string ops, s;
    for (; cin >> ops, cin >> s;) {
        if (ops == "I") build_tree(s);
        else if (ops == "Q") cout << query(s) << endl;
    }
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

### Trie前缀树
使用二维数组构建前缀树，每一个树节点对应二维数组中唯一的行，每行长度26对应26字母。
`son` 数组存放当前节点子节点所在行数。
当一个字符串插入到前缀树中时，使用统计数组 cnt 记录当前跟节点对应的字符串数量。
使用 `idx` 记录对全部节点计数，当新的结点出现时，可以知道用二维数组哪一行表示新的节点。


{% note primary %}
__原题链接：__ [AcWing 835. Trie字符串统计](https://www.acwing.com/problem/content/837/)
{% endnote %}
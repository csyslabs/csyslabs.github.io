---
title: 【AcWing算法基础】第二讲-数据结构-并查集 AcWing 836. 合并集合
comments: true
date: 2022-09-18 14:51:54
tags:
    - AcWing
    - 算法
    - 并查集
    - Union-Find
    - 树
    - 路径压缩
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
并查集模板题。
<!-- more -->


### 题目
一共有 $n$ 个数，编号是 $1∼n$，最开始每个数各自在一个集合中。

现在要进行 $m$ 个操作，操作共有两种：

1. `M a b`，将编号为 $a$ 和 $b$ 的两个数所在的集合合并，如果两个数已经在同一个集合中，则忽略这个操作；
2. `Q a b`，询问编号为 $a$ 和 $b$ 的两个数是否在同一个集合中；

__输入格式__
第一行输入整数 $n$ 和 $m$。

接下来 $m$ 行，每行包含一个操作指令，指令为 `M a b` 或 `Q a b` 中的一种。

__输出格式__
对于每个询问指令 `Q a b`，都要输出一个结果，如果 $a$ 和 $b$ 在同一集合内，则输出 `Yes`，否则输出 `No`。

每个结果占一行。

__数据范围__
$1≤n,m≤10^5$

__输入样例：__
> 4 5
> M 1 2
> M 3 4
> Q 1 2
> Q 1 3
> Q 3 4

__输出样例：__
> Yes
> No
> Yes
___
### 并查集/Union-Find
并查集用于解决两个不相交集合 __Disjoint Set__ 的合并 __Union__，以及查询两个数是否在同一集合中 __Find__ 的问题。
并查集可以以 $O(1)$ 的时间复杂度合并两个不相交集合，以及近乎 $O(1)$ 的时间复杂度查询两个数是否在同一集合中。

核心思想：
1. 维护一个森林 __Forest__，森林中每个节点保存该节点的父节点值。每棵树表示一个集合。
2. 合并两个集合 __Union__：找到两个集合所对应的树根节点，将其中一棵树的根节点作为另一棵树根节点的子节点。本质上是合并两颗多叉树。
3. 查找两个数是否在同一集合 __Find__：分别查找两个数对应森林节点的树根节点，判断根节点是否相同。

路径压缩优化 __Path Compression__：
> 在实现 __Find__ 时，需要根据当前数在树中自底向上找到父节点直到树根。
可以在这个过程中压缩路径，即，找到根节点后，将路径中的每个节点的父节点指向根节点。

实现：
{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include <bits/stdc++.h>

using namespace std;

const int N = 1e5 + 10;

int n, m, a, b;
char ops;
int parent[N];

void init_forest()
{
    for (int i = 1; i <= n; ++i) parent[i] = i;
}

int find(int x)
{
    if (parent[x] != x) parent[x] = find(parent[x]);
    return parent[x];
}

int main()
{
    cin.tie(nullptr)->sync_with_stdio(false);
    cin >> n >> m;
    init_forest();
    for (; m--, cin >> ops >> a >> b;) 
    {
        if (ops == 'M') 
        {
            parent[find(a)] = find(b);
        }
        else 
        {
            if (find(a) == find(b)) cout << "Yes" << endl;
            else cout << "No" << endl;
        }
    }
    
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

1. 我们令 `parent[x] = x` 定义 `x` 为根节点。
2. 注意在实现 `find` 函数找根节点时，我们的做法是自底向上递归处理，在递归过程中如果发现当前节点不为根节点的话，就将当前节点的父节点通过递归的方式指向根节点。

{% note primary %}
__原题链接：__ [AcWing 836. 合并集合](https://www.acwing.com/problem/content/838/)
{% endnote %}
---
title: 【AcWing算法基础】第一讲-基础算法-离散化 AcWing 802. 区间和
comments: true
date: 2020-11-06 10:20:26
tags:
    - 算法
    - AcWing
    - 离散化
    - 二分查找
    - 前缀和
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
离散化模板题。
<!--more-->

### 题目
假定有一个无限长的数轴，数轴上每个坐标上的数都是 $0$。
现在，我们首先进行 $n$ 次操作，每次操作将某一位置 $x$ 上的数加 $c$。
接下来，进行 $m$ 次询问，每个询问包含两个整数 $l$ 和 $r$，你需要求出在区间 $[l, r]$ 之间的所有数的和。

__输入格式__
第一行包含两个整数 $n$ 和 $m$。
接下来 $n$ 行，每行包含两个整数 $x$ 和 $c$。
再接下里 $m$ 行，每行包含两个整数 $l$ 和 $r$。

__输出格式__
共 $m$ 行，每行输出一个询问中所求的区间内数字和。

__数据范围__
+ $−10^9≤x≤10^9$, 
+ $1≤n,m≤10^5$, 
+ $−10^9≤l≤r≤10^9$, 
+ $−10000≤c≤10000$ 

__输入样例：__
> 3 3
> 1 2
> 3 6
> 7 5
> 1 3
> 4 6
> 7 8

__输出样例：__
> 8
> 0
> 5
___
### 离散化

{% tabs g_tab %}
<!-- tab C++ -->
```C++
#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

typedef pair<int, int> PII;

const int N = 300010;                                           // 1
int a[N], s[N];                                                 // 11
vector<int> alls;                                               // 2
vector<PII> add, query;


int find(int x) 
{
    int l = 0, r = alls.size() - 1;
    for (; l < r;) {
        int mid = l + r >> 1;
        if (alls[mid] >= x) r = mid;
        else l = mid + 1;
    }
    return l + 1;                                               // 3
}

int main()
{
    int n, m;
    cin >> n >> m;
    for (; n -- ;) {                                            // 4
        int x, c;
        cin >> x >> c;
        alls.push_back(x);
        add.push_back({x, c});
    }
    for (; m -- ;) {                                            // 5
        int l, r;   
        cin >> l >> r;
        alls.push_back(l);
        alls.push_back(r);
        query.push_back({l, r});
    }
    sort(alls.begin(), alls.end());                             // 6
    alls.erase(unique(alls.begin(), alls.end()), alls.end());   // 7
    
    for (auto item : add) {                                     // 8
        a[find(item.first)] += item.second;
    }
    for (int i = 1; i <= alls.size(); i ++ ) {                  // 9
        s[i] = s[i - 1] + a[i];    
    }
    for (auto item : query) {                                   // 10
        int l = find(item.first), r = find(item.second);
        cout << s[r] - s[l - 1] << endl;
    }
    return 0;
}  
```
<!-- endtab -->
{% endtabs %}

> + 1. `add` 下标最多 `1e5` 个，`query` 下标最多 `2e5` 个。当最极端的情况出现时，下标总数可达到 `3e5`。
> + 2. 待离散化数组，存放 `add` 下标和 `query` 下标。
> + 3. 为了方便求前缀和，将 `add` 每一位映射到 `a` 数组向右偏移一位的位置（从 `1` 开始）。
> + 4. `add` 数据输入。
> + 5. `query` 数据输入。
> + 6. 排序为了方便二分查找映射下标。
> + 7. 去重为了让所有待离散化数据一一映射自己的下标。
> + 8. 处理映射数组，所有 `add` 下标对应统统加上相应的数；所有 `query` 下标对应默认为 `0`。
> + 9. 求前缀和数组。我们知道求前缀和数组需要从 `1` 开始取，但是这里为什么 __可以__ 从 `1` 开始遍历呢？因为 `alls` 数组是从 `0` 开始记录的，`find` 方法将坐标映射到下标时已经向右偏移了一位，所以 `a` 数组值 $> 0$ 的位置一定是 $> 0$ 的。另外注意到这里为什么要用 `alls.size()` 呢，那是因为离散化操作将所有的 `alls` 数组中的值全部映射到了 `a` 数组中，且前缀和数组长度一定和 `alls` 一样长。
> + 10. 输出查询
> + 11. 当数组范围大的时候一定要在 `main()` 函数外面开数组，因为在这里开数组其内存会被分配在数据区（堆），而在 `main()` 内开数组其内存你会被分配在代码区，数据量大的话会出错。

注意，由于vector数组自身的属性，此时是从 $0$ 开始记录的。由于我们要构建前缀和数组，在处理 `a` 数组时要从 $1$ 开始构建，所以在通过 `find` 方法找坐标下标时，要整体向右偏移一位。

__现在我们尝试描述一下a数组：__
`a` 数组存放着 `alls` 数组排序去重之后的所有值的下标，注意这里的下标是 `alls` 数组的。因为 `alls` 数组中存放着坐标轴上 `add` 操作和 `query` 操作涉及到的坐标，所以 `a` 数组中部分值为非零部分为零。非零的部分是 `add` 操作增加的数，零的部分包含 `query` 操作对应的没什么意义的 `0` 和剩下的一些留空数组元素 `0`.

本质上，`alls` 数组可以看成是一组映射关系。将可能取到极大或极小但数量有限的坐标和数组下标对应起来。其中，`alls` 数组的下标对应映射的结果，`alls` 数组的值对应原坐标轴的坐标。此后我们将 `alls` 数组的下标单独拿出来对应 `a` 数组，`alls` 数组的值单独拿出来放在 `a` 数组对应的下标处。这样就完成了离散化。

{% note primary %}
__原题链接：__ [AcWing 802. 区间和](https://www.acwing.com/problem/content/804/)
{% endnote %}

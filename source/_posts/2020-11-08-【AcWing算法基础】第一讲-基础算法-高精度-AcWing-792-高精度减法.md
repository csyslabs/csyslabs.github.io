---
title: 【AcWing算法基础】第一讲-基础算法-高精度 AcWing 792. 高精度减法
comments: true
date: 2020-11-08 23:26:45
tags:
    - 算法
    - AcWing
    - 高精度
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
高精度减法模板题。
<!--more-->

### 题目
给定两个正整数，计算它们的差，计算结果可能为负数。

__输入格式__
共两行，每行包含一个整数。

__输出格式__
共一行，包含所求的差。

__数据范围__
$1≤$ 整数长度$ ≤10^5$

__输入样例：__
> 32
> 11

__输出样例：__
> 21
___
注意这道题是两个正整数相减。
如果换成带负数的，进行判断正负之后，要么转化为两个正整数相加，要么依旧是两个正整数相减。
{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

bool cmp(vector<int> &a, vector<int> &b)
{
    if (a.size() != b.size()) return a.size() > b.size();
    for (int i = a.size() - 1; i >= 0; i -- ) {
        if (a[i] != b[i]) return a[i] > b[i];
    }
    return true;
}

vector<int> sub(vector<int> &m, vector<int> &n) 
{
    vector<int> res;
    for (int i = 0, t = 0; i < m.size(); i ++ ) {
        t += m[i];
        if (i < n.size()) t -= n[i];
        res.push_back((t + 10) % 10);                                               // 1
        if (t < 0) t = -1;
        else t = 0;
    }
    for (;res.size() > 1 && res.back() == 0;) res.pop_back();                       // 2
    return res;
}

int main()
{
    string a, b;
    cin >> a >> b;
    vector<int> m, n;
    for (int i = a.length() - 1; i >= 0; i -- )  m.push_back(a[i] - '0');
    for (int i = b.length() - 1; i >= 0; i -- )  n.push_back(b[i] - '0');
    vector<int> res;
    if (cmp(m, n)) res = sub(m, n);
    else {
        res = sub(n, m);
        cout << '-';
    }
    for (int i = res.size() - 1; i >= 0; i -- ) cout << res[i];
    return 0;
}
```
<!-- endtab -->
{% endtabs %}


> 1. 此处`t`有可能被减成了负数（最低可以取到-10，最高可取到9），此时向后一位借10，于是最低取到0；同时由于借10的时候并没有判断正负，所以+10可能会导致结果高于10。也就是说，此时运算过程放入`C`中的数可能的取值范围是：`(0, 19)`。这样我对10取模，即可得到正确的放入`C`中的数了。
注意，在把“优化”后的（指借位模10）运算结果放入`C`时，并没有把结果赋值给`t`，因为后面需要判断`t`的正负，以更新下一轮的`t`取值。如果赋值了，则`t`必然为正，无法更新进位信息。
> 2. 注意当A与B前几位部分相等时，C后面会存在'0'，如`123 - 120`结果类似`003`。但在结果仅为1位时，不用考虑。

{% note primary %}
__原题链接：__[AcWing 792. 高精度减法](https://www.acwing.com/problem/content/794/)
{% endnote %}

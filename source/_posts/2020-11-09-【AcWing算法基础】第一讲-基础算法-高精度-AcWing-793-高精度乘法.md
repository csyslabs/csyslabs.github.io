---
title: 【AcWing算法基础】第一讲-基础算法-高精度 AcWing 793. 高精度乘法
comments: true
date: 2020-11-09 21:41:25
tags:
    - 算法
    - AcWing
    - 高精度
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
高精度乘法模板题。
<!--more-->

### 题目
给定两个正整数 $A$ 和 $B$，请你计算 $A \times B$ 的值。

__输入格式__
共两行，第一行包含整数 $A$，第二行包含整数 $B$。

__输出格式__
共一行，包含 $A \times B$ 的值。

__数据范围__
+ $1≤A$ 的长度 $≤100000$
+ $0≤B≤10000$

__输入样例：__
> 2
> 3

__输出样例：__
> 6

___

注意这道题是两个正整数，一个超长位数乘一个短位数，在进行高精度乘法运算过程中，我们习惯将短位数和超长位的每一位进行乘法运算。
如果换成负数，本质还是一样的，无非就是多一次正负判断。
对于最终进位的处理，有两种方式：

### 方法一：进位依次对十取模放进res数组

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
#include <iostream>
#include <vector>

using namespace std;

vector<int> mul(vector<int> &m, int n)
{
    vector<int> res;
    int t = 0;
    for (int i = 0; i < m.size() || t; i ++ )                       // 1
    {
        if (i < m.size()) t += m[i] * b;
        res.push_back(t % 10);                                      // 2
        t /= 10;                                                    
    }
    for (; res.size() > 1 && res.back() == 0;) res.pop_back();      // 3
    return res;
}

int main()
{
    string a;
    int n;
    cin >> a >> n;
    vector<int> m;
    for (int i = a.length() - 1; i >= 0; i -- ) m.push_back(a[i] - '0');
    vector<int> res;
    res = mul(m, n);
    for (int i = res.size() - 1; i >= 0; i  -- ) cout << res[i];
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

> 1. 注意1处条件，当`m`没有遍历完的时候，需要一直和`n`相乘，更新进位`t`。当乘完的时候，依然进入处理进位`t`，只不过此时不需要和`n`相乘，而是直接模10获得最高位数。
> 2. 放入slot中的数一直都是对10取模。
> 3. 去除数组尾部（结果头部）零，当某一个数为零的时候，会出现全为零的情况，其他情况不会出现前导零。

### 方法二：进位直接放入res数组

{% tabs g_tab1 %}
<!-- tab C++ -->
```C++
#include <iostream>
#include <vector>

using namespace std;

vector<int> mul(vector<int> &m, int n)
{
    vector<int> res;
    int t = 0;
    for (int i = 0; i < m.size(); i ++ ) {
        t = m[i] * n + t;
        res.push_back(t % 10);
        t /= 10;
    }
    if (t) res.push_back(t);
    for (; res.size() > 1 && res.back() == 0;) res.pop_back();
    return res;
}

int main()
{
    string a;
    int n;
    cin >> a >> n;
    vector<int> m;
    for (int i = a.length() - 1; i >= 0; i -- ) m.push_back(a[i] - '0');
    vector<int> res;
    res = mul(m, n);
    for (int i = res.size() - 1; i >= 0; i  -- ) cout << res[i];
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

__注意：__ 在处理最终进位`t`的时候，方法一是对`t`再进入循环处理，这时候如果`t < 10`的话，只循环一次，但是如果`t >= 10`的话，需要反复进入循环，依次取模，除10.

{% note primary %}
__原题链接：__[AcWing 793. 高精度乘法](https://www.acwing.com/problem/content/795/)
{% endnote %}

---
title: 【AcWing算法基础】第一讲-基础算法-高精度 AcWing 794. 高精度除法
comments: true
date: 2020-11-09 22:02:30
tags:
    - 算法
    - AcWing
    - 高精度
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要：__
高精度除法模板题。
<!--more-->

### 题目
给定两个非负整数 $A$，$B$，请你计算 $A / B$ 的商和余数。

__输入格式__
共两行，第一行包含整数 $A$，第二行包含整数 $B$。

__输出格式__
共两行，第一行输出所求的商，第二行输出所求余数。

__数据范围__
+ $1≤A$ 的长度 $≤100000$, 
+ $1≤B≤10000$
+ $B$ 一定不为 $0$

__输入样例：__
> 7
> 2

__输出样例：__
> 3
> 1

___

不考虑负数情况，因为负数除法可以转化为两个正数相除。
和高精度加减乘不一样的是，高精度除法是从大整数高位开始的。在复习了小学二年级下册的相关内容后，我觉得算法基本上就是模拟除法竖式。
高精度加计算过程会产生进位，减计算过程会产生借位，乘计算过程会产生进位，而高精度除法计算过程会产生余数。
余数作为下一位的高位需要乘 $10$ 进行新一轮的除法运算。
以下为我写的代码，和模板可能有略微区别。

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

vector<int> div(vector<int> &A, int &b)
{
    vector<int> res;
    int r = 0;                                                         // 1  
    for (int i = 0; i < A.size(); i ++ ) {
        r = r * 10 + A[i];                                             // 2
        res.push_back(r / b);                                          // 3
        r %= b;                                                        // 4
    }
    reverse(res.begin(), res.end());                                   // 5
    for (; res.size() > 1 && res.back() == 0;) res.pop_back();
    b = r;
    return res;
} 

int main()
{
    string a;
    int b;
    cin >> a >> b;
    vector<int> A;
    for (int i = 0; i < a.length(); i ++ ) A.push_back(a[i] - '0');
    vector<int> res;
    res = div(A, b);
    for (int i = res.size() - 1; i >= 0; i -- ) cout << res[i];
    cout << endl << b;
}
```
<!-- endtab -->
{% endtabs %}

> 1. 初始化余数`r`aka `remain`。
> 2. 对于被除数`A`的每一位，需要将上一位除法运算产生的余数作为当前数的高位乘10加上当前数。
> 3. 用当前数作为被除数和除数`b`进行除法运算，放到结果槽中。
> 4. 将余数保留给下一位。
> 5. 首位可能产生0，所以我们将结果数组反转再去除结尾0.

{% note primary %}
__原题链接：__ [AcWing 794. 高精度除法](https://www.acwing.com/problem/content/796/)
{% endnote %}

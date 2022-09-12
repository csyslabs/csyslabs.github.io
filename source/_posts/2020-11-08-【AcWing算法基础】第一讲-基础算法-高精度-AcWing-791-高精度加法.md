---
title: 【AcWing算法基础】第一讲-基础算法-高精度 AcWing 791. 高精度加法
comments: true
date: 2020-11-08 23:19:50
tags:
    - 算法
    - AcWing
    - 高精度
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第一讲基础算法]
---
__摘要；__
高精度加法。
<!--more-->

### 题目
给定两个正整数，计算它们的和。

__输入格式__
共两行，每行包含一个整数。

__输出格式__
共一行，包含所求的和。

__数据范围__
$1 ≤$ 整数长度 $≤ 100000$

__输入样例：__
> 12
> 23

__输出样例：__
> 35

___

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
// C = A + B, A >= 0, B >= 0
#include <iostream>
#include <vector>

using namespace std;

vector<int> add(vector<int> &A, vector<int> &B)                             //1
{
    vector<int> C;
    int t = 0;
    for (int i = 0; i < A.size() || i < B.size(); i++)                      //2
    {
        if (i < A.size()) t += A[i];
        if (i < B.size()) t += B[i];
        C.push_back(t % 10);
        t /= 10;
    }
    if (t) C.push_back(1);                                                  //3
    return C;
}


int main()
{
    string a, b;
    cin >> a >> b;
    vector<int> A, B;
    for (int i = a.size() - 1; i >= 0; i-- ) A.push_back(a[i] - '0');
    for (int i = b.size() - 1; i >= 0; i -- ) B.push_back(b[i] - '0');
    auto C = add(A, B);
    for (int i = C.size() - 1; i >= 0; i --) cout << C[i];
}
```
<!-- endtab -->

<!-- tab C++ -->
```c++
/*
 * 2021-6-28 11:27:21
 * author: etoa
 */
#include <bits/stdc++.h>

using namespace std;

vector<int> add(string &a, string &b)
{
    vector<int> res;
    reverse(a.begin(), a.end()), reverse(b.begin(), b.end());
    
    int len1 = a.size(), len2 = b.size(), len = max(len1, len2);
    int t = 0;
    for (int i = 0; i < len; i++) {
        if (i < len1) t += a[i] - '0';
        if (i < len2) t += b[i] - '0';
        res.push_back(t % 10);
        t /= 10;
    }
    if (t) res.push_back(t);
    return res;
}

int main()
{
    string a, b;
    cin >> a >> b;
    vector<int> res = add(a, b);
    for (int i = res.size() - 1; i >= 0; i--) cout << res[i];
    return 0;
}
```
<!-- endtab -->
{% endtabs %}

> + 1. 以数组引用传入参数，可以避免没必要的数组拷贝。
> + 2. `A`或`B`至少有一个没有遍历完，都需要继续计算。
> + 3. 注意结束之后进位有可能非0.


{% note primary %}
__原题链接：__[AcWing 791. 高精度加法](https://www.acwing.com/problem/content/description/793/)
{% endnote %}



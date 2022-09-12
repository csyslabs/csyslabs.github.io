---
title: 【AcWing算法基础】第四讲-数学知识-质数 AcWing 868. 筛质数
comments: true
date: 2020-12-03 19:45:58
tags:
    - 算法
    - AcWing
    - 数学
    - 数论
    - 质数
    - 素数
    - 朴素筛
    - 埃氏筛
    - 线性筛
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第四讲数学知识]
---
__摘要：__
常见质数筛法。
<!-- more -->

### 题目
给定一个正整数 $n$，请你求出 $1$∼$n$ 中质数的个数。

__输入格式__
共一行，包含整数 $n$。

__输出格式__
共一行，包含一个整数，表示 $1$∼$n$ 中质数的个数。

__数据范围__
$1≤n≤10^6$

__输入样例：__
> 8

__输出样例：__
> 4

___

### 朴素筛
从2开始枚举，依次将当前数的倍数（$2 * i, 3 * i, 4 * i ... n$）标记为「非质数」，剩余的数就一定是质数。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
#include<bits/stdc++.h>

using namespace std;

const int N = 1e6 + 10;
int pr[N];
bool st[N];
int cnt;

int main()
{
    int n;
    cin >> n;
    
    for (int i = 2; i <= n; i++)
    {
        if (!st[i]) pr[++cnt] = i;              // we consider i is a prime num if i wasn't get sieved
        for (int j = i + i; j <= n; j+=i)       // sieves all the multiple nums of i
        {
            st[j] = true;
        }
    }
    
    cout << cnt << endl;
    return 0;
    
}
```
<!-- endtab -->
{% endtabs %}

### 埃氏筛
从2开始枚举，依次仅将质数的倍数标记为「非质数」，剩余的数一定是质数。

{% tabs g_tab1 %}
<!-- tab C++ -->
```c++
#include<bits/stdc++.h>

using namespace std;

const int N = 1e6 + 10;
int pr[N];
bool st[N];
int cnt;

int main()
{
    int n;
    cin >> n;
    
    for (int i = 2; i <= n; i++)
    {
        if (!st[i]) 
        {
            pr[++cnt] = i;                          // we consider i is a prime num if i wasn't get sieved   
            for (int j = i + i; j <= n; j+=i)       // sieves all the multiple nums of i when i is a prime num
                st[j] = true;
        }
        
    }
    
    cout << cnt << endl;
    return 0;
    
}
```
<!-- endtab -->
{% endtabs %}

### 线性筛
待更新。


{% note primary %}
__原题链接：__ [AcWing 868. 筛质数](https://www.acwing.com/problem/content/870/)
{% endnote %}

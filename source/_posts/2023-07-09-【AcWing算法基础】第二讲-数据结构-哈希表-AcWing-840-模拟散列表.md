---
title: 【AcWing算法基础】第二讲-数据结构-哈希表 AcWing 840. 模拟散列表
comments: true
date: 2023-07-09 00:27:30
tags:
    - 算法
    - AcWing 
    - 哈希表
categories:
    - [指尖飞舞, 算法, AcWing, 算法基础课, 第二讲数据结构]
---
__摘要：__
数组模拟哈希集合（哈希表），使用拉链法和开放寻址法处理冲突。
<!-- more -->

### 题目
维护一个集合，支持如下几种操作：

+ $I \quad x$，插入一个数 $x$；
+ $Q \quad x$，询问数 $x$ 是否在集合中出现过；

现在要进行 $N$ 次操作，对于每个询问操作输出对应的结果。

__输入格式__
第一行包含整数 $N$，表示操作数量。
接下来 $N$ 行，每行包含一个操作指令，操作指令为 $I \quad $，$Q \quad x$ 中的一种。

__输出格式__
对于每个询问指令 $Q \quad x$，输出一个询问结果，如果 $x$ 在集合中出现过，则输出 $Yes$，否则输出 $No$。

每个结果占一行。

__数据范围__
+ $1≤N≤10^5$
+ $−10^9≤x≤10^9$

__输入样例：__
> 5
> I 1
> I 2
> I 3
> Q 2
> Q 5

__输出样例：__
> Yes
> No

### 代码

{% tabs g_tab0 %}
<!-- tab C++/拉链法 -->
```c++
/**
 * author: zxy
 * code at: 2023-7-9 00:38:17
 */
#include <bits/stdc++.h>
#define __nullptr__ -1

using namespace std;

int n;
constexpr int N = 100003;
int h[N], e[N], ne[N], idx;

int create_hash(int x)
{
    return (x % N + N) % N;
}

void insert(int x)
{
    int hash_val = create_hash(x);
    // inserts to linked list head
    int head = h[hash_val];
    e[idx] = x;
    ne[idx] = head;
    // updates head
    h[hash_val] = idx;
    ++idx;
}

bool exist(int x)
{
    int hash_val = create_hash(x);
    for (int ptr = h[hash_val]; ptr != __nullptr__; ptr = ne[ptr])
    {
        // exist entry in linked list
        if (e[ptr] == x) return true;
    }
    // no entry in linked list or no value equals to x although x has the same hash val with each entry in linked list
    return false;
}

int main()
{
    string ops;
    int x;
    cin >> n;
    // inits nullptr, using -1 as nullptr
    memset(h, __nullptr__, sizeof(h));
    memset(ne, __nullptr__, sizeof(ne));
    
    for (; n--;) 
    {
        cin >> ops >> x;
        if (ops == "I") 
        {
            insert(x);
        }
        else if (ops == "Q")
        {
            int res = exist(x);
            if (res) cout << "Yes" << endl;
            else cout << "No" << endl;
        }
        else 
        {
            cout << "UNSUPPORTED OPERATION" << endl;
        }
    }
}
```
<!-- endtab -->

<!-- tab C++/开放寻址法 -->
```c++
/**
 * author: zxy
 * code at: 2023-7-9 00:22:20
 **/
#include <bits/stdc++.h>
#define __unreachable__ 0x3f3f3f3f

using namespace std;


int n;
constexpr int N = 200003;
int h[N];

int create_hash(int x)
{
    return (x % N + N) % N;
}

// returns the hash index of given value if value not in set
// or occupied location if in set
int find(int x)
{
    int hash_val = create_hash(x);
    for (; h[hash_val] != __unreachable__ && h[hash_val] != x ; ++hash_val)
    {
        if (hash_val == N) hash_val = 0;
    }
    return hash_val;
}

int main()
{
    string ops;
    int x;
    cin >> n;
    
    // inits h with each val equals to unreachable value
    memset(h, 0x3f, sizeof(h));
    
    for (; n--;)
    {
        cin >> ops >> x;
        int hash_val = find(x);
        if (ops == "I")
        {
            h[hash_val] = x;
        }
        else if (ops == "Q")
        {
            if (h[hash_val] == __unreachable__) cout << "No" << endl;
            else cout << "Yes" << endl;
        }
        else 
        {
            cout << "UNSUPPORTED OPERATION" << endl;
        }
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
使用数组模拟集合，因为数字大小区间在 $−10^9≤x≤10^9$ 内，范围较大，需要对数字进行哈希处理，缩小到一个较小范围内。

哈希函数我们使用取模方式，对于负数，我们需要做如下处理：
```c++
int hash_val = (x % MOD + MOD) % MOD;
```
不同的数哈希之后得到的值可能存在相同的情况，我们需要处理哈希冲突。有如下两种常见方式。

#### 拉链法
使用一个单链表维护所有哈希值相同的数。模拟集合的数组长度选择比操作次数最大值大的最小质数，同时可以作为拉链法的哈希函数 $MOD$ 值。

集合数组值初始化为 $-1$，可以看成是空指针，集合数组存的值为单链表的头节点，对应单链表值数组 $e$ 的数组下标，单链表插入使用头插法。

单链表数据结构可以参考：[AcWing 826. 单链表](https://ntifs.com/2020/11/12/【AcWing算法基础】第二讲-数据结构-单链表-AcWing-826-单链表/)

判断存在性时，判断哈希值对应的数组存放链表头节点是否为空，或者非空情况遍历单链表逐个比较数值是否相等。

#### 开放寻址法
如果哈希值对应数组被占用，则往后遍历找到新的地址，不断轮询尝试直到找到位置。

模拟集合的数组长度根据经验选择比操作次数最大值大2倍大的最小质数，同时可以作为开放寻址法的哈希函数 $MOD$ 值。

模拟集合数组存放数值，初始化为数值范围以外的 `0x3f3f3f3f`。

实现一个 $find$ 函数，判断 $hash$ 值对应的数是否存在，如果不存在说明该位置可以作为数的存放位置；如果存在则要判断是否被别的数值占用，如果被别的数值占用则向后遍历集合数组，直到找到一个满足条件的位置。

需要注意的是，我们初始化数值大小为操作数量最大值的 $2$ 倍还多，最坏的情况是每一个操作都不相同，这样我们依然有一倍的冗余，所以必然存在一个位置可以放数值。

{% note primary %}
__原题链接：__ [AcWing 840. 模拟散列表](https://www.acwing.com/problem/content/description/842/)
{% endnote %}
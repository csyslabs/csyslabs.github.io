---
title: 【LeetCode周赛216】B LeetCode 5606. 具有给定数值的最小字符串
comments: true
date: 2020-11-22 22:28:56
tags:
    - 算法
    - LeetCode
    - 竞赛
    - 贪心
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛, 216]
---
__摘要：__
一道贪心题。
<!-- more -->

### 题目
__小写字符__ 的 __数值__ 是它在字母表中的位置（从 $1$ 开始），因此 $a$ 的数值为 $1$ ，$b$ 的数值为 $2$ ，$c$ 的数值为 $3$ ，以此类推。
字符串由若干小写字符组成，字符串的数值 为各字符的数值之和。例如，字符串 $abe$ 的数值等于 $1 + 2 + 5 = 8$ 。
给你两个整数 $n$ 和 $k$ 。返回 __长度__ 等于 $n$ 且 __数值__ 等于 $k$ 的 __字典序最小__ 的字符串。
注意，如果字符串 $x$ 在字典排序中位于 $y$ 之前，就认为 $x$ 字典序比 $y$ 小，有以下两种情况：
+ $x$ 是 $y$ 的一个前缀；
+ 如果 $i$ 是 $x[i] \not= y[i]$ 的第一个位置，且 $x[i]$ 在字母表中的位置比 $y[i]$ 靠前。
 
__示例 1：__
> 输入：n = 3, k = 27
> 输出："aay"
> 解释：字符串的数值为 1 + 1 + 25 = 27，它是数值满足要求且长度等于 3 字典序最小的字符串。

__示例 2：__
> 输入：n = 5, k = 73
> 输出："aaszz"

__提示：__
+ $1 <= n <= 10^5$
+ $n <= k <= 26 \times n$
___

### 贪心

一共 $n$ 位，我们从第 $1$ 位起，依次按字母表顺序尝试字母是否符合要求。
由题可知，$n$ 位数值和的范围是：$n <= k <= 26 \times n$，即 $n$ 位的数值和最小取到 $n$ ，这是 $n$ 个 $a$ 的情况；最大取到 $26 \times n$，这是 $n$ 个 $z$ 的情况。
一个字母符合要求当且仅当使用了它之后，剩余的数值要在后面所有位的数值和规定的范围内。
利用贪心的思想，只要当前位使用了尽可能小的字母而后面的目标值可以由剩余个 $a$ 和剩余个 $z$ 中间的任意一个组合构成，那使用该字母就是最优的。
现在考虑前 $n - 1$ 个字母已经填充的情况，现在来决定最后一个字母。那么，因为之前的判断最后一位的目标值一定在 $1$ 到 $26$ 间。要想让最后一位成立，那么后面的目标值一定是 $0$ ($0 <= remain target <= 26 \times 0$)。
那么最后一位从 $1$ 开始枚举刚好到最低位可行的字母处即停止。

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
class Solution {
public:
    string getSmallestString(int n, int k) {
        string res = "";
        int t = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= 26; j++) {
                if (k - t - j >= n - i && k - t - j <= 26 * (n - i)) {
                    res += 97 + j - 1;
                    t += j;
                    break;
                }
            }
            //cout << res << '-' << t << endl;
        }
        //cout << res << endl << t << endl;
        return res;
    }
};
```
<!-- endtab -->
{% endtabs %}

### 贪心

还有一种从后往前的贪心方法。初始化字符串为n个a字符，从最后一位开始向上枚举，直到找到目标值。
{% tabs g_tab1 %}
<!-- tab C++ -->
```C++
class Solution {
public:
    
    string getSmallestString(int n, int k) {
        string res = "";
        for (int i = 0; i < n; i++) res += 97;
        int sum = n;
        if (sum == k) return res;
        for (int i = n - 1; i >= 0; i--) {
            for (int j = 0; j < 25; j++) {
                ++res[i];
                if (++sum == k) return res;
            }
        }
        return "";
    }
};
```
<!-- endtab -->
{% endtabs %}

{% note primary %}
__原题链接：__ [LeetCode 5606. 具有给定数值的最小字符串](https://leetcode-cn.com/problems/smallest-string-with-a-given-numeric-value/)
{% endnote %}
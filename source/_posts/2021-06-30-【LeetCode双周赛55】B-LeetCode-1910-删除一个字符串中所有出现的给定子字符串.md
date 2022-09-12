---
title: 【LeetCode双周赛55】B LeetCode 1910. 删除一个字符串中所有出现的给定子字符串
comments: true
date: 2021-06-30 23:23:56
tags:
    - 算法
    - LeetCode
    - 竞赛
    - 字符串
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode双周赛, 55]
---
__摘要：__
简单字符串替换。
<!-- more -->

### 题目

给你两个字符串 $s$ 和 $part$ ，请你对 $s$ 反复执行以下操作直到 __所有__ 子字符串 $part$ 都被删除：

+ 找到 $s$ 中 __最左边__ 的子字符串 $part$ ，并将它从 $s$ 中删除。

请你返回从 $s$ 中删除所有 $part$ 子字符串以后得到的剩余字符串。

一个 __子字符串__ 是一个字符串中连续的字符序列。

__示例 1：__

> 输入：s = "daabcbaabcbc", part = "abc"
输出："dab"
解释：以下操作按顺序执行：
- s = "daabcbaabcbc" ，删除下标从 2 开始的 "abc" ，得到 s = "dabaabcbc" 。
- s = "dabaabcbc" ，删除下标从 4 开始的 "abc" ，得到 s = "dababc" 。
- s = "dababc" ，删除下标从 3 开始的 "abc" ，得到 s = "dab" 。
此时 s 中不再含有子字符串 "abc" 。

__示例 2：__

输入：s = "axxxxyyyyb", part = "xy"
输出："ab"
解释：以下操作按顺序执行：
- s = "axxxxyyyyb" ，删除下标从 4 开始的 "xy" ，得到 s = "axxxyyyb" 。
- s = "axxxyyyb" ，删除下标从 3 开始的 "xy" ，得到 s = "axxyyb" 。
- s = "axxyyb" ，删除下标从 2 开始的 "xy" ，得到 s = "axyb" 。
- s = "axyb" ，删除下标从 1 开始的 "xy" ，得到 s = "ab" 。
此时 s 中不再含有子字符串 "xy" 。
 
__提示：__

+ $1 <= s.length <= 1000$
+ $1 <= part.length <= 1000$
+ $s$​​​​​​ 和 $part$ 只包小写英文字母。

___


### 字符串查找替换

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
class Solution {
public:
    string removeOccurrences(string s, string p) {
        int len1 = s.size(), len2 = p.size();
        for (;;) {
            int idx = s.find(p);
            if (idx == -1) break;
            string s1 = s.substr(0, idx), s2 = s.substr(idx + len2);
            s = s1 + s2;
        }
        return s;
    }
};
```
<!-- endtab -->
{% endtabs %}


{% note primary %}
__原题链接：__ [LeetCode 1910. 删除一个字符串中所有出现的给定子字符串](https://leetcode-cn.com/problems/remove-all-occurrences-of-a-substring/)
{% endnote %}
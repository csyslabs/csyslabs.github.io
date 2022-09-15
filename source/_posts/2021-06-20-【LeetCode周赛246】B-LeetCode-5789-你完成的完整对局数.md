---
title: 【LeetCode周赛246】B LeetCode 5789. 你完成的完整对局数
comments: true
date: 2021-06-20 14:26:47
tags:
    - 算法
    - LeetCode
    - 竞赛
    - 字符串
    - 数学
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛]
---
__摘要：__
一道关于时间的题目。
<!-- more -->


### 题目
一款新的在线电子游戏在近期发布，在该电子游戏中，以 __刻钟__ 为周期规划若干时长为 __15 分钟__ 的游戏对局。这意味着，在 `HH:00`、`HH:15`、`HH:30` 和 `HH:45` ，将会开始一个新的对局，其中 `HH` 用一个从 `00` 到 `23` 的整数表示。游戏中使用 `24` 小时制的时钟 ，所以一天中最早的时间是 `00:00` ，最晚的时间是 `23:59` 。

给你两个字符串 `startTime` 和 `finishTime` ，均符合 `"HH:MM"` 格式，分别表示你 __进入__ 和 __退出__ 游戏的确切时间，请计算在整个游戏会话期间，你完成的 __完整对局的对局数__ 。

+ 例如，如果 `startTime = "05:20"` 且 `finishTime = "05:59"` ，这意味着你仅仅完成从 `05:30` 到 `05:45` 这一个完整对局。而你没有完成从 `05:15` 到 `05:30` 的完整对局，因为你是在对局开始后进入的游戏；同时，你也没有完成从 `05:45` 到 `06:00` 的完整对局，因为你是在对局结束前退出的游戏。

如果 `finishTime` __早于__ `startTime` ，这表示你玩了个通宵（也就是从 `startTime` 到午夜，再从午夜到 `finishTime` ）。

假设你是从 `startTime` 进入游戏，并在 `finishTime` 退出游戏，请计算并返回你完成的 __完整对局的对局数__ 。


__示例 1：__

> 输入：startTime = "12:01", finishTime = "12:44"
输出：1
解释：你完成了从 12:15 到 12:30 的一个完整对局。
你没有完成从 12:00 到 12:15 的完整对局，因为你是在对局开始后的 12:01 进入的游戏。
你没有完成从 12:30 到 12:45 的完整对局，因为你是在对局结束前的 12:44 退出的游戏。

__示例 2：__

输入：startTime = "20:00", finishTime = "06:00"
输出：40
解释：你完成了从 20:00 到 00:00 的 16 个完整的对局，以及从 00:00 到 06:00 的 24 个完整的对局。
16 + 24 = 40

__示例 3：__

> 输入：startTime = "00:00", finishTime = "23:59"
输出：95
解释：除最后一个小时你只完成了 3 个完整对局外，其余每个小时均完成了 4 场完整对局。
 

__提示：__

+ `startTime` 和 `finishTime` 的格式为 `HH:MM`
+ $00 <= HH <= 23$
+ $00 <= MM <= 59$
+ `startTime` 和 `finishTime` 不相等
___

### 数学

将时间转换为分钟数表示，如果结束时间小于开始时间，则将结束时间加上24小时。
问题就变成了求开始分钟数后的第一个15的倍数，以及结束时间分钟数前一个15的倍数。再求二者之间的长度共是15的倍数。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
class Solution {
public:
    inline int ctoi(char c) {
        return c - '0';
    }
        
    int numberOfRounds(string s, string f) {
        int a = (ctoi(s[0]) * 10 + ctoi(s[1])) * 60 + ctoi(s[3]) * 10 + ctoi(s[4]);
        int b = (ctoi(f[0]) * 10 + ctoi(f[1])) * 60 + ctoi(f[3]) * 10 + ctoi(f[4]);

        if (a > b) b += 24 * 60;
        // 找到a右边第一个15的倍数和b左边第一个15的倍数
        int l = (int)((a + 14) / 15) * 15;
        int r = (int)(b / 15) * 15;
        if (r > l)                  // 当r 和 l之间至少有一个完整对局时或者二者不构成一个完整对局且分别某个对局时间点左右
            return (r - l) / 15;
        else                       // 当r和l同在一个完整对局区间内，会出现r < l的情况
           return 0;
    }
};
```
<!-- endtab -->
{% endtabs %}

注意到c++是向零取整，`int c = b / a`;
如果想计算 `b / a` 向上取整，可以 `int c = (b + a - 1) / a`.
因为 `c = (b + a) / a` 刚好等于 `b / a向下取整 + 1`.

### 优化：用sscanf将字符串分割为两个数字

{% tabs g_tab1 %}
<!-- tab C++ -->
```c++
/*
 * Author: yxc@acwing.com
 */
class Solution {
public:
    int get(string s) {
        int h, m;
        sscanf(s.c_str(), "%d:%d", &h, &m);
        return h * 60 + m;
    }

    int numberOfRounds(string s, string f) {
        int x = get(s), y = get(f);
        if (x > y) y += 24 * 60;
        x = (x + 14) / 15, y /= 15;
        if (y > x)
            return y - x;
        else 
            return 0;

    }
};
```
<!-- endtab -->
{% endtabs %}

{% note primary %}
__原题链接：__ [LeetCode 5789. 你完成的完整对局数](https://leetcode-cn.com/contest/weekly-contest-246/problems/the-number-of-full-rounds-you-have-played/)
{% endnote %}
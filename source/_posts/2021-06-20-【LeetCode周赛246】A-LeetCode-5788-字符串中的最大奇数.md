---
title: 【LeetCode周赛246】A LeetCode 5788. 字符串中的最大奇数
comments: true
date: 2021-06-20 14:03:11
tags:
    - 算法
    - LeetCode
    - 竞赛
    - 字符串
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛]
---
__摘要：__
寻找字符串中的最大奇数。
<!-- more -->


给你一个字符串 `num` ，表示一个大整数。请你在字符串 `num` 的所有 __非空子字符串__ 中找出 __值最大的奇数__ ，并以字符串形式返回。如果不存在奇数，则返回一个空字符串 `""` 。

__子字符串__ 是字符串中的一个连续的字符序列。



__示例 1：__

> 输入：num = "52"
输出："5"
解释：非空子字符串仅有 "5"、"2" 和 "52" 。"5" 是其中唯一的奇数。

__示例 2：__

> 输入：num = "4206"
输出：""
解释：在 "4206" 中不存在奇数。

__示例 3：__

> 输入：num = "35427"
输出："35427"
解释："35427" 本身就是一个奇数。


__提示：__

+ $1 <= num.length <= 10^5$
+ $num$ 仅由数字组成且不含前导零

___

### 模拟
奇数最后一个数字一定是奇数，那么就从右向左找到第一个奇数数字，那么以该字符结尾的原字符串前缀就是最大奇数子串。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
class Solution {
public:
    string largestOddNumber(string num) {
        if ((num.end()[-1]) & 1) return num;
        int len = num.size();
        
        for (int i = len - 1; i >= 0; i--) {
            if ((num[i]) & 1) {
                return num.substr(0, i + 1);
            }
        }
        return "";
    }
};
```
<!-- endtab -->
{% endtabs %}

注意在判断数字字符的奇偶性时，可以直接判断。因为数字字符和对应的数字具有相同奇偶性。

{% note primary %}
__原题链接：__ [LeetCode 5788. 字符串中的最大奇数](https://leetcode-cn.com/problems/largest-odd-number-in-string/)
{% endnote %}
---
title: 【LeetCode周赛216】C LeetCode 5607. 生成平衡数组的方案数
comments: true
date: 2020-11-22 22:04:48
tags:
    - 算法
    - LeetCode
    - 竞赛
    - 前缀和
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛, 216]
---
__摘要：__
力扣第216场周赛第三题，考查前缀和及动态规划。
<!-- more -->

### 题目
给你一个整数数组 $nums$ 。你需要选择 __恰好__ 一个下标（下标从 $0$ 开始）并删除对应的元素。请注意剩下元素的下标可能会因为删除操作而发生改变。

比方说，如果 $nums = [6,1,7,4,1]$ ，那么：

+ 选择删除下标 $1$ ，剩下的数组为 $nums = [6,7,4,1]$ 。
+ 选择删除下标 $2$ ，剩下的数组为 $nums = [6,1,4,1]$ 。
+ 选择删除下标 $4$ ，剩下的数组为 $nums = [6,1,7,4]$ 。

如果一个数组满足奇数下标元素的和与偶数下标元素的和相等，该数组就是一个 __平衡数组__ 。
请你返回删除操作后，剩下的数组 $nums$ 是 __平衡数组__ 的 __方案数__ 。
 
__示例 1：__

> 输入：nums = [2,1,6,4]
> 输出：1
> 解释：
> 删除下标 0 ：[1,6,4] -> 偶数元素下标为：1 + 4 = 5 。奇数元素下标为：6 。不平衡。
> 删除下标 1 ：[2,6,4] -> 偶数元素下标为：2 + 4 = 6 。奇数元素下标为：6 。平衡。
> 删除下标 2 ：[2,1,4] -> 偶数元素下标为：2 + 4 = 6 。奇数元素下标为：1 。不平衡。
> 删除下标 3 ：[2,1,6] -> 偶数元素下标为：2 + 6 = 8 。奇数元素下标为：1 。不平衡。
> 只有一种让剩余数组成为平衡数组的方案。

__示例 2：__

> 输入：nums = [1,1,1]
> 输出：3
> 解释：你可以删除任意元素，剩余数组都是平衡数组。

__示例 3：__

> 输入：nums = [1,2,3]
> 输出：0
> 解释：不管删除哪个元素，剩下数组都不是平衡数组。

__提示：__

+ $1 <= nums.length <= 10^5$
+ $1 <= nums[i] <= 10^4$

___

### 前缀和
依次抽出数组每一个数，然后判断抽出之后，数组是不是平衡数组。
关键在于怎么判断数组是不是平衡的。暴力的做法是每次抽取之后，计算一下抽取之后的奇数和及偶数和。然而题目给出数据范围是$1 <= nums.length <= 10^5$，复杂度要控制在 **_O(N)_** 或者 **_O(NLogN)_**，所以暴力行不通。
这里涉及到求和，自然而然想到构造前缀和数组，构造前缀和数组需要 **_O(N)_** 的复杂度，而查询只需 **_O(1)_**。这道题需要分别计算奇数和及偶数和，所以要分别构造奇偶前缀和。
仔细观察题目，抽取数字后，该数字前面的所有数字奇偶下标不变，后面的所有数字下标奇偶互换。那么抽取之后数组的奇数和就是该数前面所有奇数和加上后面所有偶数和；对应的，偶数和就是该数前面所有偶数加上后面所有奇数和。

{% tabs g_tab0 %}
<!-- tab C++ -->
```C++
/*
 * 2021-7-1 14:31:20
 * author: etoa
 */ 
static const auto shutdown = [](){
    cin.tie(nullptr)->sync_with_stdio(false);
    return nullptr;
}();

class Solution {
public:
    int waysToMakeFair(vector<int>& nums) {
        int len = nums.size();
        vector<int> presum(len + 1, 0);
        for (int i = 0; i < len; i++) {
            presum[i + 1] = presum[i] + nums[i];
        }
        vector<int> presum1(len + 1, 0);
        vector<int> presum2(len + 1, 0);
        for (int i = 0; i < len; i++) {
            if (i & 1) {
                presum1[i + 1] = presum1[i] + nums[i];
                presum2[i + 1] = presum2[i];
            }
            else {
                presum1[i + 1] = presum1[i];
                presum2[i + 1] = presum2[i] + nums[i];
            }
        }
        /*
        for (auto& each : presum1) cout << each << '-';
        cout << endl;
        for (auto& each : presum2) cout << each << '-';
        */
        int res = 0;
        for (int del = 0; del < len; del++) {
            int lsum1 = presum1[del] - presum1[0];
            int lsum2 = presum2[del] - presum2[0];
            //cout << "lsum1: " << lsum1 << " lsum2: " << lsum2 << endl;
            int rsum1 = presum2[len] - presum2[del + 1];
            int rsum2 = presum1[len] - presum1[del + 1];
            //cout << "rsum1: " << rsum1 << " rsum2: " << rsum2 << endl;
            if (lsum1 + rsum1 == lsum2 + rsum2) res++;
        }
        return res;
    }
};
```
<!-- endtab -->
{% endtabs %}

{% note primary %}
__原题链接：__ [LeetCode 5607. 生成平衡数组的方案数](https://leetcode-cn.com/problems/ways-to-make-a-fair-array/)
{% endnote %}
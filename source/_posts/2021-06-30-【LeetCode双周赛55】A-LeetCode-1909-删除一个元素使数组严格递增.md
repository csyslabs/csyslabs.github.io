---
title: 【LeetCode双周赛55】A LeetCode 1909. 删除一个元素使数组严格递增
comments: true
date: 2021-06-30 22:43:09
tags:
    - 算法  
    - LeetCode
    - 竞赛
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛]
---
__摘要：__
签到题，但是又不那么水，题目质量挺好。
<!-- more -->

### 题目

给你一个下标从 $0$ 开始的整数数组 $nums$ ，如果 __恰好__ 删除 __一个__ 元素后，数组 __严格递增__ ，那么请你返回 $true$ ，否则返回 $false$ 。如果数组本身已经是严格递增的，请你也返回 $true$ 。

数组 $nums$ 是 __严格递增__ 的定义为：对于任意下标的 $1 <= i < nums.length$ 都满足 $nums[i - 1] < nums[i]$ 。

__示例 1：__

> 输入：nums = [1,2,10,5,7]
输出：true
解释：从 nums 中删除下标 2 处的 10 ，得到 [1,2,5,7] 。
[1,2,5,7] 是严格递增的，所以返回 true 。

__示例 2：__

> 输入：nums = [2,3,1,2]
输出：false
解释：
[3,1,2] 是删除下标 0 处元素后得到的结果。
[2,1,2] 是删除下标 1 处元素后得到的结果。
[2,3,2] 是删除下标 2 处元素后得到的结果。
[2,3,1] 是删除下标 3 处元素后得到的结果。
没有任何结果数组是严格递增的，所以返回 false 。

__示例 3：__

> 输入：nums = [1,1,1]
输出：false
解释：删除任意元素后的结果都是 [1,1] 。
[1,1] 不是严格递增的，所以返回 false 。

__示例 4：__

输入：nums = [1,2,3]
输出：true
解释：[1,2,3] 已经是严格递增的，所以返回 true 。
 
__提示：__

+ $2 <= nums.length <= 1000$
+ $1 <= nums[i] <= 1000$

___

### 枚举

枚举每一位数，剔除后判断剩余数组是否严格单调递增。复杂度 $O(N^2)$, 数组长度最高 $1000$，复杂度是$1000000$ ，可以过掉。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
class Solution {
public:
    bool canBeIncreasing(vector<int>& nums) {
        int len = nums.size();
        for (int i = -1; i < len; i++) {
            int last = 0;
            bool isgood = true;
            for (int j = 0; j < len; j++) {
                if (j == i) continue;
                if (nums[j] <= last) {
                    isgood = false;
                    break;
                }
                last = nums[j];
            }
            if (isgood) return true;
        }
        return false;
    }
};
```
<!-- endtab -->
{% endtabs %}

从 `-1` 开始枚举需要删除的数，`-1` 表示不删除任何数，判断原数组是否为严格单调递增，太妙了。
注意 `nums.size()` 返回的是一个 `unsigned int` 类型，需要强转成 `int` 类型，配合 `-1`，不然有bug。

{% note primary %}
__原题链接：__ [LeetCode 1909. 删除一个元素使数组严格递增](https://leetcode-cn.com/problems/remove-one-element-to-make-the-array-strictly-increasing/)
{% endnote %}
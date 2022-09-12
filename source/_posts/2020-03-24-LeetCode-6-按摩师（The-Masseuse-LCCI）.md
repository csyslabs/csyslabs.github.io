---
title: 'LeetCode #6 按摩师（The Masseuse LCCI）'
comments: true
date: 2020-03-24 23:10:15
tags:
    - 动态规划
    - LeetCode
    - 算法
categories:
    - [指尖飞舞, 算法]
---
### 题目：
> 一个有名的按摩师会收到源源不断的预约请求，每个预约都可以选择接或> 不接。在每次预约服务之间要有休息时间，因此她不能接受相邻的预约。> 给定一个预约请求序列，替按摩师找到最优的预约集合（总预约时间最长），返回总的分钟数。
>
> __注意__：本题相对原题稍作改动

### 示例1：
> 输入： [1,2,3,1]
> 输出： 4
> 解释： 选择 1 号预约和 3 号预约，总时长 = 1 + 3 = 4。
### 示例2：
> 输入： [2,7,9,3,1]
> 输出： 12
> 解释： 选择 1 号预约、 3 号预约和 5 号预约，总时长 = 2 + 9 + 1 > = 12。
### 示例3：
> 输入： [2,1,4,5,3,1,1,3]
> 输出： 12
> 解释： 选择 1 号预约、 3 号预约、 5 号预约和 8 号预约，总时长 = > 2 + 4 + 3 + 3 = 12。
___
### 一维状态数组
```Java
class Solution {
    public int massage(int[] nums) {
        if (nums == null || nums.length == 0)
            return 0;
        else if (nums.length == 1)
            return nums[0];

        int[] dp = new int[nums.length];
        dp[0] = nums[0];
        dp[1] = Math.max(nums[0], nums[1]);
        for (int i = 2; i < nums.length; i++) {
            dp[i] = Math.max(dp[i-1], dp[i-2]+nums[i]);
        }
        return dp[dp.length-1];//or i-1 because i++ in last step
    }
}
```
+ 时间复杂度：O(N)O(N)，NN 是数组的长度；
+ 空间复杂度：O(N)O(N)，状态数组的大小为 N

### 一维状态数组+「滚动数组」
使用 3 个变量滚动完成计算，将空间优化到常数级别。
```Java
class SolutionSO1 {
    public int massage(int[] nums) {
        if (nums == null || nums.length == 0)
            return 0;
        else if (nums.length == 1)
            return nums[0];

        int pre2 = 0, pre = 0, cur = nums[0];
        for (int num : nums) {
            cur = Math.max(pre, pre2 + num);
            pre2 = pre;
            pre = cur;
        }
        return cur;
    }
}
```
+ 时间复杂度：O(N)，N是数组的长度；
+ 空间复杂度：O(1)，状态数组的大小为 3，常数空间。

##### 题目链接https://leetcode-cn.com/problems/the-masseuse-lcci/
##### 参考题解
> https://leetcode-cn.com/problems/the-masseuse-lcci/solution/dong-tai-gui-hua-by-liweiwei1419-8/
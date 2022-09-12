---
title: 'LeetCode #1431 拥有最多糖果的孩子（Kids With the Greatest Number of Candies）'
comments: true
date: 2020-06-01 17:11:35
tags:
    - 数组
categories:
    - [指尖飞舞, 算法]
---
### 题目
给你一个数组`candies`和一个整数`extraCandies`，其中`candies[i]` 代表第 `i`个孩子拥有的糖果数目。

对每一个孩子，检查是否存在一种方案，将额外的 `extraCandies` 个糖果分配给孩子们之后，此孩子有 __最多__ 的糖果。注意，允许有多个孩子同时拥有 __最多__ 的糖果数目。

__示例1：__
> __输入：__ candies = [2,3,5,1,3], extraCandies = 3
> __输出：__ [true,true,true,false,true] 
> __解释：__ 
> 孩子 1 有 2 个糖果，如果他得到所有额外的糖果（3个），那么他总共有 5 个糖果，他将成为拥有最多糖果的孩子。
> 孩子 2 有 3 个糖果，如果他得到至少 2 个额外糖果，那么他将成为拥有最多糖果的孩子。
> 孩子 3 有 5 个糖果，他已经是拥有最多糖果的孩子。
> 孩子 4 有 1 个糖果，即使他得到所有额外的糖果，他也只有 4 个糖果，无法成为拥有糖果最多的孩子。
> 孩子 5 有 3 个糖果，如果他得到至少 2 个额外糖果，那么他将成为拥有最多糖果的孩子。

__示例2：__
> __输入：__ candies = [4,2,1,1,2], extraCandies = 1
> __输出：__ [true,false,false,false,false] 
> __解释：__ 只有 1 个额外糖果，所以不管额外糖果给谁，只有孩子 1 可以成为拥有糖果最多的孩子。

__示例3：__
> __输入：__ candies = [12,1,12], extraCandies = 10
> __输出：__ [true,false,true]

__提示：__
+ 2 <= candies.length <= 100
+ 1 <= candies[i] <= 100
+ 1 <= extraCandies <= 50
___
### 枚举
没啥好说的，儿童节快乐！
```Java
class Solution {
    public List<Boolean> kidsWithCandies(int[] candies, int extraCandies) {
        int len = candies.length;
        int max = candies[0];
        for (int i = 0; i < len; i++) {
            max = Math.max(max, candies[i]);
        }
        List<Boolean> res = new ArrayList<>();
        for (int i = 0; i < len; i++) {
            res.add(candies[i] + extraCandies >= max);
        }
        return res;
    }
}
```

##### 题目链接
> https://leetcode-cn.com/problems/kids-with-the-greatest-number-of-candies/
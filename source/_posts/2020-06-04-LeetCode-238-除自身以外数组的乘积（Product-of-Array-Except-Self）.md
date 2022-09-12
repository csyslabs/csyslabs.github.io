---
title: 'LeetCode #238 除自身以外数组的乘积（Product of Array Except Self）'
comments: true
date: 2020-06-04 14:16:46
tags:
    - 数组
categories:
    - [指尖飞舞, 算法]
---
### 题目
给你一个长度为 n 的整数数组 `nums`，其中 n > 1，返回输出数组 `output` ，其中 `output[i]` 等于 `nums` 中除 `nums[i]` 之外其余各元素的乘积。

__示例：__
> 输入: [1,2,3,4]
> 输出: [24,12,8,6]

__提示：__ 题目数据保证数组之中任意元素的全部前缀元素和后缀（甚至是整个数组）的乘积都在 32 位整数范围内。

__说明:__ 请不要使用除法，且在 O(n) 时间复杂度内完成此题。

__进阶：__ 你可以在常数空间复杂度内完成这个题目吗？（ 出于对空间复杂度分析的目的，输出数组不被视为额外空间。）
___
### 左右乘积数组
维护两个数组，分别存放`nums[i]`左右乘积。
```Java
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int len = nums.length;
        int[] left = new int[len];
        for (int i = 0; i < len; i++) {
            if (i == 0) {
                left[i] = 1;
                continue;
            }
            left[i] = left[i - 1] * nums[i - 1];
        }
        int[] right = new int[len];
        for (int j = len - 1; j > -1; j--) {
            if (j == len - 1) {
                right[j] = 1;
                continue;
            }
            right[j] = right[j + 1] * nums[j + 1];
        }
        int[] output = new int[len];
        for (int k = 0; k < len; k++) {
            output[k] = left[k] * right[k];
        }        
        return output;
    }
}
```
__复杂度：__
+ 时间复杂度：***O(N)*** 其中 ***O(N)*** 指的是数组 `nums` 的大小。预处理 `left` 和 `right` 数组以及最后的遍历计算都是 ***O(N)*** 的时间复杂度。
+ 空间复杂度：***O(N)*** 其中 ***O(N)*** 指的是数组 `nums` 的大小。使用了 `left` 和 `right` 数组去构造答案，`left` 和 `right` 数组的长度为数组 `nums` 的大小。

### 进一步优化 ***O(1)*** 的空间复杂度
可以使用答案数组来替代 `left` 数组，从右向左遍历，动态更新 `nums[i]` 右侧乘积。
也可以使用答案数组来替代 `right` 数组，从左向右遍历，动态更新 `nums[i]` 左侧乘积。
```Java
class Solution {
    public int[] productExceptSelf(int[] nums) {
        int len = nums.length;
        int[] output = new int[len];
        output[len -1 ] = 1;
        for (int i = len - 2; i >= 0; i--) {
            output[i] = output[i + 1] * nums[i + 1];
        }
        int left = 1;
        for (int j = 0; j < len; j++) {
            if (j == 0) left = 1;
            else left = left * nums[j - 1];
            output[j] = left * output[j];
        }
        return output;
    }
}
```
__复杂度：__
+ 时间复杂度：***O(N)***，其中 ***O(N)*** 指的是数组 `nums` 的大小。分析与方法一相同。
+ 空间复杂度：***O(1)***，输出数组不算进空间复杂度中，因此我们只需要常数的空间存放变量。

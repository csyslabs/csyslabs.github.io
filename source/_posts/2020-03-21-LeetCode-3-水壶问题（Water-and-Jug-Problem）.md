---
title: 'LeetCode #3 水壶问题（Water and Jug Problem）'
comments: true
date: 2020-03-21 13:21:47
tags:
    - 算法
    - leetcode
    - 贝祖定理
    - 数学
categories:
    - [指尖飞舞, 算法]
---
### 题目：
> 有两个容量分别为 x升 和 y升 的水壶以及无限多的水。请判断能否通过使用这两个水壶，从而可以得到恰好 z升 的水？
>
> 如果可以，最后请用以上水壶中的一或两个来盛放取得的 z升 水。
>
> 你允许：
> + 装满任意一个水壶
> + 清空任意一个水壶
> + 从一个水壶向另外一个水壶倒水，直到装满或者倒空

### 示例 1: (From the famous "Die Hard" example)
> 输入: x = 3, y = 5, z = 4
> 输出: True
### 示例 2:
> 输入: x = 2, y = 6, z = 5
> 输出: False
___
### 贝祖定理方法
关键在于划分成功条件。
题干默认z >= 0，首先当z = 0 时，x和y取任意值，一定成功。
当z > 0时：
+ 当x + y < z时，即使两盏杯子装满水，依然不可能成功。
+ 当x + y = z时，x, y, z取任意值，一定成功。
+ 当x + y > z时，不一定。问题的核心在此，用贝祖定理判定成功条件。
由贝祖定理可知，对任何整数x、y和它们的最大公约数gcd(x, y)，对于它们的的任意整数倍数a,b,c，都有
ax + by = c·gcd(x, y)恒成立。
由题干给出的几种操作，要完成目标，一定有ax + by = z。
和贝祖定理完美锲合，那么，只要z % (gcd(x, y)) = 0为真，则一定成功。
```Java
class Solution {
    //贝祖定理
    public static boolean canMeasureWater(int x, int y, int z) {
        //默认z >= 0
        if (z == 0)
            return true;
        //z>0
        if (x +y <z)
            return false;
        else if (x + y == z)
            return true;
        else
            //only x!=0,y!=0; x!=0,y==0; x==0,y!=0
            return z % gcd(x, y) == 0;
    }
    public static int gcd(int x, int y) {
        while (y != 0) { //辗转相除法
            int temp = y;
            y = x % y;
            x = temp;
        }
        return x;
    }
}
```
### 广度优先遍历

##### 题目链接https://leetcode-cn.com/problems/water-and-jug-problem/

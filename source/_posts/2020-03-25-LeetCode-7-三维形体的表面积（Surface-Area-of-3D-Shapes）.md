---
title: 'LeetCode # 7 三维形体的表面积（Surface Area of 3D Shapes）'
comments: true
date: 2020-03-25 12:20:45
tags: 
    - 二维数组
    - 算法
    - LeetCode
categories:
    - [指尖飞舞, 算法]
---
### 题目：
> 在 N * N 的网格上，我们放置一些 1 * 1 * 1  的立方体。
>
> 每个值 v = grid[i][j] 表示 v 个正方体叠放在对应单元格 (i, j) 上。
>
> 请你返回最终形体的表面积。

### 示例1：
> 输入：[[2]]
> 输出：10
### 示例2：
> 输入：[[1,2],[3,4]]
> 输出：34
### 示例3：
> 输入：[[1,0],[0,2]]
> 输出：16
### 示例4：
> 输入：[[1,1,1],[1,0,1],[1,1,1]]
> 输出：32
### 示例5：
> 输入：[[2,2,2],[2,1,2],[2,2,2]]
> 输出：46
### 提示：
> + 1 <= N <= 50
> + 0 <= grid[i][j] <= 50
___
用示例5举例，二维数组`[[2,2,2],[2,1,2],[2,2,2]]`：
```Java
int[][] grid = {
    {2, 2, 2},
    {2, 1, 2},
    {2, 2, 2}
};
```
表明一个3*3网格，每个格子分别放置对应数字的方块。
那么，表面积 = 总数 * 6 - 2(x + y + z)，其中x, y, z分别表示x, y, z方向重叠面数
```Java
class Solution {
    public int surfaceArea(int[][] grid) {
        // this surface means hidden surface
        int surfaceZ = 0, surfaceY = 0, surfaceX = 0;
        // value count
        int value = 0;
        for (int raw = 0; raw < grid.length; raw++) {
            for (int column = 0; column < grid[raw].length; column++) {
                // count value
                value += grid[raw][column];
                // for each X, Y ,Z count hidden surface
                if (raw < grid.length - 1)
                    surfaceX += Math.min(grid[raw][column], grid[raw+1][column]);
                if (column < grid[raw].length - 1)
                    surfaceY += Math.min(grid[raw][column], grid[raw][column+1]);
                if (grid[raw][column] > 0)
                    surfaceZ += (grid[raw][column] - 1);
            }
        }
        // this surface is real "surface"
        int surface = 0;
        surface = value * 6 - surfaceX * 2 - surfaceY * 2 - surfaceZ * 2;
        return surface;
    }
}
```
+ 时间复杂度：O(N^2)，其中 NN 是 grid 中的行和列的数目
+ 空间复杂度：O(1)

##### 题目链接https://leetcode-cn.com/problems/surface-area-of-3d-shapes/
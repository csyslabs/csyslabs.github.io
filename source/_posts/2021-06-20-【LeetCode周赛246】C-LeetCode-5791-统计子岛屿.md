---
title: 【LeetCode周赛246】C LeetCode 5791. 统计子岛屿
comments: true
date: 2021-06-20 16:11:33
tags:
    - 算法
    - LeetCode
    - 竞赛
    - DFS
    - BFS
    - Flood Fill
    - 洪水灌溉算法
categories:
    - [指尖飞舞, 算法, LeetCode]
    - [指尖飞舞, 算法, 竞赛, LeetCode周赛, 246]

---
__摘要：__
洪水灌溉算法经典题型。
<!-- more -->


### 题目

给你两个 `m x n` 的二进制矩阵 `grid1` 和 `grid2` ，它们只包含 `0` （表示水域）和 `1` （表示陆地）。一个 __岛屿__ 是由 __四个方向__ （水平或者竖直）上相邻的 `1` 组成的区域。任何矩阵以外的区域都视为水域。

如果 `grid2` 的一个岛屿，被 `grid1` 的一个岛屿 __完全__ 包含，也就是说 `grid2` 中该岛屿的每一个格子都被 `grid1` 中同一个岛屿完全包含，那么我们称 `grid2` 中的这个岛屿为 __子岛屿__ 。

请你返回 `grid2` 中 __子岛屿__ 的 __数目__ 。

__示例 1：__
![0x0](test1.png)
> 输入：grid1 = [[1,1,1,0,0],[0,1,1,1,1],[0,0,0,0,0],[1,0,0,0,0],[1,1,0,1,1]], grid2 = [[1,1,1,0,0],[0,0,1,1,1],[0,1,0,0,0],[1,0,1,1,0],[0,1,0,1,0]]
输出：3
解释：如上图所示，左边为 grid1 ，右边为 grid2 。
grid2 中标红的 1 区域是子岛屿，总共有 3 个子岛屿。

__示例 2：__
![0x1](testcasex2.png)
> 输入：grid1 = [[1,0,1,0,1],[1,1,1,1,1],[0,0,0,0,0],[1,1,1,1,1],[1,0,1,0,1]], grid2 = [[0,0,0,0,0],[1,1,1,1,1],[0,1,0,1,0],[0,1,0,1,0],[1,0,0,0,1]]
输出：2 
解释：如上图所示，左边为 grid1 ，右边为 grid2 。
grid2 中标红的 1 区域是子岛屿，总共有 2 个子岛屿。

__提示：__

+ `m == grid1.length == grid2.length`
+ `n == grid1[i].length == grid2[i].length`
+ `1 <= m, n <= 500`
+ `grid1[i][j]` 和 `grid2[i][j]` 都要么是 `0` 要么是 `1` 。

### DFS
在 `grid2` 中找到所有岛屿，并且在寻找的过程中判断每一个块是否和 `grid1` 中对应块相等，不等必然不是子岛屿。

{% tabs g_tab0 %}
<!-- tab C++ -->
```c++
class Solution {
public:
    int R, C;
    int dr[4] = {-1, 0, 1, 0};
    int dc[4] = {0, 1, 0, -1};
    
    void dfs(vector<vector<int>> &grid1, vector<vector<int>> &grid2, int r, int c, bool &issub) {
        if (grid2[r][c] != grid1[r][c]) issub = false;
        grid2[r][c] = 0x3f3f3f3f;
        for (int i = 0; i < 4; i++) {
            int ner = r + dr[i], nec = c + dc[i];
            if (ner < 0 || ner > R - 1 || nec < 0 || nec > C - 1 || !grid2[ner][nec] || grid2[ner][nec] == 0x3f3f3f3f) continue;
            dfs(grid1, grid2, ner, nec, issub);
        }
    }
    
    int countSubIslands(vector<vector<int>>& grid1, vector<vector<int>>& grid2) {
        this->R = grid2.size(), this->C = grid2[0].size();
        
        int res = 0;
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (grid2[i][j] == 1) {
                    bool issub = true;
                    dfs(grid1, grid2, i, j, issub);
                    if (issub) res++;
                }
            }
        }
        
        return res;
    }
};
```
<!-- endtab -->
{% endtabs %}

本题是 [岛屿数量](https://eetoa.github.io/2020/04/21/LeetCode-200-岛屿数量) 的升级版。

{% note primary %}
__原题链接：__ [LeetCode 5791. 统计子岛屿](https://leetcode-cn.com/problems/count-sub-islands/)
{% endnote %}
---
title: LeetCode 559 N叉树的最大深度（Maximum Depth of N-ary Tree）
comments: true
date: 2020-08-31 16:57:58
tags:
    - DFS
    - BFS
    - 树
    - N叉树
    - 树深度
categories:
    - [指尖飞舞, 算法]
---
### 题目
给定一个 N 叉树，找到其最大深度。
最大深度是指从根节点到最远叶子节点的最长路径上的节点总数。
例如，给定一个 `3叉树` :
```
       1
   /   |   \
  3    2    4
 / \   
5   6
```
我们应返回其最大深度，3。
说明:
> 1.树的深度不会超过 1000。
> 2.树的节点总不会超过 5000。
___
```Java
// Definition for a Node.
class Node {
    public int val;
    public List<Node> children;

    public Node() {}

    public Node(int _val) {
        val = _val;
    }

    public Node(int _val, List<Node> _children) {
        val = _val;
        children = _children;
    }
};
```

### DFS
没啥可说的，和「LeetCode-104-二叉树的最大深度（Maximum-Depth-of-Binary-Tree）」对比，无非就是取最大值的不同。
```Java
class Solution {
  public int maxDepth(Node root) {
    if (root == null) {
      return 0;
    } else if (root.children.isEmpty()) {
      return 1;  
    } else {
      List<Integer> heights = new LinkedList<>();
      for (Node item : root.children) {
        heights.add(maxDepth(item)); 
      }
      return Collections.max(heights) + 1;
    }
  }
}
```
当然，亦可维护一个「最大值变量」，children的每个元素，和它作比较。
```Java
//本方法参考HJF的题解
class Solution {
   public int maxDepth(Node root) {
        if (null == root) {
            return 0;
        }
        int result = 1;
        for (Node child : root.children) {
            result = Math.max(result, 1 + maxDepth(child));
        }
        return result;
    }
}
```
### 迭代
可以由DFS递归改成迭代，同时维护一个最大值变量，每次出队需要将节点的深度信息和最大值变量作比较。所以节点需要携带深度信息。可以借助`pair`，也可以写一个新的节点类。
```Java
//本方法参考官方题解
import javafx.util.Pair;
import java.lang.Math;

class Solution {
  public int maxDepth(Node root) {
    Queue<Pair<Node, Integer>> stack = new LinkedList<>();
    if (root != null) {
      stack.add(new Pair(root, 1));
    }

    int depth = 0;
    while (!stack.isEmpty()) {
      Pair<Node, Integer> current = stack.poll();
      root = current.getKey();
      int current_depth = current.getValue();
      if (root != null) {
        depth = Math.max(depth, current_depth);
        for (Node c : root.children) {
          stack.add(new Pair(c, current_depth + 1));    
        }
      }
    }
    return depth;
  }
};
```
本题亦可使用BFS，但是我不想写了。

__题目链接：__ https://leetcode-cn.com/problems/maximum-depth-of-n-ary-tree/
__官方题解：__ https://leetcode-cn.com/problems/maximum-depth-of-n-ary-tree/solution/ncha-shu-de-zui-da-shen-du-by-leetcode/

---
title: 'LeetCode #5 链表的中间结点（Middle of the Linked List）'
comments: true
date: 2020-03-23 17:22:01
tags:
    - 链表
    - LeetCode
    - 算法
categories:
    - [指尖飞舞, 算法]
---
### 题目
> 给定一个带有头结点 head 的非空单链表，返回链表的中间结点。
> 如果有两个中间结点，则返回第二个中间结点。

__示例1：__
> 输入：[1,2,3,4,5]
> 输出：此列表中的结点 3 (序列化形式：[3,4,5])
> 返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
> 注意，我们返回了一个 ListNode 类型的对象 ans，这样：
> ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.

__示例2：__
> 输入：[1,2,3,4,5,6]
> 输出：此列表中的结点 4 (序列化形式：[4,5,6])
> 由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。

__提示：__
+ 给定链表的结点数介于 1 和 100 之间。
___

### 快慢指针
定义一个快指针，定义一个慢指针。其中快指针每个循环走两部，慢指针走一步。这样，当快指针走慢整个链表，由于其速度是慢指针的二倍，故慢指针停留的位置即为链表的中间结点。

注意到，当链表结点个数为偶时，即链表有两个中间结点。此时，题干要求返回第二个结点。
```Java
class Solution0x0 {
    public ListNode middleNode(ListNode head) {
        ListNode fast = head;
        ListNode slow = head;
        while (fast.next != null) {
            if (fast.next.next == null) fast = fast.next;
            else fast = fast.next.next;
            slow = slow.next;
        }
        return slow;
    }
}
```
若题干要求返回第一个结点，应该这样：
```Java
class Solution0x1 {
    // return secondary node while we got a even node linkedList
    public ListNode middleNode(ListNode head) {
        ListNode fast = head;
        ListNode slow = head;
        while (fast.next != null) {
            if (fast.next.next == null) fast = fast.next;
            else {
            fast = fast.next.next;
            slow = slow.next;
            } 
        }
        return slow;
    }
}
```
### 链表类数组
换个思路，当我们知道链表结点个数，个数/2即为中间结点位置。我们可以创建一个链表类数组（记得曾经用过的计数数组吗？数组是个好东西，我们要把它玩坏！）循环链表每个结点，把它放在数组里。

注意到，由于题干给出当有两个中间结点取其第二个，我们正好可以利用整形变量特征————int a = 5 / 2，则a被强制转换向下取整为2。
```Java
class Solution0x2 {
    public ListNode middleNode(ListNode head) {
        ListNode[] arr = new ListNode[100]; //we have restriction about length of linkedList
        int i = 0;
        int count = 0;
        while (head != null) {
            arr[i++] = head;
            count++;
            if (head.next == null) break;
            else head = head.next;
        }
        return arr[count / 2];
    }
}
```
或者用ArratList可以稍微稍微节省点空间。
```Java
class Solution0x3 {
    public ListNode middleNode(ListNode head) {
        List<ListNode> arr = new ArrayList<>();
        int i = 0;
        while (head != null) {
            arr.add(head);
            if (head.next == null) break;
            else head = head.next;
        }
        return arr.get(arr.size() / 2);
    }
}
```

__题目链接：__ https://leetcode-cn.com/problems/middle-of-the-linked-list/
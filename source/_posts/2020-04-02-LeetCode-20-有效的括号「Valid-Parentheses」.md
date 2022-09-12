---
title: 'LeetCode #20 有效的括号「Valid Parentheses」'
comments: true
date: 2020-04-02 15:24:44
tags:
    - 栈
    - 数据结构
    - 算法
    - LeetCode
categories:
    - [指尖飞舞, 算法]
---
### 题目
给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：
1. 左括号必须用相同类型的右括号闭合。
2. 左括号必须以正确的顺序闭合。
注意空字符串可被认为是有效字符串。

__示例1：__
> 输入: "()"
> 输出: true

__示例2：__
> 输入: "()[]{}"
> 输出: true

__示例3：__
> 输入: "(]"
> 输出: false

__示例4：__
> 输入: "([)]"
> 输出: false

__示例5：__
> 输入: "{[]}"
> 输出: true
___
### HashMap辅助的栈解法
构建一个key为开括号`'(','[','{'`value为闭括号`')'']''}'`的HashMap。
遍历String字符串，当遇到开括号，由于将来有机会遇到与之对应的闭括号，故将其入栈。
当遇到闭括号，一旦它和栈顶的括号不匹配，可断言整体不是有效括号。（栈为空时，遇到的第一个若为闭括号也可看成与栈顶不匹配，但需做特殊处理）
当遍历完String字符串，中途没出现闭括号和栈顶字符不匹配的情况，此时若栈为空，则可断言之前入栈的开括号全部被匹配移除；若栈非空，可断言之前入栈的开括号没有找到匹配的闭括号，整体不属于有效括号。
```Java
class Solution0x0 {
    public static boolean isValid(String s) {
        if (s == null) return true;
        Map<Character, Character> map = new HashMap<>();
        map.put(')', '(');
        map.put(']', '[');
        map.put('}', '{');
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char cha = s.charAt(i);
            if (!map.containsKey(cha)) {
                stack.push(cha); //开括号入栈
            }
            else {
                // 栈为空时，必然return false，但为了用相同的方法让cha能和栈顶元素比较，push一个随便啥的字符
                char top = stack.isEmpty() ? '!' : stack.pop();
                if (map.get(cha) != top) return false;
            }
        }
        //循环结束，判断栈的状态
        return stack.isEmpty();
    }
}
```

### 纯栈解法
基本思路与上述方法一致，只是在判断闭括号栈顶元素时用一个小技巧代替`HashMap`。
遍历字符串，当遇到开括号时，把相对应的闭括号入栈。比如遇到`(`，把`)`入栈。这样，当下一个若是闭括号我们要那它和栈顶元素比较的话，可以不查`HashMap`而是直接比较是否相等。若相等，则是一对。继续循环。
```Java
class Solution0x1 {
    public boolean isValid(String s) {
        if (s == null) return true;
        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < s.length(); i++) {
            char cha = s.charAt(i);
            if (cha == '(') stack.push(')');
            else if (cha == '[') stack.push(']');
            else if (cha == '{') stack.push('}');
            else if (stack.isEmpty() || cha != stack.pop()) return false; //此时遇到闭括号且栈为空，则必然无效，或者闭括号与栈顶元素不匹配，必然无效
        }
        return stack.isEmpty();
    }
}
```

__题目链接：__ https://leetcode-cn.com/problems/valid-parentheses/
__参考题解：__ https://leetcode-cn.com/problems/valid-parentheses/solution/you-xiao-de-gua-hao-by-leetcode/

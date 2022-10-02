---
title: 浅谈java的static关键字
comments: true
date: 2020-03-14 00:43:07
tags: 
    - Java
categories: 
    - [指尖飞舞, Java, Java SE]
---
__摘要：__
读《Thinking In Java》的一些关于static关键字的总结。
<!--more-->

## Why
### Why we have to use a `static` key word? 
一般来说，要想引用类成员变量、使用类方法或者分配存储空间，需要创建一个对象。
如：
```Java
//引用类变量，注意到st1.i和st2.i指向同一存储空间，具有相同值47
Class StaticTest {
    int i = 47;
}
StaticTest st1 = new StaticTest();
StaticTest st2 = new StaticTest();
st1.i
st2.i
//使用类方法
Class Incrementable {
    void increment() {StaticTest.i++; }
}
Incrementable sf = new INcrementable();
sf.increment;
```
那么，如果我们遇到特殊需求。比如我们希望为特定域（field）分配单一存储空间，而不去考虑究竟需要创建多少对象，甚至不用创建对象；再比如我们希望某个方法不与包含它的类的对象相关联，就是说，可以不用创建对象而使用方法。

此时，我们可以使用`static`关键字。

## How
### How do we use `static`
当声明一个事物是static时，就意味着这个域或方法不会与包含它的类的任何对象实例关联在一起。

回顾上述两个类，我们可以声明类变量`i`和类方法`increment()`是`static`，再直接使用类名引用它们:
```Java
Class StaticTest {
    static int i = 47;
}
//不必创建对象而使用i
StaticTest.i++
//不必创建对象而使用方法
Class Incrementable {
    static void increment() {StaticTest.i++; }
}
Incrementable increment();
//另一个广为人知的例子  wow, that was epic.
public class Main {
    public static void main(String[] args) {
	// write your code here
    }
}
```

### 需要注意的地方
> + 类中`static`方法不能访问非`static`变量。
> + 类中`static`方法不能使用`this`关键字。
> 原因就是`Static`方法是类方法，先于任何的实例（对象）存在。即`Static`方法在类加载时就已经存在了，但是对象是在创建时才在内存中生成。


## 总结
> + 声明为`static`的事物也可以用前文所述常规方法引用。
> + 通过类名直接引用是引用`static`事物的首选方式，这不仅是因为它强调了事物的`static`结构，而且在某些情况下它还为编译器进行优化提供了更好的机会。

_总结自《Thinking in Java 4th edition》P29 - P30_






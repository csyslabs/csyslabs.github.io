---
title: '【游戏逆向】找ViewMatrix的一般方法'
comments: true
date: 2021-01-19 05:02:28
tags:
    - 游戏逆向
    - ViewMatrix
    - World-to-Screen
categories:
    - [不亦乐乎]
---
__摘要：__
总结了找游戏ViewMatrix的一般性方法。
<!-- more -->

### ViewMatrix结构：
> 它分为四行或四列.
> 四行中，第一行为Left(X)轴，第二行为Up(Y)轴，第三行为Forward(Z)轴，第四行为Translation(用于计算).

### ViewMatrix的特性（row major）
> 0. pitch和yaw变化时, 矩阵中前三行绝大部分数字一定发生变化；反之一定不变。
> 1. 前三行每个数字均在[-2, 2]之间
> 2. 第三行每个数字均在[-1, 1]之间
> 3. 第四行数字较大
> 4. 当pitch在[-90, 90]范围内变化时，对应第三行（Forward行）某个数字在[-1, 1]范围内变化，他们具有良好的正相关性。
> 5. 如果pitch变化，yaw保持不变，则第三行部分数字变化，前两行部分数字不变；反之，如果pitch保持不变，yaw发生变化，则第三行部分数字不变，前两行部分数字变化。
> 6. 视角变小时（机瞄），第一行第一个数字的绝对值增大。
> 7. 前三行后两位数字相同，矩阵中存在一个为0的数。（GTA5和Assault Cube已验证）

### ViewMatrix的特性（column major）
> 0. pitch和yaw变化时, 矩阵中前三列绝大部分数字一定发生变化；反之一定不变。
> 1. 前三列每个数字均在[-2, 2]之间
> 2. 第三列每个数字均在[-1, 1]之间
> 3. 第四列数字较大
> 4. 当pitch在[-90, 90]范围内变化时，对应第三列（Forward列）某个数字在[-1, 1]范围内变化，他们具有良好的正相关性。
> 5. 如果pitch变化，yaw保持不变，则第三列部分数字变化，前两列部分数字不变；反之，如果pitch保持不变，yaw发生变化，则第三列部分数字不变，前两列部分数字变化。
> 6. 视角变小时（机瞄），第一列第一个数字的绝对值增大。
> 7. 前三列后两位数字相同，矩阵中存在一个为0的数。（GTA5和Assault Cube已验证）

### 综合特性(row and column major)
> 存在一个恒定为零的数字。当矩阵为row major时，这个零在第3行第1列（matrix[2][0] = 0.f）;当矩阵为column major时，零在第1行第3列（matrix[0][2] = 0.f）。
> 存在一个数字，当视角垂直水平面90度向上时，恒定为1；向下时恒定为-1；这个数字在第3行第3列的位置。（matrix[2][2] = x）.
> 第4行或第4列较大。

### 利用以上特性搜索ViewMatrix地址
一般利用第4条特性，配合pitch的变化搜索第三行特定数字。注意这种方法搜到的数字并非matrix首位，需要在浏览内存区域时，先对齐数组，判断数组首位。
> + 搜索unknow initial value
> + 改变pitch和yaw，搜索changed value
> + 搜索value between -1 and 1
> + 不断增加和减少pitch，分别搜索increased value和decreased value
> + 将结果控制在几千个以内，删除非静态地址，在静态地址中进一步筛选。
> + 注意到静态地址是分成一个个内存段的，对于每一个段，选择段首地址和段尾地址，浏览内存区域。
> + 一般来说，view matrix存在在静态地址中跨度较大的段中。

或者直接搜索矩阵第一个数字
> + 搜索unknow initial value
> + 改变pitch和yaw，搜索changed value
> + 搜索value between -2 and 2
> + 改变pitch和yaw，搜索changed value
> + 保持pitch和yaw不变，搜索unchanged value
> + 剩下和上面一致。


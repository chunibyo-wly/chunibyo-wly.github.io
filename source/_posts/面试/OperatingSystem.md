---
typora-root-url: ..
title: 操作系统复习 
mathjax: true
date: 2020-03-04 12:45:34
tags:
categories:
	- 面试
---
![image-20210114195817752](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195817752.png)

<!-- more -->

# 一. 进程管理

## 1. 进程同步

同步, 互斥, pv操作

管程(monitors): 结构内的多个子程序（对象或模块）形成的多个工作线程互斥访问共享资源。管程是为了解决信号量在临界区的 PV 操作上的配对的麻烦，把配对的 PV 操作集中在一起，生成的一种并发编程方法。其中使用了条件变量这种同步机制。

## 2. 进程通信

![image-20210114195826089](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195826089.png)

1. 管道, fd[0]用于读, fd[1]用于写
   ![image-20210114195833790](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195833790.png)
2. 命名管道
3. 消息队列(可以独立于读写进程存在)
4. 信号量
5. 共享内存
6. 套接字

## 3. 线程通信

1. synchronized同步
2. while轮询的方式(浪费资源)
3. wait/notify机制

## 4. 进程操作

进程 = 代码段 + 数据段 + PCB

进程0: Linux引导中创建的第一个进程，完成加载系统后，演变为进程调度、交换及存储管理进程。

进程1: init进程，由0进程创建，完成系统的初始化. 是系统中所有其它用户进程的祖先进程

### 1. fork

```cpp
#include <unistd.h>
...
pid_t fork(void);
```

`fork()` 可能會有以下三種回傳值：

- **-1 ：** 發生錯誤
- **0 ：** 代表為子程序
- **大於 0 ：** 代表為父程序, 其回傳值為子程序的 ProcessID

## 5. 孤儿和僵尸进程

**孤儿进程**：一个父进程退出，而它的一个或多个子进程还在运行，那么那些子进程将成为孤儿进程。孤儿进程**将被 init 进程（进程号为1）所收养**，并由 init 进程对它们完成状态收集工作。

**僵尸进程**：一个进程使用 fork 创建子进程，如果子进程退出，而父进程并没有调用 wait 或 waitpid 获取子进程的状态信息，那么**子进程的进程描述符仍然保存在系统中**。这种进程称之为僵尸进程。

## 6. 守护进程(Daemon)

它独立于控制终端并且周期性地执行某种任务或等待处理某些发生的事件。它不需要用户输入就能运行而且提供某种服务

系统日志进程syslogd、 web服务器httpd、邮件服务器sendmail和数据库服务器mysqld

超级用户

## 7. 协程

从函数的角度看，

- 协程避免了传统的函数调用栈，几乎可以无限递归。

从线程的角度看，

- 协程没有上下文切换，几乎可以无限并发
- 协程在用户态进行显式的任务调度，可以把异步操作转换成同步操作，也意味着无需额外的加锁。

## 8. 上下文切换

![image-20210114195857204](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195857204.png)

![image-20210114195936204](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195936204.png)

# 二. 死锁

> 面试官问你告诉我什么是死锁，我就录用你
> 你回答面试官你录用我，我告诉你

## 1. 死锁的条件

1. 互斥
2. 占有和等待
3. 不可抢占
4. 循环等待

## 2. 解决

![image-20210114195943194](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195943194.png)

![image-20210114195949737](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114195949737.png)

# 三. 内存管理

## 1. 虚拟内存

让物理内存扩充成更大的逻辑内存，从而让程序获得更多的可用内存

这些页被映射到物理内存，但不需要映射到连续的物理内存，也不需要所有页都必须在物理内存中。当程序引用到一部分不在物理内存中的地址空间时，由硬件执行必要的映射，将缺失的部分装入物理内存并重新执行失败的指令。

## 2. 页面置换算法

> 701203042

1. OPT

   被换出的页面将是最长时间内不再被访问

   现实情况不存在

   |      | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    | 2    |
   | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
   | 1    | 7    | 7    | 7    | 2    | 2    | 2    | 2    | 2    | 2    |
   | 2    |      | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    |
   | 3    |      |      | 1    | 1    | 1    | 3    | 3    | 4    | 4    |

2. LRU, Least Recently Used

   当一个页面被访问时，将这个页面移到链表表头。这样就能保证链表表尾的页面时最近最久未访问的

   |      | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    | 2    |
   | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
   | 1    | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    | 2    |
   | 2    |      | 7    | 0    | 1    | 2    | 0    | 3    | 0    | 4    |
   | 3    |      |      | 7    | 0    | 1    | 2    | 2    | 3    | 0    |

3. NRU, Not Recently Used

   访问位 + 修改位

4. FIFO, First In First Out(二次机会)

5. Clock, fifo改成环形, 指针指向最老页面

## 3. 内存管理

1. 进程的内存空间布局
   ![image-20210114200000596](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114200000596.png)
   1. 内核空间(大小一般固定)
   2. 用户态的栈
   3. mmap(内存映射)
   4. brk(堆): 由程序员分配释放
   5. 栈: 临时变量, 函数参数
   6. BSS(Block Started By Symbol): 存放未初始化的局部变量, 变量使用前由运行时初始化为零
   7. 数据段: 静态变量和已初始化且不为零的局部变量
   8. 代码段: 可执行文件操作指令 , 只读, 运行前大小已知

# 四. 设备管理

## 1. 磁盘调度算法

1. FCFS, First Come First Served
   ![image-20210114200054178](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114200054178.png)

2. SSTF, Shortest Seek Time First

   饥饿
   ![image-20210114200124709](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114200124709.png)

3. SCAN
   ![image-20210114200140413](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114200140413.png)

# 五. 链接



# 六. Linux
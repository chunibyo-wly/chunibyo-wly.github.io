---
typora-root-url: ..
title: c++复习
mathjax: true
date: 2020-03-14 18:35:51
tags:
categories:	
	- 面试
---
![cpp](/images/cpp.png)

<!-- more -->

# new和malloc

1. new从自由存储区分配内存空间
   malloc从堆上分配内存空间

2. new返回对象类型指针
   malloc返回void *, 需要强制转化

3. new内存分配失败抛出bac_alloc异常, 不会返回NULL
   malloc失败时返回NULL

   ```cpp
   int *a  = (int *)malloc (sizeof (int ));
   if(NULL == a)
   {
       ...
   }
   else 
   {
       ...
   }
   
   try
   {
       int *a = new int();
   }
   catch (bad_alloc)
   {
       ...
   }
   ```

4. malloc需要显示指定类型大小`malloc(sizeof(int))`

5. 构造/析构函数

   1. new操作符
      1. 调用operator new函数, 分配一块足够大的,**原始**的,未命名的内存空间以便存储特定类型的对象
      2. 构造对象, 传入初值
      3. 返回对象指针
   2. delete操作符
      1. 析构函数
      2. operator delete

6. 数组

   1. new: `A * ptr = new A[10];`
   2. malloc: `int * ptr = (int *) malloc(sizeof(int)* 10);`

7. operator new的实现可以基于malloc

8. opeartor new /operator delete可以被重载

# new和delete

# 智能指针

   ```cpp
std::auto_ptr<report> ps(new report("using auto ptr"));
 ps->comment();
   ```

# lambda

# 数据结构

[https://marian5211.github.io/2018/03/09/B%E6%A0%91%E3%80%81B-%E6%A0%91%E3%80%81AVL%E6%A0%91%E3%80%81Trie%E6%A0%91%E5%8F%8A%E5%85%B6%E5%BA%94%E7%94%A8%E5%9C%BA%E6%99%AF/](https://marian5211.github.io/2018/03/09/B树、B-树、AVL树、Trie树及其应用场景/)

map, set 
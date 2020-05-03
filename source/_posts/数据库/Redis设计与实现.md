---
typora-root-url: ..
title: Redis设计与实现
mathjax: true
date: 2020-05-02 23:35:49
tags:
	- redis
categories:
	- 数据库
---

![img](/../images/1200px-Redis_Logo.svg.png)

<!-- more -->

# 一、数据结构与对象

## 第二章、简单动态字符串(SDS)

simple dynamic string

```cpp
struct sdshdr {
    // buf数组使用字节的数量
    int len;
    
    // buf数组未使用字节的数量
    int free;
    
    // 字节数组，用于保存字符串
    char buf[];
};
```

## 第三章、链表

链表键、发布与订阅、慢查询和监视器

```cpp
typedef struct ListNode {
    struct ListNode *prev;
    struct ListNode *next;
    void *value;
    
}ListNode;

typedef struct List {
    ListNode* head;
    ListNode* tail;
    unsigned long len;
    
    // 节点值复制函数
    void *(*dup)  (void *ptr);
    
    // 节点值释放函数
    void  (*free) (void *ptr);
    
    // 节点值对比函数
    int   (*match)(void *ptr);
}List;
8465656
```


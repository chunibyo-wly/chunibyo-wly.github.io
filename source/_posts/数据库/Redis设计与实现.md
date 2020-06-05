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

# 命令

## 一、string

`set`, `get`, `del`, `mset`, `mget`

## 二、hash

`hset h1 name liming`

`hdel h1 age`

## 三、list

`lrange`, `lpop`

## 四、set

`sadd`， `smembers`

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

## 第四章、字典

### 4.1 哈希表

```cpp
typedef struct dictht {
    // 哈希表数组
    dictEntry **table;
    
    // 哈希表大小
    unsigned long size;
    
    // 用于计算索引值, 等于 size-1
    unsigned long sizemask;
    
    // 哈希表节点数目
    unsigned long used;
}dictht;
```

### 4.2 哈希表节点

```cpp
typedef struct dictEntry {
    // 键
    void *key;
    
    // 值
    union z{
        void *val;
        uint64_t u64;
        int64_t s64;
    } v;
    
    // 指向下一个哈希表节点
    struct dictEntry *next;
}dictEntry;
```

### 4.3 字典

```cpp
typedef struct dict {
    // 类型特定函数
    dictType *type;
    
    // 私有数据
    void *privdata;
    
    // 哈希表
    dictht ht[2];
    
    // rehash索引
    int trehashidx;
}dict;
```

### 4.4 哈希算法

1. hash   = dict->type->MurmurHash2(key)
2. index = hash & dict->ht[0].sizemask;

### 4.5 rehash

1. `ht[0]` 渐进式 rehash 到 `ht[1]`
2. 释放 `ht[0]`
3. `ht[1]` 设置为 `ht[0]`, 给 `ht[1]` 分配一个空白哈希表

## 第五章、跳跃表

有序集合的底层实现之一（另一个是字典）

`zskiplist`， `zskiplistNode`

随机算法

## 第六章、整数集合

```c
typefef struct intest {
    // int16_t, int32_t, int64_t
    uint32_t encoding;
    
    uint32_t length;
    
    int8_t contents[];
}
```

升级， 无法降级
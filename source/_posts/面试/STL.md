---
typora-root-url: ..
title: STL源码剖析
mathjax: true
date: 2020-04-29 18:35:51
tags:
	- cpp
categories:	
	- 面试

---

![image-20210114200323754](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114200323754.png)

<!-- more -->

# 一、STL简介

## 1.9 常见迷惑写法

### 1.9.4 increment / decrement / dereference

```cpp
#include<iostream>

using namespace std;

class INT {
    friend ostream& operator << (ostream& os, const INT& i);
public:
    INT(int i) : m_i(i) {};

    INT& operator++() {
        ++(this->m_i);
        return *this;
    }

    const INT operator++(int) {
        INT temp = *this;
        ++(*this);
        return temp;
    }

    INT& operator--() {
        --(this->m_i);
        return *this;
    }

    const INT operator--(int) {
        INT temp = *this;
        --(*this);
        return temp;
    }

    int& operator*() const {
        return (int &)m_i;
    }
private:
    int m_i;
};

ostream& operator<<(ostream& os, const INT& i) {
    os << '{' << i.m_i << '}';
    return os;
}


int main() {
    INT I(5);
    cout << I++ << endl;
    cout << ++I << endl;
    cout << I-- << endl;
    cout << --I << endl;
    cout << *I  << endl;
}
```

### 1.9.5 前闭后开

$[first, last)$

### 1.9.6 function call

伪函数

```cpp
#include<iostream>

using namespace std;

template<class T>
struct Plus {
    T operator()(const T& x, const T& y) const {return x + y;}
};

template<class T>
struct Minus {
    T operator()(const T& x, const T& y) const {return x - y;}
};

int main() {
    Plus<int> plusobj;
    Minus<int> minusobj;

    cout << plusobj(3, 5) <<endl;
    cout << minusobj(3, 5) <<endl;

    cout << Plus<int>()(3, 5) << endl;
    cout << Minus<int>()(3, 5) << endl;
}
```

# 二、空间适配器(allocator)



# 四、序列式容器(sequence containers)

## 4.2 vector

### 4.2.2 vector定义摘要

```cpp
template <class T, class Alloc>
class Vector {
public:
    typedef T           value_type;
    typedef value_type* pointer;
    typedef value_type* iterator;
    typedef value_type* reference;
    typedef size_t      size_type;
    typedef ptrdiff_t   difference_type;

protected:
    typedef simple_alloc<value_type, Alloc> data_allocator;

    iterator start;             // 目前使用的空间的头
    iterator finish;            // 目前使用的空间的尾
    iterator end_of_storage;    // 目前可用的空间的尾

    void insert_aux(iterator position, const T& x);
    void deallocate() {
        if (start)
            data_allocator::deallocate(start, end_of_storage - start);
    }
    void fill_initialize(size_type n, const T& value) {
        start = allocate_and_fill(n, value);
        finish = start + n;
        end_of_storage = finish;
    }

public:
    iterator begin() {
        return start;
    }
    iterator end()   {
        return finish;
    }
    size_type size() const {
        return size_type(end() - begin());
    }
    size_type capacity() const {
        return size_type(end_of_storage - begin();)
    }
    bool empty() const {
        return begin() == end();
    }
    reference operator[](size_type n) {
        return *(begin() + n);
    }

    vector(): start(0), finish(0), end_of_storage(0) {}
    vector(size_type n, const T& value){
        fill_initialize(n, value);
    }
    vector(int n, const T& value) {
        fill_initialize(n, value);
    }
    vector(long n, const T& value) {
        fill_initialize(n, value);
    }
    explicit vector(size_type n) {
        fill_initialize(n, T());
    }

    ~vector() {
        destroy(start, finish);
        deallocate();
    }

    reference front() {
        return *begin();
    }
    reference back() {
        return *(end()-1);
    }
    void push_back(const T& x) {
        if(finish != end_of_storage) {
            construct(finish, x);
            ++finish;
        }
        else
            insert_aux(end(), x);
    }
    void pop_back() {
        --finish;
        destroy(finish);
    }
    iterator erase(iterator position) {
        if(position+1 != end())
            copy(position+1, finish, position);
        --finish;
        destroy(finish);
        return position;
    }
    void resize(size_type new_size, const T& x) {
        if(new_size < size())
            erase(begin()+new_size, end());
        else
            insert(end(), new_size-size(), x);
    }
    void resize(size_type new_size) {
        resize(new_size, T());
    }
    void clear() {
        erase(begin(), end());
    }

protected:
    iterator allocate_and_fill(size_type n, const T& x) {
        iterator result = data_allocator::allocate(n);
        uninitialized_fill_n(result, n, x);
        return result;
    }
};
```

### 4.2.3 迭代器

Random Access Iterators

### 4.2.4 数据结构

```cpp
iterator start;             // 目前使用的空间的头
iterator finish;            // 目前使用的空间的尾
iterator end_of_storage;    // 目前可用的空间的尾
```

### 4.2.5 构造与内存管理

```cpp
#include <iostream>
#include <vector>

using namespace std;

int main() {
    vector<int> iv(2, 9);
    cout << iv.size()       << endl; // 2
    cout << iv.capacity()   << endl; // 2

    iv.push_back(1);
    cout << iv.size()       << endl; // 3
    cout << iv.capacity()   << endl; // 4

    iv.pop_back();
    cout << iv.size()       << endl; // 2
    cout << iv.capacity()   << endl; // 4

    iv.clear();
    cout << iv.size()       << endl; // 0
    cout << iv.capacity()   << endl; // 4
}
```

动态增加大小: 以原大小的两倍另外配置一块较大的空间, 然后将原内容拷贝过来, 释放原空间, 导致原来指向vector的迭代器失效

### 4.2.6元素操作

```cpp
void pop_back()

iterator erase(iterator first, iterator last)
    
iterator erase(iterator position)
    
void clear()
    
// 从position开始, 插入n个元素, 值为x
void insert(iterator position, size_type n, const T& x)
```

## 4.3 list

### 4.3.3 迭代器

Bidirectional Iterators

插入(insert)和接合(splice)不会造成迭代器失效, erase只有**"指向被删除"**的迭代器失效

### 4.3.4 list 的数据结构

环状双向链表

**注意**

1. 指针node指向尾部的空白节点，node就可以符合STL的**前闭后开**
2. size()方法复杂度是O(n)的

```cpp
template<class T>
class list {
protected:
    typedef __list_node<T> list_node;
public:
    typedef list_node* link_type;
protected:
    link_type node; // 用这个指针表示整个环状双向链表
    
    iterator begin() {return (link_type)((*node).next);}
    iterator end()   {return node;}
    bool empty() const {return node->next == node;}
    
    size_type size() const {
        size_type result = 0;
        distance(begin(), end(), result);
        return result;
    }
    reference front() {return *begin();}
    reference back() { return *(--end()); }
    
};
```

### 4.3.6 list 的元素操作

1. push_front:() insert(begin(), x);
2. push_back(): insert(end(), x);
3. erase(): return下一个节点的迭代器
4. pop_front(): erase(begin());
5. pop_back(): 
   iterator tmp=end(); // 最后一个是空节点
   erase(--tmp);
6. clear(): 
   while(cur != node) {...}
   node->nxt = node, node->pre = node;
7. remove(const T& value); 将数值为value的所有元素移除
8. unique(): 移除**连续而相同的元素**
9. transfer()
10. splice():
    1. x结合于position所指位置之前, x必须不同于*this
    2. i 所指元素接合于 position前
    3. 将 [first, last) 所有元素结合与 position 前
11. list 不能使用STL的sort, 但是自带sort 成员函数
    因为STL的sort只接受RandomAccessIterator

## 4.5 stack & 4.6 queue

deque 为底层的配接器(adapter), 没有迭代器
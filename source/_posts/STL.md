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

![Standard Template Library (/images/Standard-Template-Library-in-C.png) in C++ - JournalDev](https://cdn.journaldev.com/wp-content/uploads/2020/02/Standard-Template-Library-in-C.png)

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


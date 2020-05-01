---
typora-root-url: ..
title: c++复习
mathjax: true
date: 2020-03-14 18:35:51
tags:
	- cpp
categories:	
	- 面试
---

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


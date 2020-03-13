---
typora-root-url: ..
title: 春招记录
mathjax: true
date: 2020-03-02 23:09:50
tags:
categories:
---
<!-- more -->

| 时间  | 公司             | 简历 | 笔试 | 一面 | 二面 | 三面 |
| ----- | ---------------- | :--: | :--: | :--: | :--: | :--: |
| 03/02 | mihoyo           |  ✔   |      |      |      |      |
|       | bilibili         |      |      |      |      |      |
|       | 斗鱼             |      |      |      |      |      |
| 03/04 | 阿里             |      |      |      |      |      |
| 03/10 | 头条(运维)       |      |      |      |      |      |
|       | 网易雷火(服务器) |      |      |      |      |      |
|       | 阿里提前批(飞天) |  ✔   |      |      |      |      |



## [【暑期实习面经】阿里一二凉经字节跳动 一二三面 腾讯一面](https://www.nowcoder.com/discuss/375967?type=post&order=time&pos=&page=1)

### 1. 阿里一面

1. const

   1. const修饰普通变量: 常量不能修改(注意编译器优化, volatile)

   2. const修饰指针变量

      1. 修饰指针指向的内容: 内容不可变

         ```cpp
         const int *p = 8;
         ```

      2. 修饰指针: 指针不可变

         ```cpp
         int* const p = &a;
         *p = 9; // 正确
         p = &b; // 错误
         ```

      3. 修饰指针和指针指向的内容: 均不可变

   3. const参数传递

      1. 按值传递的参数: 可以当没有必要(本来就是拷贝)

      2. 指针参数

         ```cpp
         void Cpf(int *const a)
         {
             cout<<*a<<" ";
             *a = 9;
         }
         ```

      3. 自定义类型的参数

   4. const函数返回值

      1. const修饰内置类型: 是否修饰作用一样

         ```cpp
         const int Cmf()
         {
             return 1;
         }
         ```

      2. const修饰函数指针

         ```cpp
         const char *getStr() {
             return "dddd";
         }
         
         const char *str = getStr();
         ```

   5. const修饰成员函数
      const 修饰类成员函数，其目的是防止成员函数修改被调用对象的值

      ```cpp
      class {
          int get_cm()const
          {
             return _cm;
          }
      }
      ```

2. 多态

   一个接口, 多种行为

   1. 编译时多态: 函数重载与模板(静态)
   2. 运行时多态: 虚函数(动态)

   析构函数: 在多态基类中使用虚析构函数

3. 指针和引用

   1. 代码

      ```cpp
      int a=1;int *p=&a; // p是指针
      int a=1;int &b=a;  // b是引用, 和a相同
      ```

   2. 可以有const指针，但是没有const引用

   3. 指针可以有多级，但是引用只能是一级

   4. 指针可以改变，但引用不可改变

   5. "sizeof引用"得到的是所指向的变量(对象)的大小，而"sizeof指针"得到的是指针本身的大小

      ```cpp
      int b=&a;
      sizeof(b); // 4
      sizeof(int *); // 8(64位)
      ```

   6. 函数参数

      1. 指针本质还是值传递

      2. 引用传递的是实参本身

         ```cpp
         void test(int &a)
         {
         　　cout<<&a<<endl;
         }
         
         int main(void)
         {
             int a=1;
             cout<<&a<<endl;
             test(a);
             return 0;
         }
         
         // 0x7ffdf0564b14
         // 0x7ffdf0564b14
         ```

4. 判断链表是否循环
   leetcode141

5. 


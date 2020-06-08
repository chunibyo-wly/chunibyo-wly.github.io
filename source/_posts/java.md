---
typora-root-url: ..
title: java基础
mathjax: true
date: 2020-06-01 11:24:16
tags:
categories:

---

![Oracle BrandVoice: Java 14 Makes Code Super Expressive, Say Top ...](data:image/png;base64,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)

<!-- more -->

# 基础

1. 类变量被声明为public static final类型时，类变量名称一般建议使用大写字母。

2. 访问控制修饰符

   |           | 当前类 | 同一包 | 子孙类(同一包) | 子孙类(不同包) | 其他包 |
   | --------- | ------ | ------ | -------------- | -------------- | ------ |
   | public    | Y      | Y      | Y              | Y              | Y      |
   | protected | Y      | Y      | Y              | Y              |        |
   | default   | Y      | Y      | Y              |                |        |
   | private   | Y      |        |                |                |        |

3. 接口与抽象类
   接口和抽象类都是继承树的上层，他们的共同点如下：
   1. 都是上层的抽象层。
   2. 都不能被实例化
   3. 都能包含抽象的方法，这些抽象的方法用于描述类具备的功能，但是不比提供具体的实现。
   
   他们的区别如下：
   
   1. 在抽象类中可以写非抽象的方法，从而避免在子类中重复书写他们，这样可以提高代码的复用性，这是抽象类的优势；接口中只能有抽象的方法。
   2. 一个类只能继承一个直接父类，这个父类可以是具体的类也可是抽象类；但是一个类可以实现多个接口。

# Spring

## 一、概述

1. Inverse of Control
2. Aspect Oriented Progamming

![image-20200601161839112](/images/image-20200601161839112.png)

## 二、IoC

控制反转（Inversion of Control，缩写为IoC），是面向对象编程中的一种设计原则，可以用来减低计算机代码之间的耦合度。其中最常见的方式叫做依赖注入（Dependency Injection，简称DI），还有一种方式叫“依赖查找”（Dependency Lookup）。通过控制反转，对象在被创建的时候，由一个调控系统内所有对象的外界实体，将其所依赖的对象的引用传递(注入)给它。

### 2.1 Bean的属性

| 属性                | 描述                                         |
| ------------------- | -------------------------------------------- |
| class               | packageName + className                      |
| id/name             | 唯一标识                                     |
| scope               | 作用域                                       |
| constructor-arg     |                                              |
| properties          |                                              |
| autowiring mode     |                                              |
| lazy-initialization | 延迟创建(启动时创建)                         |
| initialization      | bean的所有必须属性被容器设置后调用的回调方法 |
| destruction         | bean被销毁时调用的回调方法                   |

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
    
    <!-- A simple bean definition -->
    <bean id="" class="" >
    	<!-- collaborators and configuration for this bean go here -->
    </bean>
    
    <!-- A bean definition with lazy init set on -->
    <bean id="" class="" lazy-init="true">
    	<!-- collaborators and configuration for this bean go here -->
    </bean>
    
    <!-- A bean definition with initialization method -->
    <bean id="" class="" init-method="..." >
    	<!-- collaborators and configuration for this bean go here -->
    </bean>
    
    <!-- A bean definition with destruction method -->
    <bean id="" class="" destroy-method="..." >
    	<!-- collaborators and configuration for this bean go here -->
    </bean>
    
    <!-- more bean definitions go here -->
    
</beans>
```

### 2.2 Bean的作用域

| 作用域         | 描述                                                         |
| -------------- | ------------------------------------------------------------ |
| singleton      | 单例, 默认值                                                 |
| prototype      | 每次调用都产生新的实例                                       |
| request        | 每次Http请求都会创建一个Bean, 仅作用于WebApplicationContext环境 |
| session        | 同一个Http Session共用一个Bean, 仅作用于WebApplicationContext环境 |
| global-session | 一般用于Portlet应用环境，该运用域仅适用于WebApplicationContext环境 |

### 2.3 生命周期

```xml
<bean
            id="hello"
            class="com.example.Hello"
            init-method="init"
            destroy-method="destroy">
        <property name="msg" value="这个msg属性的value"/>
    </bean>
```

Bean的销毁需要使用`AbstractApplicationContext.registerShutdownHook()`

### 2.4 Bean的继承

基于继承使用Bean模板

```xml
<bean id="beanTeamplate" abstract="true">
      <property name="message1" value="Hello World!"/>
      <property name="message2" value="Hello Second World!"/>
      <property name="message3" value="Namaste India!"/>
   </bean>

   <bean id="helloIndia" class="com.tutorialspoint.HelloIndia" parent="beanTeamplate">
      <property name="message1" value="Hello India!"/>
      <property name="message3" value="Namaste India!"/>
   </bean>
```

## 三、依赖注入

### 3.1 基于构造函数的依赖注入

```xml
<beans>
   <bean id="exampleBean" class="examples.ExampleBean">
      <constructor-arg index="0" value="2001"/>
      <constructor-arg index="1" value="Zara"/>
   </bean>
</beans>
```

### 3.2 基于设值函数的依赖注入

```xml
<bean id="john-classic" class="com.example.Person">
      <property name="name" value="John Doe"/>
      <property name="spouse" ref="jane"/>
</bean>
```

### 3.3 @Autowired

# SpringBoot

## 一、AOP

- **@Aspect**：声明该类为一个注解类；
- **@Pointcut**：定义一个切点，后面跟随一个表达式，表达式可以定义为切某个注解，也可以切某个 package 下的方法



- **@Before**: 在切点之前，织入相关代码；
- **@After**: 在切点之后，织入相关代码;
- **@AfterReturning**: 在切点返回内容后，织入相关代码，一般用于对返回值做些加工处理的场景；
- **@AfterThrowing**: 用来处理当织入的代码抛出异常后的逻辑处理;
- **@Around**: 环绕，可以在切入点前后织入代码，并且可以自由的控制何时执行切点；

![image-20200604153551383](/images/image-20200604153551383.png)
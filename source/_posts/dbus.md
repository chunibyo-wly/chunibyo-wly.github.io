---
typora-root-url: ..
title: dbus
mathjax: true
date: 2020-02-26 16:31:46
tags:
	- linux
categories:
	- 运维

---

![使用D-Bus時程序間的通訊](/images/1280px-Processes_with_D-Bus.svg.png)

<!-- more -->

# IPC

Inter-Process Communication，进程间通信

为了能使不同的进程互相访问资源并进行协调工作，才有了进程间通信。通常，使用进程间通信的两个应用可以被分为客户端和服务器，客户端进程请求数据，服务端响应客户端的数据请求。

- 咨询共享
- 加速(多服务器进程间通信)
- 模组化
- 私有权分离

# D-Bus

行程間通訊及远程过程调用機制，可以讓多個不同的计算机程序（即行程）在同一臺電腦上同時進行通訊

D-Bus提供了一個軟體匯流抽象層，能夠匯整所有的訊息到一個虛擬的通訊頻道

- 接口层: libdbus, 进程使用
- 总线层: dbus daemon, 系统启动时运行
- 包装层: Wrapper库



- session bus: 普通进程创建, 进程间消息传递
- system  bus: 引导时启动



- method calls: 触发对象的一个方法
- method returns: 返回触发的结果
- signals
- errors
---
typora-root-url: ..
title: 计算机网络复习
mathjax: true
date: 2020-03-11 20:52:39
tags:
categories:
	- 面试
---
![img](/images/tcp-and-http.jpg)

<!-- more -->

# 一. 传输层

## 1. OSI TCP/IP

OSI: 应表会 传 网 数物

TCP/IP: 应 传 网 网络接入

|  |  | 数据单位 |
| ------ | ---------------------- | ---- |
| 应用层       | 用户接口<br />应用程序 | 报文 |
| 运输层 | 进程间通用数据传输服务       | TCP报文段<br />UDP用户数据报 |
| 网络层 | 主机, 路由器 | 数据包 |
| 数据链路层 | 交换机 | 帧 |
| 物理层 |                        | 比特流 |

## 2. UDP和TCP

**用户数据报协议 UDP**（User Datagram Protocol）
无连接的，尽最大可能交付，没有拥塞控制
面向报文（对于应用程序传下来的报文不合并也不拆分，只是添加 UDP 首部）
支持一对一、一对多、多对一和多对多的交互通信
例如：视频传输、实时通信

![img](/images/udp-head2.png)

**传输控制协议 TCP**（Transmission Control Protocol）是面向连接的，提供可靠交付，有流量控制，拥塞控制，提供全双工通信，面向字节流（把应用层传下来的报文看成字节流，把字节流组织成大小不等的数据块），每一条 TCP 连接只能是点对点的（一对一）。

![img](/images/tcp-head.png)

- seq: 序号
- ack: 确认
- ACK: 确认
  - 第一次client向server请求时ack=0
  - TCP 规定, 在连接建立后所有传送的报文段都必须把 ACK 置 1
- syn: 同步
  - SYN=1，ACK=0: 连接请求报文段
  - SYN=1，ACK=1: 对方同意建立连接
- FIN: 终止
  - 当 FIN=1 时，表示此报文段的发送方的数据已发送完毕，并要求释放连接
  - 四次挥手时会出现在第1, 3次共两次


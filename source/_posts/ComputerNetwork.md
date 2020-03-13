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
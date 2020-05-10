---
typora-root-url: ..
title: os-tutorial
mathjax: true
date: 2020-05-08 17:00:21
tags:
categories:

---

![Operating System Concepts: What is an OS (/images/maxresdefault-1588928485317.jpg) - YouTube](https://i.ytimg.com/vi/ECfGOa_-nWQ/maxresdefault.jpg)

<!-- more -->

# 第0章、准备环境

1. Netwide Assembler （简称 NASM）是一款基于英特尔 x86 架构的汇编与反汇编工具。它可以用来编写16位、32位（IA-32）和64位（x86-64）的程序。
2. QEMU（quick emulator）是一款由Fabrice Bellard等人编写的免费的可执行硬件虚拟化的（hardware virtualization）开源托管虚拟机（VMM）。QEMU是一个托管的虚拟机镜像，它通过动态的二进制转换，模拟CPU，并且提供一组设备模型，使它能够运行多种未修改的客户机OS，可以通过与KVM（kernel-based virtual machine开源加速器）一起使用进而接近本地速度运行虚拟机（接近真实电脑的速度）。QEMU还可以为user-level的进程执行CPU仿真，进而允许了为一种架构编译的程序在另外一种架构上面运行（藉由VMM的形式）。

# 第1章、引导扇区

引导扇区用来加载操作系统，位于磁盘的第一个扇区，一共512字节的大小

512Bytes = 32行 * 16

```asm
; Infinite loop (e9 fd ff)
loop:
    jmp loop 

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
```

```bash
nasm 01_boot_sect_simple.asm -o out/01_boot_sect_simple.bin
```

```bash
qemu-system-x86_64 --curses out/01_boot_sect_simple.bin
```

![image-20200508172919926](/images/image-20200508172919926.png)

# 第2章、引导打印

AX 的低 8 位（0-7）构成了 AL 寄存器，高 8 位（8-15）构成了 AH 寄存器。它们是可以独立使用的 8 位寄存器。


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

# 第3章、引导内存

BIOS将引导程序放在内存地址$0x7c00$

这里引入了全局地址偏移

```asm
[org 0x7c00]
```

# 第4章、引导栈

`bp`寄存器存储栈的基地址

`sp`寄存器存储栈顶地址

`sp`从`bp`开始向下生长(递减)

```asm
mov ah, 0x0e ; tty mode

mov bp, 0x8000 ; this is an address far away from 0x7c00 so that we don't get overwritten
mov sp, bp ; if the stack is empty then sp points to bp

push 'A'
push 'B'
push 'C'

; to show how the stack grows downwards
mov al, [0x7ffe] ; 0x8000 - 2
int 0x10

; however, don't try to access [0x8000] now, because it won't work
; you can only access the stack top so, at this point, only 0x7ffe (look above)
mov al, [0x8000]
int 0x10


; recover our characters using the standard procedure: 'pop'
; We can only pop full words so we need an auxiliary register to manipulate
; the lower byte
pop bx
mov al, bl
int 0x10 ; prints C

pop bx
mov al, bl
int 0x10 ; prints B

pop bx
mov al, bl
int 0x10 ; prints A

; data that has been pop'd from the stack is garbage now
mov al, [0x8000]
int 0x10


jmp $
times 510-($-$$) db 0
dw 0xaa55
```

![image-20200513190333679](/images/image-20200513190333679.png)
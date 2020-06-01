---
typora-root-url: ..
title: Linux
mathjax: true
date: 2020-03-27 13:24:11
tags:
	- linux
categories:
	- linux

---

![image-20200327132800584](/images/image-20200327132800584.png)

<!-- more -->

# 文件

## sed

![image-20200327134335901](/images/image-20200327134335901.png)

1. `s`命令
   
   ```shell
   sed 's/book/books/' log.txt
   ```
   ![image-20200327175000793](/images/image-20200327175000793.png)
   
2. `s`命令, 只打印替换过的行

   1. `/p`打印处理过的行
   2. `-n`仅显示处理过后的结果

   ```shell
   sed -n 's/book/books/p' log.txt
   ```

   ![image-20200327175239965](/images/image-20200327175239965.png)

3. `/d`命令

   ```shell
   sed '/book/d' log.txt
   ```

   ![image-20200328204329353](/images/image-20200328204329353.png)

4. `&`指代已匹配的字符

   ```shell
   sed 's/book/&s/' log.txt
   ```

   ![image-20200328204704461](/images/image-20200328204704461.png)

5. `-e`多次执行

6. `a\`在匹配到的下一行追加

7. `i\`在匹配到的下一行追加

8. `;`
   ![image-20200328205528058](/images/image-20200328205528058.png)

9. 查看空格, tab

   ```shell
   sed -n l log.txt
   
   this is tab\tfinish.$
   this is several space      finish.$
   ```

## wc

![image-20200328205713393](/images/image-20200328205713393.png)

行数, 单词数, 字节数, 文件名

1. `l`行数
2. `w`单词数
3. `c`字符数

## cut

![image-20200328205911649](/images/image-20200328205911649.png)

1. 按字节`-b`, 按字符`-c`
   ![image-20200328210246954](/images/image-20200328210246954.png)

2. `-f`

   ```shell
   cat /etc/passwd | tail -n 5 | cut -d : -f 1,3
   ```

   ![image-20200328211104115](/images/image-20200328211104115.png)

## sort

1. `-o`指定文件名保存
2. `-f`忽略大小写
3. `-u`删除重复行
4. `-r`反向
5. `-R`乱序
6. `-t`分隔符, `-k`
7. `-n`按数值

## uniq

1. `-c`计数
2. `-d`只输出重复
3. `-u`只输出不重复
4. `-i`忽略大小写
5. `-f`跳过前n个域
6. `-s`跳过前n个字符

## awk

![image-20200328231743023](/images/image-20200328231743023.png)

1. `$0`当前行, `$n`第n个字段

2. `-F`指定分隔符

3. `-f`指定文件

4. 变量`NF`代表**字段数**

5. 变量`NR`代表**当前行数**

6. `{}`字符串使用**双引号**

   ```shell
   cat /etc/passwd | head -n 5 | awk -F ':' '{print $1", "$2}'
   ```

   ![image-20200328232600267](/images/image-20200328232600267.png)

7. `toupper()`, `tolower()`

8. 条件

   ```shell
   cat /etc/passwd | awk -F ':' 'NR % 2 == 1 {print $1}'
   ```

## tr

![image-20200329101542775](/images/image-20200329101542775.png)

1. 字符集1 替换为 字符集2

   ```shell
   cat words.txt | tr -s ' ' '\n'
   ```

## EXAMPLES

### 重复次数最多的5条命令

> 注意使用 `-n` 按数值排序

```shell
history | awk {'print $2'} | sort | uniq -c | sort -nr -k1,1 | head -n 5
```

### [192\. Word Frequency](https://leetcode.com/problems/word-frequency/)

Difficulty: **Medium**


Write a bash script to calculate the frequency of each word in a text file `words.txt`.

For simplicity sake, you may assume:

*   `words.txt` contains only lowercase characters and space `' '` characters.
*   Each word must consist of lowercase characters only.
*   Words are separated by one or more whitespace characters.

**Example:**

Assume that `words.txt` has the following content:

```
the day is sunny the the
the sunny is is
```

Your script should output the following, sorted by descending frequency:

```
the 4
is 3
sunny 2
day 1
```

**Note:**

*   Don't worry about handling ties, it is guaranteed that each word's frequency count is unique.
*   Could you write it in one-line using ?


#### Solution

Language: **Bash**

```bash
# Read from the file words.txt and output the word frequency list to stdout.
cat words.txt | tr -s ' ' '\n' | sort | uniq -c | sort -nr -k 1,1 | awk '{print $2" "$1}'
```

### [193\. Valid Phone Numbers](https://leetcode.com/problems/valid-phone-numbers/)

Difficulty: **Easy**


Given a text file `file.txt` that contains list of phone numbers (one per line), write a one liner bash script to print all valid phone numbers.

You may assume that a valid phone number must appear in one of the following two formats: (xxx) xxx-xxxx or xxx-xxx-xxxx. (x means a digit)

You may also assume each line in the text file must not contain leading or trailing white spaces.

**Example:**

Assume that `file.txt` has the following content:

```
987-123-4567
123 456 7890
(123) 456-7890
```

Your script should output the following valid phone numbers:

```
987-123-4567
(123) 456-7890
```


#### Solution

Language: **Bash**

```bash
# Read from the file file.txt and output all valid phone numbers to stdout.


cat file.txt | awk '/^[0-9][0-9][0-9]\-[0-9][0-9][0-9]\-[0-9][0-9][0-9][0-9]$/ || /^\([0-9][0-9][0-9]\) [0-9][0-9][0-9]\-[0-9][0-9][0-9][0-9]$/ {print $0}'
```

# 磁盘管理

## atime, mtime, ctime

1. Access: `cat`, `more`, `less`
2. Modify
3. Change
4. 只Change, 不Modify的情况: `mv`, `chrown`

## /etc/passwd

> 用户名:口令:用户标识号:组标识号:注释性描述:主目录:登录Shell

![image-20200329162801608](/images/image-20200329162801608.png)

# 进程管理

## ps

1. `a`: show processes for all users
2. `u`: display the process's owner
3. `x`: also show processes not attached to a terminal

## kill

1. `-1`, `HUP`: 中断终端
2. `-2`, `ctrl + c`
3. `-9`, `KILL`:强制终止
4. `-18`, `CONT`: 继续, 与19相反
5. `-19`, `STOP`, `ctrl + z`

# 网络
## tcpdump

![image-20200329232451133](/images/image-20200329232451133.png)

## netstat

![image-20200330092446608](/images/image-20200330092446608.png)

1. `-a`: 包含`LISTEN`的
2. `-t`: tcp
3. `-u`: udp
4. `-l`: 只包含`LISTEN`
5. `-s`: 各种协议的统计信息
6. `-p`: 显示连线的进程使用
7. `-n`: 不要解析dns
8. `-c`: 隔一秒输出一次

## lsof

![image-20200413190618816](/images/image-20200413190618816.png)

Linux 一切皆文件

1. `-u`: 某个用户打开的文件信息

2. `-c`: 某个程序打开的文件信息

3. `-i`: 网络连接

   1. 所有的tcp

      ```bash
      lsof -i tcp
      ```

   2. `:3306`: 按端口查找

      ```bash
      lsof -i :3306
      ```

4. `-p`: 通过进程号查找

## nc

![image-20200413211046821](/images/image-20200413211046821.png)

1. `-n`: 不适用dns, 直接使用ip
2. `-u`: 扫描udp, 默认是tcp

## tcpdump

![image-20200413212845206](/images/image-20200413212845206.png)

1. 监听指定的host

   ```bash
   tcpdump host 210.27.48.1
   ```

2. 监听本机udp且端口为123

   ```bash
   tcpdump udp port 123
   ```

## telnet

1. 查看端口是否开放

   ```bash
   telnet chunibyo.xyz 22
   ```

## whois

1. 查看域名信息

   ```bash
   whois chunibyo.xyz
   ```

## traceroute

```bash
traceroute www.baidu.com
```

1. `-m`限制跳数

## mtr

ping+traceroute

## iptables

1. 4个表
   1. nat(状态转换表)
   2. filter(数据过滤表)
   3. raw(状态跟踪表)
   4. mangle(包标记表)
2. 内置链
   1. input(入站)
   2. output(出站)
   3. forward(转发)
   4. prerouting(路由前)
   5. postrouting(路由后)
3. `-t`: 指定表名`-t filter`
4. `-A`: 给链追加  规则`-A INPUT`
5. `-p`: 指定协议名`-p tcp`
6. `-j`: option `-j DROP`
7. `--dport`: 指定端口 `--dport 8081`

![img](/images/4WFXrnn2.png)

1. 重置已有规则

   ```bash
   iptables -X
   ```

2. 拒绝所有input流量
   
   ```bash
   iptables -P INPUT DROP
   ```
   
3. DNAT(Destination Network Address Translation): 目的地址转换

4. SNAT(Source Network Address Translation)： 源地址转换

#  怕其他

## gdb

1. `g++ -g`: Produce debugging information in the operating system's native format (stabs, COFF, XCOFF, or DWARF).  GDB can work with this debugging information.
2. `run`: `r` 断点处停止
3. `next`: 单步运行, 不进入函数
4. `step`: 单步运行, 进入函数
5. `break/delete n`: 第n行设置/删除断点
6. `enable/disable n`: 第n行开启/暂停断点
7. `list`
8. `print`
9. `watch`: 监视的表达式值变化, 停止程序

# 二、主机规划与磁盘分区

## 2.2 磁盘分区

磁盘(按照政策顺序) /dev/sd[a-p]

分区: primary, extend

MBR(master boot recoder): 主要开机记录区, 安装开机管理程序的地方

### 2.2.3 BIOS 和 UEFI

固件: 写到硬件上的一个软件程序

BIOS: 计算机主动执行的第一个程序

开机到操作系统前的流程:

1. BIOS：开机主动执行的固件，会认识第一个可开机的设备；
2. MBR：第一个可开机设备的第一个扇区内的主要开机记录区块，内含开机管理程序；
3. 开机管理程序（boot loader）：一支可读取核心文件来执行的软件；
4. 核心文件：开始操作系统的功能...

### 2.2.4 挂载

![image-20200501150200802](/images/image-20200501150200802.png)

# 五、Linux文件权限与目录配置

## 5.1使用者与群组

## 5.2Linux文件权限概念

### 5.2.1 Linux文件属性

![image-20200502183915853](/images/image-20200502183915853.png)

1. 文件拥有者可具备的权限
2. 加入此群组之帐号的权限
3. 非本人且没有加入本群组之其他帐号的权限

### 5.2.2 改变文件属性和权限

1. chgrp: 改变文件所属群组

   ```bash
   chgrp [group name] [file name]
   ```

2. chown: 改变文件拥有者

   ```bash
   chown [user name]:[group name] [file name]
   ```

3. chmod: 改变文件权限

   1. `u,g,o`三种身份权限
   2. +（加入） -（除去） =（设置）

### 5.2.3 权限对目录的意义

|      | 内容     | r          | w          | x                |
| ---- | -------- | ---------- | ---------- | ---------------- |
| 文件 | 详细数据 | 读文件内容 | 写文件内容 | 执行文件内容     |
| 目录 | 文件名   | 读文件名   | 修改文件名 | 进入该目录的权限 |

## 5.3 目录配置

### 5.3.1 Filesystem Hierarchy Stantard

可分享的，不可分享的，不变的，可变的

根目录(/)所在分区越小越好，且应用程序安装的软件最好不要与根目录放在同一个分区内

1. `/bin`: 单人维护模式下还能执行的命令
2. `/boot`: 
   1. Linux核心文件
   2. 开机菜单
   3. 开机所需配置文件
3. `/dev`: 外设
4. `/etc`: 系统配置文件
   1. `/etc/modprobe.d/`模块装载时的配置文件
   2. `/etc/passwd`
   3. `/etc/fstab`系统挂载
5. `/lib`: 
   1. 开机使用的函数库
   2. `/bin`和`/sbin`指令调用的函数库
6. `/media`: 媒体
7. `/mnt`: 暂时挂载额外设备
8. `/opt`: 第三方协力软件
9. `/run`: 开机后所产生的各项信息
10. `/sbin`: 开机过程需要的，包括了开机、修复和还原系统需要的指令
11. `/srv`: service缩写，网络服务启动后的数据目录，比如WWW，FTP
12. `/usr`: Unix操作系统软件资源，可分享的和不可变动的FHS建议
    所有软件开发者，应该将他们的数据合理的分别放置到这个目录下的次目录，而不要自行创建该软件自己独立的目录。
    1. `/usr/bin`: 系统可执行命令的主要目录
    2. `/usr/lib`: 
    3. `/usr/local`: 自行安装, 非distribution默认
    4. `/usr/sbin`: 非系统正常运行需要的指令
    5. `/usr/share`
13. `/var`: 主要针对常态性变动的文件，包括高速缓存（cache）、登录文件（log file）以及某些软件运行所产生的文件， 包括程序文件（lock file,run file），或者例如MySQL数据库的文件
    1. `/var/cache`: 程序本身运行过程中的暂存盘
    2. `/var/lib`: 程序执行过程中需要用到的数据文件放置目录
    3. `/var/lock`: 确保某些文件或者硬件只会给单一软件使用
    4. `/var/log`: 登陆文件目录
       1. `/var/log/wtmp`: last命令
    5. `/var/run`: 程序和服务的PID
14. `/home`
15. `/liv64`: 与`/lib`不同格式的二进制函数库
16. `/root`: 系统管理员的主文件夹
17. `/lost+found`
18. `/proc`: 虚拟文件系统，放置的数据在内存中
    1. `/proc/cpuinfo`
    2. `/proc/interrupts`: 中断
    3. `/proc/meminfo`
    4. `/proc/swaps`
    5. `/proc/version`: 内核版本
       ![image-20200503195501112](/images/image-20200503195501112.png)
    6. `/proc/mounts`
19. `/sys`

### 5.3.2 目录树

![image-20200503205640075](/images/image-20200503205640075.png)

###### 六、Linux文件与目录管理

1. `pwd -P`: 显示确实的路径，也就是link目录的原目录
   ![image-20200504191255979](/images/image-20200504191255979.png)
2. `mkdir -m 711 test2`: 设置文件权限
3. 
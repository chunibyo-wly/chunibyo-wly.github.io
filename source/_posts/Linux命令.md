---
typora-root-url: ..
title: Linux命令
mathjax: true
date: 2020-03-27 13:24:11
tags:
	- linux
categories:
	- 面试

---

![image-20200327132800584](/images/image-20200327132800584.png)

<!-- more -->

# 文件

## 文件的处理

### sed

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


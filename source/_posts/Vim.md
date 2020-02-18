---
typora-root-url: ..
title: Vim
mathjax: true
date: 2020-02-17 16:06:50
tags:
categories:
---
![「vim」的圖片搜尋結果](/images/mode.png)

<!-- more -->

1. 重复输入3次go `3igo<Esc>`
   1. `3`: 声明次数
   2. `i`: 进入`insert mode`
   3. `go`: 文本
   4. `<Esc>`: 退出`insert mode`
2. 寻找第4次出现的q `4fq`
3. 跳转到与光标所在`word`的上/下一个
   1. `*`: 前
   2. `#`: 后
4. `s` = `x` + `i`
5. 重复上一次的操作 `.`
6. `dk`: 删除当前行和上一行
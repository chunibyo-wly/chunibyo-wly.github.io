---
typora-root-url: ..
title: codewars URLshortener
mathjax: true
date: 2021-01-16 13:42:06
Tags: codewars
categories: codewars

---

![CodeWars - HackMD](data:image/jpeg;base64,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)

<!-- more -->

[URL shortener](https://www.codewars.com/kata/5fee4559135609002c1a1841)

题目要求：

1. 475,000个测试用例
2. 只能使用 26 个小写字母
3. 短链长度为 4

有两种思路：
## 1. index转26进制

令$a=0$, 此时除0的情况外, a不能出现在首位, 长度为4的26进制的情况数有
$$
25*26^3+25*26^2+25*26^1+26 = 456976 < 475000
$$

## 2. index与可重复全排列双射

此时a没有数学意义，可以出现在首位，所以情况数为
$$
26^4+26^3+26^2+26=475254>475000
$$
这里在参考康托展开和逆康托展开就可以得到index和short url之间的转化关系

```python
base = 26
BASE = [0]
index = 0
table = [""]
hash_table = {}


def init():
    for i in range(6):
        BASE.append(BASE[len(BASE)-1]+base**i)


def get_N(x):
    for i in range(len(BASE)):
        if BASE[i] <= x and BASE[i+1] > x:
            return i


def cantor(x):
    # short to index
    result = 0
    for i in range(len(x)):
        result += (ord(x[i])-ord('a')) * base**(len(x) - i - 1)
    return result + BASE[len(x)]


def re_cantor(x):
    # index to short
    n = get_N(x)
    x -= BASE[n]
    result = ""
    for i in range(n):
        tmp = x // (base ** (n-i-1))
        result = result + chr(ord('a') + tmp)
        x -= tmp * (base ** (n-i-1))
    return result


init()


def url_shortener(long_url):
    global index
    if long_url not in hash_table:
        index = index + 1
        table.append(long_url)
        short_url = re_cantor(index)
        hash_table[long_url] = short_url
    else:
        print(long_url)
        short_url = hash_table[long_url]
    return 'short.ly/'+short_url

def url_redirector(short_url):
    long_url = table[cantor(short_url[9:])]
    return long_url
```


---
typora-root-url: ..
title: Http请求
mathjax: true
date: 2020-05-17 22:33:16
tags:
	- 前端
categories:
	- web
	- 前端
---

![image-20210114184506332](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114184506332.png)

<!-- more -->

# 1. [Http的参数](https://alanli7991.github.io/2016/10/26/HTTP%E8%AF%B7%E6%B1%82GETPOST%E4%B8%8E%E5%8F%82%E6%95%B0%E5%B0%8F%E7%BB%93/)

## 1.1 URL放入参数

```
http://{{host}}:{{port}}/api/file_list?path=/
```

![image-20200518085221454](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20200518085221454.png)

```json
var settings = {
    "url": "http://localhost:8888/api/url?KEY=VALUE",
    "method": "GET",
    "timeout": 0,
};

$.ajax(settings).done(function (response) {
    console.log(response);
});
```

```python
@app.route('/api/url', methods=['GET'])
def get_url():
    return request.args.get("KEY")
```



## 1.2 Body放入参数

### 1.2.1 text/plain文本传输

`Content-type: text/plain`

![image-20210114185348013](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114185348013.png)

```javascript
var settings = {
    "url": "http://localhost:8888/api/textplain",
    "method": "GET",
    "timeout": 0,
    "headers": {
        "Content-Type": "text/plain"
    },
    "data": "textplain\ndata\ntest",
};

$.ajax(settings).done(function (response) {
    console.log(response);
});
```



```python
@app.route('/api/textplain', methods=['GET'])
def get_textplain():
    return request.data
```

### 1.2.2 application参数传输

#### 1.2.2.1 Form表单

`Content-type: application/x-www-form-urlencoded`

![image-20210114185411578](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114185411578.png)

```javascript
var settings = {
    "url": "http://localhost:8888/api/form",
    "method": "GET",
    "timeout": 0,
    "headers": {
        "Content-Type": "application/x-www-form-urlencoded"
    },
    "data": {
        "KEY": "VALUE"
    }
};

$.ajax(settings).done(function (response) {
    console.log(response);
});
```

```python
@app.route('/api/form', methods=['GET'])
def get_form():
    return request.form["KEY"]
```

#### 1.2.2.2 JSON Object

![image-20210114185430773](https://raw.githubusercontent.com/chunibyo-wly/image-storage/master/image-20210114185430773.png)

```javascript
var settings = {
    "url": "http://localhost:8888/api/json",
    "method": "GET",
    "timeout": 0,
    "headers": {
        "Content-Type": "application/json"
    },
    "data": JSON.stringify({"KEY":"VALUE"}),
};

$.ajax(settings).done(function (response) {
    console.log(response);
});
```

```python
@app.route('/api/json', methods=['GET'])
def get_json():
    return request.json["KEY"]
```

## 1.3 总结

通常情况下x-www-form-urlencoded是最常用的传参方法

# 2. 测试方法

## 2.1 后端

postman 如上

## 2.2 前端

postman mock server + [fiddler](https://medium.com/@rajsek/use-fiddler-in-ubuntu-82b1dfd80848)
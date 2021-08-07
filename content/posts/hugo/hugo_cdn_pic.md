---
title: "Github + jsDelivr CDN  托管（文件、图片）"
subtitle: ""
date: 2021-08-07T08:45:57+08:00
lastmod: 2021-08-07T08:45:57+08:00
draft: true
author: ""
authorLink: ""
description: ""

tags: [搭建文件CDN]
categories: [hugo]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: true
math:
  enable: false
lightgallery: false
license: ""
---
### github 创建仓库 
```
公共仓库 项目名称cdn
```
### 本地下载仓库操作
```
git clone 项目仓库地址
```
 ![截图](https://cdn.jsdelivr.net/gh/justkids2018/cdn@1.0.1/tool/hugo-cdn-img.png) 

### 上次文件或者图片
```
git add .
git commit -m "first file"
git push origin feature(定义的分支)
```
github 发布release 版本 **（可进行版本控制，方便迭代）**
### 通过JsDelivr  引用资源

> jsDelivr [开源的CDN简介](https://www.jsdelivr.com/?docs=gh)

**JsDeliver 引用参数说明**
```
引用方式：
https://cdn.jsdelivr.net/gh/你的用户名/你的仓库名@发布的版本号/文件路径

// 使用特定版本
https://cdn.jsdelivr.net/gh/justkids2018/cdn@1.1.10/test.js   

// 使用版本范围而不是特定版本
https://cdn.jsdelivr.net/gh/justkids2018/cdn@1.0/test.js   

// 增加 ".min" to any JS/CSS file to get a minified version
//if one doesn't exist, we'll generate it for you

https://cdn.jsdelivr.net/gh/justkids2018/cdn@1.0/test.
min.js   
 
// 完全省略该版本以获取最新版本
https://cdn.jsdelivr.net/gh/justkids2018/cdn/test.js

 // 在末尾添加 / 以获取资源目录列表
https://cdn.jsdelivr.net/gh/justkids2018/cdn/
```

<!--more-->

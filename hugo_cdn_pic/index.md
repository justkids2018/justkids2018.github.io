# Github + jsDelivr+picGO CDN  托管（文件、图片）

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

### 增加picGO 的使用方式
[下载picgo软件](https://github.com/Molunerfinn/PicGo)
```
mac os:
brew  install picgo --cask
```
2、github上设置tocken设置参数

![](https://cdn.jsdelivr.net/gh/justkids2018/cdn@main/tool/bbb.PNG)

3、设置 picgo的具体参数配置：[借鉴文章](https://www.jianshu.com/p/9d91355e8418)

4、 **上传图片 踩到的坑** 
```
1、github 最新创建分支默认是main 分支，不再是master 分支
2、picgo 配置自定义域名后缀不加上分支，无法打开上传图片链接（耗费我大半天）郁闷
     1）https://cdn.jsdelivr.net/gh/justkids2018/cdn@分支/
     2）另一方式：就是增加版本号 （需要每次都发布reales版本）
       https://cdn.jsdelivr.net/gh/justkids2018/cdn@version/
```

[参考方案](https://blog.csdn.net/shuimqs/article/details/109179005)

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


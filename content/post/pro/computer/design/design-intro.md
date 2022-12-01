---
title: "设计模式-原则"
subtitle: "设计模式原则和分类"
date: 2022-12-01 
lastmod: 2022-12-01 
draft: false
author: ""
authorLink: ""
description: ""

tags: [DesignPattern]
categories: [Framework]

hiddenFromHomePage: true
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

## 设计6大原则

### 开闭原则(Open Close Principle)

软件实体（模块、类、方法等）应该<FONT COLOR=RED>"对扩展开放、对修改关闭"</FONT>.
**最基础，最重要的原则**

从定义上看，这个原则主要包含两部分:
**1 对扩展开放**
 
   这意味着模块的行为是可以扩展的。当应用程序的需求改变时，我们可以对其模块进行扩展，使其具有满足那些需求变更的新行为。换句话说，我们可以改变模块的功能。

**2 对修改关闭**

“对模块行为进行扩展时，不必改动该模块的源代码或二进制代码。模块的二进制可执行版本，无论是可链接的库、DLL或Java的.jar文件，都无需改动



##  模式划分3种类型
* 1、行为型
* 2、结构型
* 3、创建型
   
**常用模型:** <FONT COLOR="RED">红色标记</font>
###  创建型模式
 共五种:
    工厂方法模式、抽象工厂模式、单例模式、<FONT COLOR="RED">建造者模式、</FONT>原型模式。

### 结构型模式
共七种:
外观模式、<FONT COLOR="RED">适配器模式、装饰器模式、代理模式、桥接模式、组合模式、享元模式</FONT>

### 行为型模式
共十一种:
模板方法模式、<FONT COLOR="RED">策略模式、观察者模式、迭代子模式、责任链模式、命令模式</FONT>、备忘录模式、状态模式、访问者模式、中介者模式、解释器模式。




## 参考资料
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)
 [常用结构性模型](https://www.jianshu.com/p/b2c08a670299)

 <!--more-->
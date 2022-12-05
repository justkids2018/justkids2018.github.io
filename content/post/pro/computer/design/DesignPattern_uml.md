---
title: "设计模式-1-UML"
subtitle: ""
date: 2022-12-01 
lastmod: 2022-12-01 
draft: false
author: "qsd"
authorLink: ""
description: "设计模式-UML基础"

tags: [DesignPattern]
categories: [Framework]

hiddenFromHomePage: false
hiddenFromSearch: false

featuredImage: ""
featuredImagePreview: ""

toc:
  enable: false
math:
  enable: false
lightgallery: true
license: ""
---

## 设计模式-UML 基础知识

### 1、什么是UML图
即Unified Modeling Language，翻译为：统一建模语言。是用来对软件密集系统进行可视化建模的一种语言。一份典型的建模图表通常包含几个块或框，连接线和作为模型附加信息之用的文本。这些虽简单却非常重要，在UML规则中相互联系和扩展。

UML立足于对事物的实体、性质、关系、结构、状态和动态变化过程的全程描述和反映。UML可以从不同角度描述人们所观察到的软件视图，也可以描述在不同开发阶段中的软件的形态

UML采用一组图形符号来描述软件模型，这些图形符号具有简单、直观和规范的特点，开发人员学习和掌握起来比较简单。所描述的软件模型，可以直观地理解和阅读，由于具有规范性，所以能够保证模型的准确、一致

### 2、 UML图的作用

UML是一个通用的标准建模语言，
可以对任何具有静态结构和动态行为的系统进行建模，而且适用于系统开发的不同阶段，从需求规格描述直至系统完成后的测试和维护。

### 3、UML 的类图关系

类图的6种关系:
```
实现（Realization）、泛化（Generalization）
关联（Association）、聚合（Aggregation）
组合(Composition)、依赖(Dependency)
```

<IMG SRC="https://i.loli.net/2019/08/06/ysxabt1DfXLoBKj.png">

----
#### 3.1 实现关系（Realization）

实现关系：使用的是一个**带空心箭头的虚线**表示。
 
 <IMG SRC="https://www.likecs.com/default/index/img?u=aHR0cHM6Ly9pbWFnZXMyMDE3LmNuYmxvZ3MuY29tL2Jsb2cvMTIyNzMzMS8yMDE3MDkvMTIyNzMzMS0yMDE3MDkxODEwMDEwOTA3MS04ODIyMTg2MjQucG5n">

上述类图我们可以说A实现了B，B是一个抽象概念，
在现实中无法直接用来定义对象，只有指明具体的子类，才能用来定义对象.

#### 3.2 泛化关系

泛化关系:实际上是对类的一个细分，
(转)看懂类图——UML类图基础

<IMG SRC="https://www.likecs.com/default/index/img?u=aHR0cHM6Ly9pbWFnZXMyMDE3LmNuYmxvZ3MuY29tL2Jsb2cvMTIyNzMzMS8yMDE3MDkvMTIyNzMzMS0yMDE3MDkxODEwMDkxNTQ5My0yMDA3NjEyMjk0LnBuZw==">

最终代码中，泛化关系表现为继承非抽象类；

#### 3.3 聚合关系

聚合关系：
整体与部分之间是弱依赖关系，整体不存在了，部分依然可以独立存在，也就是说部分和整体的生命周期是独立的。
聚合关系在UML中使用带空心菱形的实线表示

<IMG SRC="https://www.likecs.com/default/index/img?u=aHR0cHM6Ly9pbWFnZXMyMDE3LmNuYmxvZ3MuY29tL2Jsb2cvMTIyNzMzMS8yMDE3MDkvMTIyNzMzMS0yMDE3MDkxODEwMjAzNjA4Ny0yMDc2ODkwOTg5LnBuZw==">

例如班级不存在了，学生仍然能够单独存在

#### 3.4 组合关系

组合关系：
整体与部分之间是强依赖关系，
整体不存在了，部分也就不存在了。例如公司与部门之间的关系
组合关系在UML中使用实心菱形的实线表示
(转)看懂类图——UML类图基础

<IMG SRC="https://www.likecs.com/default/index/img?u=aHR0cHM6Ly9pbWFnZXMyMDE3LmNuYmxvZ3MuY29tL2Jsb2cvMTIyNzMzMS8yMDE3MDkvMTIyNzMzMS0yMDE3MDkxODEwNDcwMzIyOC04ODY2NDk4NDgucG5n">

#### 3.5 关联关系

关联关系:是用一条直线表示的；它描述不同类的对象之间的结构关系；
它是一种静态关系， 通常与运行状态无关，一般由常识等因素决定的。
它一般用来定义对象之间静态的、天然的结构。 所以，关联关系是一种“强关联”的关系；
比如，乘车人和车票之间就是一种关联关系
关联关系默认不强调方向，表示对象间相互知道；如果特别强调方向，如下图，表示A知道B，但 B不知道A，如下图
(转)看懂类图——UML类图基础
<IMG SRC="https://www.likecs.com/default/index/img?u=aHR0cHM6Ly9pbWFnZXMyMDE3LmNuYmxvZ3MuY29tL2Jsb2cvMTIyNzMzMS8yMDE3MDkvMTIyNzMzMS0yMDE3MDkxODEwNTAyMzQ3OC0xMjU0MDk1NDM0LnBuZw==">

注：在最终代码中，关联对象通常是以成员变量的形式实现的；

#### 3.6 依赖关系
依赖关系是用一套带箭头的虚线表示的

如下图表示A依赖于B；它描述一个对象在运行期间会用到另一个对象的关系；
(转)看懂类图——UML类图基础
<IMG SRC="https://www.likecs.com/default/index/img?u=aHR0cHM6Ly9pbWFnZXMyMDE3LmNuYmxvZ3MuY29tL2Jsb2cvMTIyNzMzMS8yMDE3MDkvMTIyNzMzMS0yMDE3MDkxODEwNTMwNTA4Ny02NTQ0Nzg4My5wbmc=">

显然，依赖也有方向，双向依赖是一种非常糟糕的结构，我们总是应该保持单向依赖，杜绝双向依赖的产生.

在最终代码中，依赖关系体现为类构造方法及类方法的传入参数，箭头的指向为调用关系；依赖关系除了临时知道对方外，还“使用”对方的方法和属性.




### 参考资料
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)
 [设计模式-视频](https://www.bilibili.com/video/BV1gJ411X7uN?p=27&vd_source=7c47b6d72612787b009ac686785b509a)
 
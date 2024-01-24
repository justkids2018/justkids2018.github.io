---
title: "设计模式-抽象工厂模式"
subtitle: "创建型"
date: 2022-12-01 
lastmod: 2022-12-01 
draft: false
author: "qsd"
authorLink: ""
description: ""

tags: [设计模式]
categories: [DesignPattern]

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

### 1、模式
#### 1、模式类型：
    创建型
#### 2、定义：
抽象工厂模式（Abstract Factory Pattern）是围绕一个超级工厂创建其他工厂。该超级工厂又称为其他工厂的工厂。这种类型的设计模式属于创建型模式，它提供了一种创建对象的最佳方式。
#### 3、原理类图
<img src="img/dp-create-abstractFactory.jpeg">

#### 4、工作原理
```
抽象工厂模式包含以下几个核心角色：

抽象工厂（Abstract Factory）：声明了一组用于创建产品对象的方法，每个方法对应一种产品类型。抽象工厂可以是接口或抽象类。
具体工厂（Concrete Factory）：实现了抽象工厂接口，负责创建具体产品对象的实例。
抽象产品（Abstract Product）：定义了一组产品对象的共同接口或抽象类，描述了产品对象的公共方法。
具体产品（Concrete Product）：实现了抽象产品接口，定义了具体产品的特定行为和属性。
```

### 2、实例：

### 3、注意事项

优点：
```
封装性：抽象工厂模式将对象的创建封装在一个工厂类中，客户端只需要与工厂类进行交互，而无需了解具体对象的创建过程，从而实现了代码的封装性。
可替换性：通过抽象工厂接口，可以轻松地替换具体的工厂类以创建不同系列的对象，而不会对客户端代码造成影响，提供了系统的灵活性和可扩展性。
产品一致性：抽象工厂模式确保了一系列相关对象的一致性，因为它们是由同一个工厂创建的，保证了这些对象之间的兼容性和互操作性。
```
缺点：
```
扩展困难：当需要增加新的产品系列时，需要修改抽象工厂的接口和所有的具体工厂类，违反了开闭原则，可能会导致系统的稳定性受到影响。
类的个数增加：每个具体工厂类只能创建一种系列的产品，如果系统需要创建更多的产品系列，就需要增加新的具体工厂类，这会增加系统中类的个数，增加了代码的复杂性。
产品族扩展困难：当需要增加新的产品族时，除了新增具体产品类外，还需要修改抽象工厂的接口和所有的具体工厂类，违反了开闭原则。
```
### 4、应用场景
```

```






   




### 参考资料
 [设计模式-创建](https://www.runoob.com/design-pattern/abstract-factory-pattern.html)</BR>

 <!--more-->
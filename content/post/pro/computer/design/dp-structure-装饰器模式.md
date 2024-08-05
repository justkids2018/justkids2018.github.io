---
title: "设计模式-结构-装饰器模式"
subtitle: "结构型"
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

##  装饰器模式

### 模式类型：
    
	结构型

### 定义：装饰器模式（Decorator Pattern）

<font color=red>装饰器模式（Decorator Pattern）是一种结构型设计模式，它允许你动态地给对象添加新的功能，而不改变其结构。</FONT>这种模式创建了一个装饰类，用来包装原始类，并在保持类接口完整的同时，提供额外的功能。装器(Wrapper)


### 工作原理
```
	•	动态扩展功能：可以在运行时添加或删除功能。
	•	组合而非继承：使用组合的方式添加功能，而不是通过继承。
	•	透明性：客户端无需知道对象是否被装饰，可以透明地使用。

```
#### 2、原理uml图

1、结构

	1.	组件接口（Component）：定义对象的接口。
	2.	具体组件（ConcreteComponent）：实现组件接口的类。
	3.	装饰器类（Decorator）：实现组件接口，并持有一个组件对象的引用。
	4.	具体装饰器（ConcreteDecorator）：继承装饰器类，并添加新的功能。


### 实例：
```

// 基础接口
public interface IceCream {
    String getDescription();
    double cost();
}

// 基本实现：香草冰淇淋
public class VanillaIceCream implements IceCream {
    public String getDescription() {
        return "Vanilla Ice Cream";
    }

    public double cost() {
        return 1.0; // 基本冰淇淋的价格
    }
}

// 装饰器基类
public abstract class IceCreamDecorator implements IceCream {
    protected IceCream decoratedIceCream;

    public IceCreamDecorator(IceCream iceCream) {
        this.decoratedIceCream = iceCream;
    }

    public String getDescription() {
        return decoratedIceCream.getDescription();
    }

    public double cost() {
        return decoratedIceCream.cost();
    }
}

// 巧克力酱装饰器
public class ChocolateSauceDecorator extends IceCreamDecorator {
    public ChocolateSauceDecorator(IceCream iceCream) {
        super(iceCream);
    }

    public String getDescription() {
        return decoratedIceCream.getDescription() + ", Chocolate Sauce";
    }

    public double cost() {
        return decoratedIceCream.cost() + 0.5; // 巧克力酱的价格
    }
}

// 坚果装饰器
public class NutsDecorator extends IceCreamDecorator {
    public NutsDecorator(IceCream iceCream) {
        super(iceCream);
    }

    public String getDescription() {
        return decoratedIceCream.getDescription() + ", Nuts";
    }

    public double cost() {
        return decoratedIceCream.cost() + 0.7; // 坚果的价格
    }
}

public class Main {
    public static void main(String[] args) {
        // 创建一个基本的香草冰淇淋
        IceCream iceCream = new VanillaIceCream();
        System.out.println(iceCream.getDescription() + " $" + iceCream.cost());

        // 添加巧克力酱
        iceCream = new ChocolateSauceDecorator(iceCream);
        System.out.println(iceCream.getDescription() + " $" + iceCream.cost());

        // 再添加坚果
        iceCream = new NutsDecorator(iceCream);
        System.out.println(iceCream.getDescription() + " $" + iceCream.cost());
    }
}

```


#### 4、应用场景
```
1、咖啡里加糖 加牛奶
2、JDK 中  输入/输出流
```






   




### 参考资料
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)</BR>
 [常用结构性模型](https://www.jianshu.com/p/b2c08a670299)

 [设计模式-视频讲解](https://www.bilibili.com/video/BV1G4411c7N4?p=6&vd_source=7c47b6d72612787b009ac686785b509a)

 [设计模式-原则](https://github-yuteng.github.io/2019/08/01/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%83%E5%A4%A7%E5%8E%9F%E5%88%99/)
 <!--more-->
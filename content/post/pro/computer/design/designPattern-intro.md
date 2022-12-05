---
title: "设计模式-六原则"
subtitle: "设计模式原则和分类"
date: 2022-12-01 
lastmod: 2022-12-01 
draft: false
author: "qsd"
authorLink: ""
description: "设计模式原则和分类"

tags: []
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

## 设计6大原则

### 一、开闭原则(Open Close Principle)

软件实体（模块、类、方法等）应该<FONT COLOR=RED>"对扩展开放、对修改关闭"</FONT>.
**最基础，最重要的原则**

从定义上看，这个原则主要包含两部分:
**1 对扩展开放**
 
   这意味着模块的行为是可以扩展的。当应用程序的需求改变时，我们可以对其模块进行扩展，使其具有满足那些需求变更的新行为。换句话说，我们可以改变模块的功能。

**2 对修改关闭**

“对模块行为进行扩展时，不必改动该模块的源代码或二进制代码。模块的二进制可执行版本，无论是可链接的库、DLL或Java的.jar文件，都无需改动

-- --
### 一、单一原则(Single responsibility)

**单一职责原则注意事项和细节：**

1、降低类的复杂度，一个类只负责一项职责；
2、提高类的可读性，可维护性；
3、降低变更引起的风险;
4、通常情况下，应当遵守单一职责原则， **只有逻辑足够简单，才可以在方法级违反单一职责原则**。

```
/**
 * @author 
 * 只有类中方法数量足够少，可以在方法级别保持单一职责原则
 */
public class SingleResponsility {
    public static void main(String[] args) {
        Vehicle vehicle = new Vehicle();
        vehicle.run("布加迪威龙");
        vehicle.fly("波音747");
    }
}

// 逻辑简单，方法级别实现单一职责
// 逻辑复杂，分类实现单一职责
class Vehicle {

    public void run(String string) {
        System.out.println(string + "：是陆地交通工具");
    }

    public void fly(String string) {
        System.out.println(string + "：是空中交通工具");
    }
}
```

### 二、接口隔离原则（Interface Segregation）

**2.1 介绍**

客户端不应该依赖它不需要的接口，即**一个类对另一个类的依赖应该建立在最小的接口上**


 
 **2.2 不符合设计模式UML**
 <IMG SRC="https://img-blog.csdnimg.cn/4ef0a747466f4c2ab2a2949fec9a4729.png#pic_center">
分析：

​ 1）类A通过接口Interface1依赖类B，类C通过 接口Interface1依赖类D，如果接口 Interface1对于类A和类C来说不是最小接口， 那么类B和类D必须去实现他们不需要的方法。

​ 2）按隔离原则应当这样处理

​ 将接口Interface1拆分为独立的几个接口， 类A和类C分别与他们需要的接口建立依赖关系。也就是采用接口隔离原则

**2.3 接口隔离模式UML**

应传统方法的问题和使用接口隔离原则改进
* 1、类A通过接口 Interface1、2 依赖类B，类C通过接口   Interface1、 3 依赖类D，如果接口 Interface 对于 类A 和 类C 来说不是最小接口，那么 类B 和 类D 必须去实现他们不需要的方法。
* 2、将接口 Interface 拆分为独立的几个接口，类A 和 类C 分别与他们需要的接口建立依赖关系。也就是采用接口隔离原则。
* 3、接口 Interface 中出现的方法，根据实际情祝拆分为三个接口。

<IMG SRC="https://img-blog.csdnimg.cn/e978714a00cb4ef688dee2d52a2a8e17.png#pic_center">

代码
```
public class InterfaceSegregation {
    public static void main(String[] args) {
        A a = new A();
        a.depend1(new B());
        a.depend2(new B());
        a.depend3(new B());

        C c = new C();
        c.depend1(new D());
        c.depend4(new D());
        c.depend5(new D());
    }
}

interface interface1 {
    void Operation1();
}

interface interface2 {
    void Operation2();

    void Operation3();
}

interface interface3 {
    void Operation4();

    void Operation5();
}

class B implements interface1, interface2 {

    @Override
    public void Operation1() {
        System.out.println("B 实现了 Operation1");
    }

    @Override
    public void Operation2() {
        System.out.println("B 实现了 Operation2");
    }

    @Override
    public void Operation3() {
        System.out.println("B 实现了 Operation3");
    }
}

class D implements interface1, interface3 {

    @Override
    public void Operation1() {
        System.out.println("D 实现了 Operation1");
    }

    @Override
    public void Operation4() {
        System.out.println("D 实现了 Operation4");
    }

    @Override
    public void Operation5() {
        System.out.println("D 实现了 Operation5");
    }
}

class A {

    public void depend1(interface1 i) {
        i.Operation1();
    }

    public void depend2(interface2 i) {
        i.Operation2();
    }

    public void depend3(interface2 i) {
        i.Operation3();
    }
}

class C {

    public void depend1(interface1 i) {
        i.Operation1();
    }

    public void depend4(interface3 i) {
        i.Operation4();
    }

    public void depend5(interface3 i) {
        i.Operation5();
    }
}
```

-- --

### 三、依赖倒转原则（Dependence Inversion）

#### 3.1 基本介绍

​ 1) 高层模块不应该依赖低层模块，二者都应该依赖其抽象

​ 2) **抽象不应该依赖细节，细节应该依赖抽象**

​ 3) 依赖倒转(倒置)的中心思想是面向接口编程

​ 4) 依赖倒转原则是基于这样的设计理念：
    相对于细节的多变性，抽象的东西要稳定的多。以抽象为基础搭建的架构比以细节为基础的架构要稳定的多。在java中，抽象指的是接口或抽象类，细节就是具体的实现类

​ 5) 使用接口或抽象类的目的是制定好规范，而不涉及任何具体的操作，把展现细节的任务交给他们的实现类去完成

#### 3.2、依赖倒转原则注意事项和细节
​ 1) 低层模块尽量都要有抽象类或接口，或者两者都有，程序稳定性更好

​ 2) 变量的声明类型尽量是抽象类或接口, 这样我们的变量引用和实际对象间，就存在 一个缓冲层，利于程序扩展和优化

​ 3) 继承时遵循里氏替换原则



#### 3.3 依赖关系三种传递方式：

* 接口传递（依赖）
* 构造方法传递（依赖）
* setter方式传递（聚合）
  
```
public class DependenceInversion {
    public static void main(String[] args) {
        Person person = new Person();
        person.receive(new Email());
        person.receive(new WeChat());
    }
}

interface Info{
    String getInfo();
}

class Email implements Info{

    @Override
    public String getInfo() {
        return "Receive Email";
    }
}

class WeChat implements Info{

    @Override
    public String getInfo() {
        return "Receive WeChat";
    }
}

//person 接受信息
class Person {

    public void receive(Info info) {
        System.out.println(info.getInfo());
    }
}

```
-- --


## 参考资料
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)</BR>
 [常用结构性模型](https://www.jianshu.com/p/b2c08a670299)

 [设计模式-视频讲解](https://www.bilibili.com/video/BV1G4411c7N4?p=6&vd_source=7c47b6d72612787b009ac686785b509a)

 [设计模式-原则](https://github-yuteng.github.io/2019/08/01/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%83%E5%A4%A7%E5%8E%9F%E5%88%99/)
 [设计模式-原则](https://blog.csdn.net/java123456111/article/details/124841336)
 <!--more-->
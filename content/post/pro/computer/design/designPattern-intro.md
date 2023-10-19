---
title: "设计模式-七原则"
subtitle: "设计模式原则"
date: 2022-12-01 
lastmod: 2022-12-01 
draft: false
author: "qsd"
authorLink: ""
description: "设计模式原则"

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

## 设计模式七原则

### 设计模式的目的

编写软件过程中，程序员面临着来自 耦合性，内聚性以及可维护性，可扩展性，重
用性，灵活性 等多方面的挑战，设计模式是为了让程序(软件)，具有更好
```
1) 代码重用性 (即:相同功能的代码，不用多次编写)
2) 可读性(即:编程规范性,便于其他程序员的阅读和理解)
3) 可扩展性 (即:当需要增加新的功能时，非常的方便，称为可维护)
4) 可靠性 (即:当我们增加新的功能后，对原来的功能没有影响)
5) 使程序呈现高内聚，低耦合的特性
```
### 单一原则(Single responsibility)

#### 介绍
**单一职责原则注意事项和细节：**

1、降低类的复杂度，一个类只负责一项职责
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

### 接口隔离原则（Interface Segregation）

#### **介绍**

客户端不应该依赖它不需要的接口，即**一个类对另一个类的依赖应该建立在最小的接口上**


 
 #### ** 不符合设计模式UML**
 <IMG SRC="https://img-blog.csdnimg.cn/4ef0a747466f4c2ab2a2949fec9a4729.png#pic_center">
分析：

​ 1）类A通过接口Interface1依赖类B，类C通过 接口Interface1依赖类D，如果接口 Interface1对于类A和类C来说不是最小接口， 那么类B和类D必须去实现他们不需要的方法。

​ 2）按隔离原则应当这样处理

​ 将接口Interface1拆分为独立的几个接口， 类A和类C分别与他们需要的接口建立依赖关系。也就是采用接口隔离原则

####  **口隔离模式UML**

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

### 依赖倒转原则（Dependence Inversion）

#### 基本介绍

​ 1) 高层模块不应该依赖低层模块，二者都应该依赖其抽象

​ 2) **抽象不应该依赖细节，细节应该依赖抽象**

​ 3) 依赖倒转(倒置)的中心思想是面向接口编程

​ 4) 依赖倒转原则是基于这样的设计理念：
    相对于细节的多变性，抽象的东西要稳定的多。以抽象为基础搭建的架构比以细节为基础的架构要稳定的多。在java中，抽象指的是接口或抽象类，细节就是具体的实现类

​ 5) 使用接口或抽象类的目的是制定好规范，而不涉及任何具体的操作，把展现细节的任务交给他们的实现类去完成

#### 依赖倒转原则注意事项和细节
​ 1) 低层模块尽量都要有抽象类或接口，或者两者都有，程序稳定性更好

​ 2) 变量的声明类型尽量是抽象类或接口, 这样我们的变量引用和实际对象间，就存在 一个缓冲层，利于程序扩展和优化

​ 3) 继承时遵循里氏替换原则



#### 依赖关系三种传递方式：

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

### 里氏替换原则（Liskov Substitution Principle）

#### 基本介绍
1) 里氏替换原则(Liskov Substitution Principle)在1988 年，由麻省理工学院的Barbara Liskov提出的。
2) 如果对每个类型为T1 的对象o1，都有类型为T2 的对象o2，使得以T1 定义的所有程序P 在所有的对象o1 都
代换成o2 时，程序P 的行为没有发生变化，那么类型T2 是类型T1 的子类型。换句话说，所有引用基类的地
方必须能透明地使用其子类的对象。
1) 在使用继承时，<FONT COLOR=RED>遵循里氏替换原则，在子类中尽量不要重写父类的方法</FONT>
2) 里氏替换原则告诉我们:<FONT COLOR=RED>继承实际上让两个类耦合性增强了，在适当的情况下，可以通过聚合，组合，依赖 来解决问题</FONT>

#### OO 中的继承性的思考和说明
1) 继承包含这样一层含义：父类中凡是已经实现好的方法，实际上是在设定规范和契约，虽然它不强制要求所有
的子类必须遵循这些契约，但是如果子类对这些已经实现的方法任意修改，就会对整个继承体系造成破坏。
2) 继承在给程序设计带来便利的同时，也带来了弊端。比如使用继承会给程序带来侵入性，程序的可移植性降低，
增加对象间的耦合性，如果一个类被其他的类所继承，则当这个类需要修改时，必须考虑到所有的子类，并且
父类修改后，所有涉及到子类的功能都有可能产生故障
3) 问题提出：在编程中，如何正确的使用继承? => 里氏替换原则

---- 


### 开闭原则(Open Close Principle)

软件实体（模块、类、方法等）应该<FONT COLOR=RED>"对扩展开放、对修改关闭"</FONT>.
**最基础，最重要的原则**

从定义上看，这个原则主要包含两部分:
#### **1 对扩展开放**
 
   这意味着模块的行为是可以扩展的。当应用程序的需求改变时，我们可以对其模块进行扩展，使其具有满足那些需求变更的新行为。换句话说，我们可以改变模块的功能。

#### **2 对修改关闭**

“对模块行为进行扩展时，不必改动该模块的源代码或二进制代码。模块的二进制可执行版本，无论是可链接的库、DLL或Java的.jar文件，都无需改动


```
//main
public static void main(String[] args) {
    //使用看看存在的问题
    GraphicEditor graphicEditor = new GraphicEditor();
    graphicEditor.drawShape(new Rectangle());
    graphicEditor.drawShape(new Circle());
    graphicEditor.drawShape(new Triangle());
    graphicEditor.drawShape(new OtherGraphic());
}

//这是一个用于绘图的类 [使用方]
class GraphicEditor {
    //接收Shape 对象，调用draw 方法
    public void drawShape(Shape s) {
        s.draw();
    }
}

//新增画三角形
class Triangle extends Shape {
    Triangle() {
    super.m_type = 3;
    }
    @Override
    public void draw() {
    // TODO Auto-generated method stub
    System.out.println(" 绘制三角形 ");
    }
}
//新增一个图形
class OtherGraphic extends Shape {
    OtherGraphic() {
    super.m_type = 4;
    }
    @Override
    public void draw() {
    // TODO Auto-generated method stub
    System.out.println(" 绘制其它图形 ");
    }
}
```

-- --

### 迪米特法则 (Demeter Principle)

####  基本介绍

1) 一个对象应该对其他对象保持最少的了解
2) **类与类关系越密切，耦合度越大**
3) 迪米特法则(Demeter Principle)又叫最少知道原则，即一个类对自己依赖的类知道的
  越少越好。也就是说，对于被依赖的类不管多么复杂，都尽量将逻辑封装在类的内
部。对外除了提供的public 方法，不对外泄露任何信息
4) 迪米特法则还有个更简单的定义:只与直接的朋友通信
5) <FONT COLOR=RED>直接的朋友:</FONT>
   每个对象都会与其他对象有耦合关系只要两个对象之间有耦合关系， 我们就说这两个对象之间是朋友关系。耦合的方式很多，依赖，关联，组合，聚合 等。其中，我们称出现成员变量，方法参数，方法返回值中的类为直接的朋友，而 出现在局部变量中的类不是直接的朋友。也就是说，<Font COLOR=RED>陌生的类最好不要以局部变量 的形式出现在类的内部。</FONT>

#### 迪米特法则注意事项和细节

1) <FONT COLOR=RED>迪米特法则的核心是降低类之间的耦合</Font>
2) 但是注意:由于每个类都减少了不必要的依赖，因此迪米特法则**只是要求降低 类间(对象间)耦合关系， 并不是要求完全没有依赖关系**  

#### 代码

```
public class Demeter1 {
    public static void main(String[] args) {
    //创建了一个 SchoolManager 对象
    SchoolManager schoolManager = new SchoolManager();
    //输出学院的员工id 和 学校总部的员工信息
    schoolManager.printAllEmployee(new CollegeManager());
    }
}

//学校总部员工类
class Employee {
    private String id;
    public void setId(String id) {
    this.id = id;
    }
    public String getId() {
    return id;
    }
}

//学院的员工类
class CollegeEmployee {
    private String id;
    public void setId(String id) {
    this.id = id;
    }
    public String getId() {
    return id;
    }
}

//管理学院员工的管理类
class CollegeManager {
//返回学院的所有员工
    public List<CollegeEmployee> getAllEmployee() {
        List<CollegeEmployee> list = new ArrayList<CollegeEmployee>();
        for (int i = 0; i < 10; i++) { //这里我们增加了10 个员工到 list
            CollegeEmployee emp = new CollegeEmployee();
            emp.setId("学院员工id= " + i);
            list.add(emp);
        }
        return list;
    }

    //输出学院员工的信息
    public void printEmployee() {
        //获取到学院员工
        List<CollegeEmployee> list1 = getAllEmployee();
        System.out.println("------------学院员工------------");
        for (CollegeEmployee e : list1) {
           System.out.println(e.getId());
        }
    }
}



//学校管理类
//分析 SchoolManager 类的直接朋友类有哪些 Employee、CollegeManager
//CollegeEmployee 不是 直接朋友 而是一个陌生类，这样违背了 迪米特法则
class SchoolManager {
    //返回学校总部的员工
    public List<Employee> getAllEmployee() {
        List<Employee> list = new ArrayList<Employee>();
        for (int i = 0; i < 5; i++) { //这里我们增加了5 个员工到 list
            Employee emp = new Employee();
            emp.setId("学校总部员工id= " + i);
            list.add(emp);
        }
        return list;
    }
    //该方法完成输出学校总部和学院员工信息(id)
    void printAllEmployee(CollegeManager sub) {
    //分析问题
    //1. 将输出学院的员工方法，封装到CollegeManager
    sub.printEmployee();
    //获取到学校总部员工
    List<Employee> list2 = this.getAllEmployee();
        System.out.println("------------学校总部员工------------");
        for (Employee e : list2) {
            System.out.println(e.getId());
        }   
    }
}

```

-- --



###  合成复用原则(Composite Reuse Principle)


#### 基本介绍：

<FONT COLOR=RED>原则是尽量使用合成/聚合的方式，而不是使用继承</FONT>

- 1、找出应用中可能需要变化之处，把它们独立出来，不要和那些不需要变化的代码混在一起。
- 2、针对接口编程，而不是针对实现编程。
- 3、为了交互对象之间的松耦合设计而努力。



## 参考资料
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)

 [常用结构性模型](https://www.jianshu.com/p/b2c08a670299)
 
 [设计模式-视频讲解](https://www.bilibili.com/video/BV1G4411c7N4?p=6&vd_source=7c47b6d72612787b009ac686785b509a)
 
 [设计模式-原则](https://github-yuteng.github.io/2019/08/01/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%83%E5%A4%A7%E5%8E%9F%E5%88%99/)
 
 [设计模式-原则](https://blog.csdn.net/java123456111/article/details/124841336)
 <!--more-->
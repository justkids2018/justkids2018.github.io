---
title: "设计模式【行为】职责链模式"
subtitle: ""
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

### 模式
#### 1、模式类型：
     行为型模式
#### 2、定义：
职责链模式（ChainofResponsibilityPattern）,又叫责任链模式，为请求创建了一个接收者对象的链，**这种模式对请求的发送者和接收者进行解耦**。
2)职责链模式通常每个接收者都包含对另一个接收者的引用。如果一个对象不能处理该请求，那么它会把相同的请求传给下一个接收者，依此类推。
3)这种类型的设计模式属于**行为型模式**


#### 3、原理类图

职责链模式的原理类图对原理类图的说明-即(职责链模式的角色及职责)
1)Handler:抽象的处理者,定义了一个处理请求的接口,同时含义另外Handler
2)ConcreteHandlerA,B是具体的处理者,处理它自己负责的请求，可以访问它的后继者(即下一个处理者),如果可以处理当前请求，则处理，否则就将该请求交个后继者去处理，从而形成一个职责链
3)Request，含义很多属性，表示一个请求26.6职责链模式解决OA系统采购审批

#### 4、代码
```
// 抽象类 Logger，表示处理者（Handler）
abstract class Logger {
  static const int INFO = 1;  // 定义日志级别常量
  static const int DEBUG = 2;
  static const int ERROR = 3;

  final int level;  // 当前处理者能够处理的日志级别
  Logger? nextLogger;  // 下一个处理者的引用

  Logger(this.level);

  // 设置下一个处理者的方法
  void setNextLogger(Logger nextLogger) {
    this.nextLogger = nextLogger;
  }

  // 处理日志信息的方法，根据日志级别决定是否处理
  void logMessage(int level, String message) {
    if (this.level <= level) {
      write(message);  // 如果当前处理者可以处理日志，则执行写入操作
    }
    nextLogger?.logMessage(level, message);  // 否则，将请求传递给链条上的下一个处理者
  }

  // 抽象方法，用于具体处理日志信息
  void write(String message);
}

// 具体的处理者之一：InfoLogger，处理信息级别的日志
class InfoLogger extends Logger {
  InfoLogger(int level) : super(level);

  @override
  void write(String message) {
    print("INFO: $message");  // 处理并输出信息级别的日志
  }
}

// 具体的处理者之一：DebugLogger，处理调试级别的日志
class DebugLogger extends Logger {
  DebugLogger(int level) : super(level);

  @override
  void write(String message) {
    print("DEBUG: $message");  // 处理并输出调试级别的日志
  }
}

// 具体的处理者之一：ErrorLogger，处理错误级别的日志
class ErrorLogger extends Logger {
  ErrorLogger(int level) : super(level);

  @override
  void write(String message) {
    print("ERROR: $message");  // 处理并输出错误级别的日志
  }
}

// 创建责任链的方法
Logger getChainOfLoggers() {
  var errorLogger = ErrorLogger(Logger.ERROR);
  var debugLogger = DebugLogger(Logger.DEBUG);
  var infoLogger = InfoLogger(Logger.INFO);

  // 设置责任链的顺序：INFO -> DEBUG -> ERROR
  infoLogger.setNextLogger(debugLogger);
  debugLogger.setNextLogger(errorLogger);

  return infoLogger;  // 返回链的起点，即信息级别的处理者
}

// 客户端代码：测试责任链模式的实现
void main() {
  var loggerChain = getChainOfLoggers();  // 获取责任链

  // 测试不同级别的日志信息，观察责任链的处理过程
  loggerChain.logMessage(Logger.INFO, "This is an informational message.");
  loggerChain.logMessage(Logger.DEBUG, "This is a debug level message.");
  loggerChain.logMessage(Logger.ERROR, "This is an error message.");
}
```


### 3、注意事项
### 4、应用场景
 okhttp
```

```






### 参考资料
 [备忘录模式详解](https://www.runoob.com/design-pattern/state-pattern.html)
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)</BR>
 [常用结构性模型](https://www.jianshu.com/p/b2c08a670299)
 <!--more-->
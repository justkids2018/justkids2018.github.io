---
title: "设计模式-适配器模式"
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

#### 1、适配器模式
1、模式类型：
    结构型
2、定义：适配器模式（Adapter Pattern）

<font color=red>将一个类的接口转换成客户希望的另外一个接口。</FONT>适配器模式使得原本由于接口不兼容而不能一起工作的那些类可以一起工作。其别名为包装器(Wrapper)
3、适配器分三类：
```
类适配器模式、
对象适配器模式、
接口适配器模式
```

4、工作原理
```
1) 适配器模式：将一个类的接口转换成另一种接口.让原本接口不兼容的类可以兼容
2) 从用户的角度看不到被适配者，是解耦的
3) 用户调用适配器转化出来的目标接口方法，适配器再调用被适配者的相关接口方法
4) 用户收到反馈结果，感觉只是和目标接口交互，如图

```
#### 2、原理uml图



<img src="img/disign-dp-适配器模式.drawio.png">

#### 3、实例：
```
//类适配器
public class Client {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Phone phone = new Phone();
		phone.charging(new VoltageAdapter());
	}
}


public class Phone {
	public void charging(IVoltage5V iVoltage5V) {
		if(iVoltage5V.output5V() == 5) {
			System.out.println("V5~~");
		} else if (iVoltage5V.output5V() > 5) {
			System.out.println("220~~");
		}
	}
}



public interface IVoltage5V {
	public int output5V();
}

public class Voltage220V {
	//220V
	public int output220V() {
		int src = 220;
		System.out.println("Voltage220V=" + src);
		return src;
	}
}

public class VoltageAdapter extends Voltage220V implements IVoltage5V {

	@Override
	public int output5V() {
		// TODO Auto-generated method stub
		int srcV = output220V();
		int dstV = srcV / 44 ; 
		return dstV;
	}

}



```


#### 4、应用场景
```
1 封装有缺陷的接口设计
2 统一多个类的接口设计
3 替换依赖的外部系统
4 兼容老版本接口
5 适配不同格式的数据
```






   




### 参考资料
 [设计模式资料](http://www.jasongj.com/design_pattern/simple_factory/)</BR>
 [常用结构性模型](https://www.jianshu.com/p/b2c08a670299)

 [设计模式-视频讲解](https://www.bilibili.com/video/BV1G4411c7N4?p=6&vd_source=7c47b6d72612787b009ac686785b509a)

 [设计模式-原则](https://github-yuteng.github.io/2019/08/01/%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%83%E5%A4%A7%E5%8E%9F%E5%88%99/)
 <!--more-->
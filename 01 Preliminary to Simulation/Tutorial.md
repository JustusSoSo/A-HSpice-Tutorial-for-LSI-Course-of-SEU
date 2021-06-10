### So I'll first talk about this file `test_tutorial_berkeley.sp `This is from one paper of Berkeley.

如果你看过伯克利那篇文章，你们你应该明白，所有SPICE的语句之间没有逻辑关系，没有先后顺序，我们编写时采取了某一种顺序只不过是习惯上的约定。
另外你需要注意：
  HSPICE不区分大小写
  HSPICE的注释符号是星号*（你可以在VScode中下载spice语言扩展，只需要Ctrl+/即可注释）
  HSPICE的同一行中注释，需要打美元符号

### 我现在解释一些基本语句：
.title TEST_without_FF
这是一个标题，以.title开头，或者不需要写.title，或者什么都不写的空行

vs vs gnd PWL(0s 0V 5ms 0V 5.001ms 5V 10ms 5V)
这一句的第一个词是VS，意味着我放置了一个电压源，它的名字是S。当然你可以写Vsource，V_voltage_source都什么问题的。
这一句的下面两个字VS、GND表示节点名称，这个VS与上面那个VS没有任何关系，它代表一个Node。
我们必须写两个Node，因为两个Node才能描述一个有电压/电压降的结构，一个Node是不能说明什么的。
后面的PWL表示Precise，精确调控电压源的电压，括号里面写：
  0s  0v  表示0秒时，电压降为0
  5ms 0v  表示5毫秒仍然为0
  5.001ms 5v  表示这两个节点的电压降经过了0.001ms，也就是相对于0时刻以5.001ms，电压降是5伏特
  那么后面的语句也是照这个套路解释的。
你可以想象一下，这一句事实上并没有很多关键字，比如你可以修改为：
V_source node_1 node_0 PWL(0s 0V 5ms 0V 5.001ms 5V 10ms 5V)
这里只不过改变了三个变量的名称，它本质上作为一个电压源是等价的。




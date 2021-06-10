.title TEST_without_FF


* .inc ''
* 包含另一个网表，可以是mod、sp文件




* 电路构造
****************************************************************
$ EE105 SPICE Tutorial Example 1 - Simple RC
vs vs gnd PWL(0s 0V 5ms 0V 5.001ms 5V 10ms 5V)
    * Source is vs
    * node is also vs
    * PWL: precise
        * 0s is 0v
        * 5m is 0v
        * 5.001ms is 5v, there is a delta eqs 1us
        * 10ms is 5v

* 单位指数：
    * f(femto)
    * p(pico)
    * n(nano)
    * u(micro)
    * m(milli)
    * k(kilo)
    * meg(mega)
    * g(giga)
    * t(tera)

* so only use
    * gnd or 0
* to refer to the ground node

r1 vs vo  1k
c1 vo gnd 1uF
****************************************************************





* 测量任意值
****************************************************************
* + 号代表换行，无意义

* tran 表示测量的是时间
* AC表示测量的是频率
* DC表示测量电压
    * 如果下面是DC或者AC，会导致输入vs不再是PWL时变，这里measure tran也没有意义。measure tran 应该配合 .tran 使用。

* val = 0.5 和 val = 4.5 表示vo 上升的这段时间
* val不可以是0，要测量0附近的，只能是1n 1u之类的小值

* rise = 1 表示测量第一次上升，且仅测量第一次
* fall = 1可以测下降

.measure
+ tran trise
+ trig v(vo) val=0.5 rise=1
+ targ v(vo) val=4.5 rise=1

.measure tran trise02
    + trig v(vs) val = 0.5 rise  = 1
    + targ v(vs) val = 4.5 rise = 1



* 如何检查测量结果？可以在list（当前路径的.lis文件，或者Edit LL打开）
* 在list中查找:
    * transient analysis
* 即可查看
    * trig，
    * targ，
    * trise（measure name） = targ - trig差值

* 如何检查measure？只需搜索job concluded，这句的上面就是测量结果，例如：
    * ******  transient analysis tnom=  25.000 temp=  25.000 *****
    * trise=  2.1963E-03  targ=  7.3036E-03   trig=  5.1074E-03
    * trise02=  8.0000E-07  targ=  5.0009E-03   trig=  5.0001E-03
* 表示 5.1ms上升，7.3ms上升完毕，中间间隔2.19ms
* 测量vs结果是8E-7即可上升。

* 如何直接打开文件检查measure？在当前路径生成了
    * .mt0文件
* 即为measure结果

****************************************************************












* 时变
****************************************************************
* .tran 0.01ms 10ms
    * transient
    * (i.e. measure values as a function of time)
    * 0 to 10ms, step is 0.01ms
.tran 0.01ms 20ms
****************************************************************

* 直流
****************************************************************
* .dc vs 0V 5V 0.01V
    * step is 0.01v, from 0 to 5v
* .dc vs 0V 5V 1V
****************************************************************

*选项
****************************************************************
* .option post
.option post=2 nomod
* option list:
    * post = 2
    * nomod
        * post=2, generate extra files for WaveView to use in plotting data.
        * post=1 post=3 is also ok
        *  be able to plot your data in WaveView.

        * nomod, not to print model information in the output file
****************************************************************
* .op
    * operating point
    * calculate the voltage at every node and the current through every branch in thecircuit.
    * Note that we’ve excluded the
    *     .option post = 2
    * No WaveView for this analysis.
****************************************************************

* 结束
****************************************************************
.end
****************************************************************



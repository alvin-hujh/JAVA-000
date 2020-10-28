# Netty 和 NIO

## GC的效率比较

### 固定堆内存下不同GC效率
#### 串行 GC
```
# 使用串行 GC，限定初始/最大堆内存为 512m，存储日志文件，打印时间戳 
java -XX:+UseSerialGC -Xms512m -Xmx512m -Xloggc:gclogs/gc.ser512.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps GCLogAnalysis
```
执行结果：
![avatar](https://i.loli.net/2020/10/27/jSGyF3paK2RE4vr.png "串行512m")


#### 并行 GC
```
# 使用并行 GC，限定初始/最大堆内存为 512m，存储日志文件，打印时间戳 
java -XX:+UseParallelGC -Xms512m -Xmx512m -Xloggc:gclogs/gc.par512.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps GCLogAnalysis
```
执行结果：
![avatar](https://i.loli.net/2020/10/27/MspuvX2Ha1PNSwc.png "并行512")

#### CMS GC
```
# 使用并行 GC，限定初始/最大堆内存为 512m，存储日志文件，打印时间戳 
java -XX:+UseConcMarkSweepGC -Xms512m -Xmx512m -Xloggc:gclogs/gc.cms512.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps GCLogAnalysis
```
执行结果：
![avatar](https://i.loli.net/2020/10/27/qRBjAglsoDLwukS.png "cms512")

#### G1 GC
```
# 使用cms GC，限定初始/最大堆内存为 512m，存储日志文件，打印时间戳  
java -XX:+UseG1GC -Xms512m -Xmx512m -Xloggc:gclogs/gc.g1512.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps GCLogAnalysis
```
执行结果：
![avatar](https://i.loli.net/2020/10/27/1nxQPW3mvDIslgt.png "g1512")


### 不同堆内存下GC效率差异
|类型\堆内存|128 | 512 | 1G | 2G | 4G |
|----|----| -----| -----| -----| ----|
|串行|OOM|9629|12385|11690|9169|
|并行|OOM|8677|12523|12472|12075|
|CMS|OOM|10752|14823|13775|13371|
|G1|OOM|11033|13776|13027|13168|

### 小结
* 在硬件资源比较充分的情况下，理论上越高级的 GC 效率越高
* 串行 GC 因为是单线程的，的暂停时间很更长（实践结果上看跟 cms 差不多，比并行长）
* 随着堆内存增加，GC 压力会变大，所以创建对象数会下降，整体随和内存增加对象数类似一个开口向下抛物线

## NIO
### 模拟socket性能压测

#### 30 秒压测结果

| 并发数|单线程处理 | 每个请求一个线程 | 固定大小线程池（40） |
| ---- | ----| ---- | ---- |
|40| 4.55(884.51ms) | 9.67(23.53ms) | 3.13(21.99ms) |
|80| 5.15(1.15s) | 10.68(23.05ms) | 7.02(28.99ms) |
|200| 2.26(1.16s) | 11.59(23.23ms) | 9.44(38.37ms) |

#### 疑问
1. 为什么 RPS 这么低呢，理论值应该在 40+接近50。上面图表测试的时候没有指定参数，后来我设定 vm 参数堆内存为 1g，变化也不大。
2. 为什么固定大小线程池的吞吐量还没有每个请求单独创建一个线程的吞吐高，按理说创建线程的开销是挺大的，池化之后效率要提升才对吧。

### 通过 OKHttp 请求 localhost:8801
代码路径：JAVA-000/Week_02/nio/src/main/java/client/MyHttpClient.java

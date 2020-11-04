# 第三周：Netty、API网关、多线程

## Netty

### 关键对象
* BootStrap:启动线程，开启 socket
* EventLoopGroup:线程池
* EventLoop:线程（一个不断轮询的单线程处理器）
* SocketChannel:连接
* ChannelInitializer:初始化
* ChannelPipeline:处理器链
* ChannelHandler:处理器

### Netty 运行原理
1. 请求打到应用被 BossGroup 接收
2. BossGroup 将请求转发给 WorkerGroup（即 EventLoopGroup）
3. WorkerGroup 将请求分发给 EventLoop（类似项目经理派活）
4. EventLoop 拿到任务列表（即 Task Queue） 
5. EventLoop 将任务塞给当前的 Channel
6. Channel 将任务放进流水线（ChannelPipeline）处理

### Netty 优化
1. 粘包与拆包：在同一个 socket 通道中，接收到若干个数据包，这些包应该怎么拆分？
2. Nagle 与 TCP_NODELAY

        网络拥堵与 Nagle 算法优化：当发送数据缓冲区满或者超时，则都丢给网络（NoDelay）
        MTU-最大传输单元，1500 Byte
        MSS-最大分段大小，1400 Byte

3. 连接优化
        
    三次握手：
    1. 客户端向服务端发起请求，确认服务端状态
    2. 服务端收到客户端请求，回复自身状态并询问客户端状态
    3. 客户端确认服务端状态，发起数据传输
        
    四次挥手：
    1. 客户端告知服务器端
    2. 服务器端收到并告知客户端已收到
    3. 服务端和客户端再次确认是否断开
    4. 客户端响应服务端确认断开
        
4. 不要阻塞 EventLoop：EventLoop 可以视作单线程

5. 系统参数优化：
       
      1. Linux 上一切都是文件，可以把单个线程文件描述符设置为足够大；
      2. Socket 关闭周期足够短
      
6. 缓冲区优化
 
7. 心跳周期优化：心跳机制与短线重连


## API 网关
### 网关的结构和职能
* 请求接入：作为所有 API 接口服务的接入点
* 业务聚合：作为所有后端服务的聚合点
* 中介策略：实现安全、验证、过滤、流控等策略
* 统一管理：对所有 API 和策略进行统一管理

### 手动实现网关

#### 简单实现
com.hujh.camp.gateway.simply.SimpleGateway
#### Netty 实现
TODO
#### 加 Filter
TODO
#### 加 Router
TODO


## 多线程




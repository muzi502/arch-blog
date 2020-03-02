---
title: Linux 网络和 iptables
date: 2020-03-01
updated: 2020-03-01
slug: 
categories: 技术
tag:
  - Linux 网络
  - 容器
copyright: true
comment: true
---

最近参加了一场视频会议面试，虽然结果不太理想，但还是发现自己对技术细节钻研的不够深，一些很基础性的知识点并没有形成一个系统性的知识架构。比如 TCP 和 UDP 的区别，这是再简单不过的问题。虽然平时都知道 TCP 应用于哪些场景，UDP 应用与哪些场景，但二者之间的细节，还是没能仔细地深入研究。所以从现在开始从新学习一下一些基础性的东西，补足一下欠下的知识😥。不过也让我意识到，我是该离开这个安逸的环境了，再过几年就要三十而立了，而这几年也正是技术积累沉淀的黄金时代，希望珍惜这段时光，不负韶华踏踏实实研究技术。

## 防火墙

## Linux 协议栈

在讲解 iptables 之前要回顾一下 Linux 接收数据包和发送数据包的流程，才能理解 iptables 在 Linux 网络协议栈中的位置和作用。去年的时候听了 Go 夜读的  [【Go 夜读】 网络知识十全大补丸](https://github.com/developer-learning/night-reading-go/issues/506) ，推荐去看一下[YouTube【Go 夜读】#68 网络知识十全大补丸](https://www.youtube.com/watch?v=30wCahZEjNg)。

> 后端工程师在工作中经常会遇到计算机网络方面的问题，网络对多数人来说还是一个黑盒子，本次技术分享从常见的网络硬件、企业和数据中心的网络拓扑、Linux协议栈和防火墙等基础网络知识开始介绍，一直讲到TCP和HTTP这些年的技术演进路线和未来趋势。

### 收包流程

#### 1. 数据包到达网卡 NIC(Network Interface Card)

#### 2. NIC 检验 MAC 网卡(网卡非混杂模式)和帧的校验字段 FCS

NIC 会校验收到数据包的目的 MAC 地址是不是自己的 MAC 地址，在网卡非混杂模式下，MAC 地址不是自己的数据包通常就会丢弃。在开启混杂模式之后所有数据包都会是接收处理。

使用非混杂模式的场景：

- 抓包
- 虚拟机
- 抓包程序会把网卡设置为非混杂模式，因此抓包程序需要  root 权限，没有 root 权限无法修改硬件设备的配置。

校验玩 MAC 地址之后 NIC 还会校验帧的校验字段 FCS，一次来确保接收到的数据包是正确的，如果校验失败就直接丢弃数据包

二层的网络帧格式：

MTU

#### 3. NIC 通过 DMA 将数据包放入提前映射好的内存区域

DMA：英文拼写是 “Direct Memory Access” ，翻译成中文就是直接内存访问。DMA 允许网络设备将数据包数据直接移动到系统内存中, 从而降低 CPU 利用率。

正常情况下，一个网络数据包从网卡到应用程序需要经过如下的过程：数据从网卡通过 DMA 等方式传到内核开辟的缓冲区，然后从内核空间拷贝到用户态空间，在 Linux 内核协议栈中，这个耗时操作甚至占到了数据包整个处理流程的 57.1%。

#### 4. NIC 将数据包的引用放入接收的 ring buffer （环形缓冲区）队列 rx 中

#### 5. NIC 等待 rx-usecs 的超时时间或者 rx 队列长度达到 rx-frames 后触发硬件中断 IRQ，表示数据包收到了

- rx-usecs: 系统内核参数设置的若干微妙的超时时间。

- rx-frames: 对应的 rx 队列长度。

调整二者参数大一点，中断不频繁，吞吐量会高一些，但实时性会差一些。二者参数调小一些，NIC 中断频繁一些，实时性会高一些，但吞吐量会小一些。

#### 6. CPU 执行硬件中断和网卡的驱动程序

CPU 接收硬件中断信号后就停止手里的活，保存上下文，接着去执行网卡的中断程序，网卡的中断程序是网卡的驱动程序提前注册好的，所以接下来会调用网卡的驱动程序。

#### 7. 驱动程序清理硬中断并触发软中断 NET_RX_SOFTIRQ

在此硬件中断就处理完了。在此梳理一些整个中断处理的过程：NIC 引起硬件中断 --> 硬件中断的 handler 将引起软件中断 --> 驱动将处理这个中断，它将报文从环形缓冲区溢出，在内存中分配一个 skb --> 调用 netif_rx(skb) --> 此 skb 将放入 cpu 处理报文的队列中。如果队列满了此包将丢掉。到这为止中断就处理结束。

- **linux kernel 在报文处理上的不足**

> 中断处理：当网络中大量数据包到来时，会产生频繁的硬件中断请求，这些硬件中断可以打断之前较低优先级的软中断或者系统调用的执行过程，如果这种打断频繁的话，将会产生较高的性能开销。
> 内存拷贝：正常情况下，一个网络数据包从网卡到应用程序需要经过如下的过程：数据从网卡通过 DMA 等方式传到内核开辟的缓冲区，然后从内核空间拷贝到用户态空间，在 Linux 内核协议栈中，这个耗时操作甚至占到了数据包整个处理流程的 57.1%。
> 上下文切换：频繁到达的硬件中断和软中断都可能随时抢占系统调用的运行，这会产生大量的上下文切换开销。另外，在基于多线程的服务器设计框架中，线程间的调度也会产生频繁的上下文切换开销，同样，锁竞争的耗能也是一个非常严重的问题。
> 局部性失效：如今主流的处理器都是多个核心的，这意味着一个数据包的处理可能跨多个 CPU 核心，比如一个数据包可能中断在 cpu0，内核态处理在 cpu1，用户态处理在 cpu2，这样跨多个核心，容易造成 CPU 缓存失效，造成局部性失效。如果是 NUMA 架构，更会造成跨 NUMA 访问内存，性能受到很大影响。
> 内存管理：传统服务器内存页为 4K，为了提高内存的访问速度，避免 cache miss，可以增加 cache 中映射表的条目，但这又会影响 CPU 的检索效率。

`此处引用` [1](https://github.com/OSH-2019/x-xdp-on-android/blob/master/docs/research.md)

#### 8. 软中断对网卡进行轮训收包

- **补充**

因为硬件中断不能被嵌套即不能被打断，所以 NIC 会将硬中断信号清理掉去触发一个软中断，而软中断只需要指令即可触发。

- 硬中断：硬件信号触发的，比如键盘按键。

- 软中断：CPU 自身指令触发的中断，可以被硬件中断打断。比如系统调用。

中断数量太多的时候，CPU 不断地上下文切换，整个系统的性能将会有所损耗。

半中断半轮询模式：在软中断里轮询收包。

#### 9. 数据包被放入 qdisc 队列

以前每一个 NIC 一个队列，所有的中断都被一个 CPU 处理，直到后来改进设计出网卡多队列的模型。

网卡多队列：一个网卡对应多个接收队列，在收到数据包后会对源地址和目的地址做一个 HASH 分配到对各个队列当中去，每一个队列都会有个子中断号，这个子中断号可以分配到不同的 CPU 中去处理。这样可以让 NIC 收到的数据包让多个 CPU 来处理。

CPU 绑定：一个 NIC 产生多个中断，让多个 CPU 去分担中断的负载。

#### 10. 将数据包送入协议栈，调用 ip_recv

在此数据包就进入了协议栈，调用 ip_recv 进入三层协议栈。

ip_recv函数 [linux TCP/IP协议栈-IP层](http://abcdxyzk.github.io/blog/2015/03/04/kernel-net-ip/)

```C
/* 主要功能：对IP头部合法性进行严格检查，然后把具体功能交给ip_rcv_finish。*/
int ip_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt, struct net_device *orig_dev)
{
	struct iphdr *iph;
	u32 len;
	/* 网络名字空间，忽略 */
	if (dev->nd_net != &init_net)
		goto drop;
	/*
	 *当网卡处于混杂模式时，收到不是发往该主机的数据包，由net_rx_action()设置。
	 *在调用ip_rcv之前，内核会将该数据包交给嗅探器，所以该函数仅丢弃该包。
	 */
	if (skb->pkt_type == PACKET_OTHERHOST)
		goto drop;
	/* SNMP所需要的统计数据，忽略 */
	IP_INC_STATS_BH(IPSTATS_MIB_INRECEIVES);

	/*
	 *ip_rcv是由netif_receive_skb函数调用，如果嗅探器或者其他的用户对数据包需要进
	 *进行处理，则在调用ip_rcv之前，netif_receive_skb会增加skb的引用计数，既该引
	 *用计数会大于1。若如此次，则skb_share_check会创建sk_buff的一份拷贝。
	 */
	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL) {
		IP_INC_STATS_BH(IPSTATS_MIB_INDISCARDS);
		goto out;
	}
	/*
	 *pskb_may_pull确保skb->data指向的内存包含的数据至少为IP头部大小，由于每个
	 *IP数据包包括IP分片必须包含一个完整的IP头部。如果小于IP头部大小，则缺失
	 *的部分将从数据分片中拷贝。这些分片保存在skb_shinfo(skb)->frags[]中。
	 */
	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
		goto inhdr_error;
	/* pskb_may_pull可能会调整skb中的指针，所以需要重新定义IP头部*/
	iph = ip_hdr(skb);

	/*
	 *    RFC1122: 3.1.2.2 MUST silently discard any IP frame that fails the checksum.
	 *
	 *    Is the datagram acceptable?
	 *
	 *    1.    Length at least the size of an ip header
	 *    2.    Version of 4
	 *    3.    Checksums correctly. [Speed optimisation for later, skip loopback checksums]
	 *    4.    Doesn't have a bogus length
	 */
	/* 上面说的很清楚了 */
	if (iph->ihl < 5 || iph->version != 4)
		goto inhdr_error;
	/* 确保IP完整的头部包括选项在内存中 */
	if (!pskb_may_pull(skb, iph->ihl*4))
		goto inhdr_error;
	
	iph = ip_hdr(skb);
	/* 验证IP头部的校验和 */
	if (unlikely(ip_fast_csum((u8 *)iph, iph->ihl)))
		goto inhdr_error;
	/* IP头部中指示的IP数据包总长度 */
	len = ntohs(iph->tot_len);
	/*
	 *确保skb的数据长度大于等于IP头部中指示的IP数据包总长度及数据包总长度必须
	 *大于等于IP头部长度。
	 */
	if (skb->len < len) {
		IP_INC_STATS_BH(IPSTATS_MIB_INTRUNCATEDPKTS);
		goto drop;
	} else if (len < (iph->ihl*4))
		goto inhdr_error;

	/* Our transport medium may have padded the buffer out. Now we know it
	 * is IP we can trim to the true length of the frame.
	 * Note this now means skb->len holds ntohs(iph->tot_len).
	 */
	/* 注释说明的很清楚，该函数成功执行完之后，skb->len = ntohs(iph->tot_len). */
	if (pskb_trim_rcsum(skb, len)) {
		IP_INC_STATS_BH(IPSTATS_MIB_INDISCARDS);
		goto drop;
	}

	/* Remove any debris in the socket control block */
	memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
	/* 忽略与netfilter子系统的交互，调用为ip_rcv_finish(skb) */
	return NF_HOOK(PF_INET, NF_IP_PRE_ROUTING, skb, dev, NULL,
		 ip_rcv_finish);

inhdr_error:
	IP_INC_STATS_BH(IPSTATS_MIB_INHDRERRORS);
drop:
	kfree_skb(skb);
out:
	return NET_RX_DROP;
}
```

#### 11. 调用 netfilter 的 PREROUTING 链

> netfilter： 是 Linux 内核中进行数据包过滤，连接跟踪（Connect Track），网络地址转换（NAT）等功能的主要实现框架；该框架在网络协议栈处理数据包的关键流程中定义了一系列钩子点（Hook 点），并在这些钩子点中注册一系列函数对数据包进行处理。这些注册在钩子点的函数即为设置在网络协议栈内的数据包通行策略，也就意味着，这些函数可以决定内核是接受还是丢弃某个数据包，换句话说，这些函数的处理结果决定了这些网络数据包的“命运”。

在这里就到了内核防火墙

#### 12. 查找路由表，进行转发或者投递到 local

进行转发：ip_forward

#### 13. 对投递到 local 的数据包调用 netfilter 的 LOCAL_IN 链

#### 14. 调用四层协议栈，如 tcp_v4_rcv

#### 15. 查找到对应的 socket，运行 TCP 的状态机

内核中的五元组：`| 协议类型 | 源地址 | 源端口 | 目标地址 | 目的端口 |`

将五元组进行 HASH ，根据哈希值找到对应的 socket --> 去运行该 socket 的 TCP 状态机。

#### 16. 将数据放入 TCP 的接收缓冲区中

#### 17. 通过 epoll 或者其他轮训方式通知应用程序

epoll：通过 epoll 监听可读事件，数据包丢到接收缓冲区的时候就有一个可读的事件，epoll 就会挂一个钩子，可读事件就会调用 epoll 这个钩子，然后将可读事件放入到可读队列中，接着通知到应用程序。

select：

#### 18. 应用程序读取程序

通过 read()函数读取数据？

### 发包流程

#### 1. 应用数据发送程序

调用 send() 函数，将数据从应用层拷贝到内核中

#### 2. TCP 为发送的数据申请 skb

SKB 在内核里为一个数据包

#### 3. 构建 TCP 头部，如 src 和 dst 的 port，checksum

TCP 头部

#### 4. 调用第三层协议，构建 IP 头部，调用 netfilter 的 LOCAL_OUT 链

此处防火墙，从本机出去的包都要跑一下 LOCAL_OUT 链。

#### 5. 查找路由表，确定下一跳

#### 6. 调用 netfilter 的 POST_ROUTING 链

路由之后的链，调用路由之后的链

#### 7. 对超时 MTU 的报文进行分片(fragment)

#### 8. 调用二成的发包函数 dev_queue_xmit

#### 9. 将待发数据包放入输出的 QDisc 队列

#### 10. 调用网卡驱动程序，将数据包放入循环缓冲队列 tx

#### 11. 驱动程序在 tx-usecs 的超时时间后，或者积累 tx-frames 个待发数据包后触发软中断

- tx-usecs

- tx-frames

#### 12. 驱动程序启用网卡的硬件中断

#### 13. 驱动程序将数据包映射到 DMA 内存

#### 14. 网卡从 DMA 中取数据并发送

#### 15. 网卡发送完毕后触发硬件中断

#### 16. 硬中断清理中断信号后触发软中断

#### 17. 软中断释放已经发送完的数据包的内存

## 防火墙

在 Linux 上 iptables 是一个命令行工具，用于配置管理信息包的过滤规则，而真正起到信息包过滤作用的是 netfilter 框架。广义上的 iptables 实际上是由 netfilter 和 iptables 两个组件组成。

### iptables 与 netfilter

#### iptables

#### netfilter

#### 表/链/规则

提到 iptables 不得不提一下 四表（ raw、filter, nat, mangle,）五链（INPUT、OUTPUT、FORWARD、 PREROUTING、 POSTROUTING），也有说法为五表（ raw、filter、nat、mangle、security）五链，不过 security 表大多数情况下不会用到，常用的是  filter 和 nat 表，mangle 表次之。

> netfilter/iptables 系统可以理解成是 表 的容器，这也是它被称为 iptables 的原因，而表则是 链 的容器，即所有的链都属于其对应的表，链又是 规则 的容器。

#### 五表

- raw 表： 用于配置数据包，raw 中的数据包不会被系统跟踪。其优先级最高，设置 raw 时一般是为了不再让 iptables 做数据包的链接跟踪处理，提高性能

- filter 表： 为 iptables 默认的表，在操作时如果没有指定使用哪个表，iptables 默认使用 filter 表来执行所有的命令。filter 表根据预定义的一组规则过滤符合条件的数据包。在 filter 表中只允许对数据包进行接收、丢弃的操作，而无法对数据包进行更改

- nat 表： 即 Network Address Translation，主要是用于网络地址转换（例如：端口转发），该表可以实现一对一、一对多、多对多等 NAT 工作

- mangle 表： 主要用于对指定包的传输特性进行修改。某些特殊应用可能需要改写数据包的一些传输特性，例如更改数据包的 TTL 和 TOS 等

security 表： 用于强制访问控制网络规则（例如： SELinux）

#### 五链

- INPUT： 处理入站数据包，当接收到访问本机地址的数据包(入站)时，应用此链中的规则

- OUTPUT： 处理出站数据包，当本机向外发送数据包(出站)时，应用此链中的规则

- FORWARD： 处理转发数据包，当接收到需要通过本机发送给其他地址的数据包(转发)时，应用此链中的规则

- PREROUTING： 在对数据包作路由选择之前，应用此链中的规则

- POSTROUTING： 在对数据包作路由选择之后，应用此链中的规则

#### 规则

- ACCEPT： 允许数据包通过

- DROP： 直接丢弃数据包，不给任何回应信息，这时候客户端会感觉自己的请求泥牛入海了，过了超时时间才会有反应

- QUEUE： 将数据包移交到用户空间

- RETURN： 停止执行当前链中的后续规则，并返回到调用链(The Calling Chain)中

- REJECT： 拒绝数据包通过，必要时会给数据发送端一个响应的信息，客户端刚请求就会收到拒绝的信息

- DNAT： 目标地址转换

- SNAT： 源地址转换，解决内网用户用同一个公网地址上网的问题

- MASQUERADE： 是 SNAT 的一种特殊形式，适用于动态的、临时会变的 ip 上

- REDIRECT： 在本机做端口映射（透明代理的时候会用到）

- LOG： 记录日志信息，除记录外不对数据包做任何其他操作，仍然匹配下一条规则

### 数据包流程

此图摘自 [Archlinux 文档](https://wiki.archlinux.org/index.php/Iptables)

```txt
                               XXXXXXXXXXXXXXXXXX
                             XXX     Network    XXX
                               XXXXXXXXXXXXXXXXXX
                                       +
                                       |
                                       v
 +-------------+              +------------------+
 |table: filter| <---+        | table: nat       |
 |chain: INPUT |     |        | chain: PREROUTING|
 +-----+-------+     |        +--------+---------+
       |             |                 |
       v             |                 v
 [local process]     |           ****************          +--------------+
       |             +---------+ Routing decision +------> |table: filter |
       v                         ****************          |chain: FORWARD|
****************                                           +------+-------+
Routing decision                                                  |
****************                                                  |
       |                                                          |
       v                        ****************                  |
+-------------+       +------>  Routing decision  <---------------+
|table: nat   |       |         ****************
|chain: OUTPUT|       |               +
+-----+-------+       |               |
      |               |               v
      v               |      +-------------------+
+--------------+      |      | table: nat        |
|table: filter | +----+      | chain: POSTROUTING|
|chain: OUTPUT |             +--------+----------+
+--------------+                      |
                                      v
                               XXXXXXXXXXXXXXXXXX
                             XXX    Network     XXX
                               XXXXXXXXXXXXXXXXXX
```

## 参考

- [Linux协议栈--连接跟踪源码分析](http://cxd2014.github.io/2017/08/15/connection-tracking-system/)

- [x-xdp-on-android](https://github.com/OSH-2019/x-xdp-on-android/blob/master/docs/research.md)

- [linux TCP/IP协议栈-IP层](http://abcdxyzk.github.io/blog/2015/03/04/kernel-net-ip/)

- [CPU体系架构 DMA](https://nieyong.github.io/wiki_cpu/CPU%E4%BD%93%E7%B3%BB%E6%9E%B6%E6%9E%84-DMA.html)

- [iptables 使用方式整理](http://blog.konghy.cn/2019/07/21/iptables/)

- [Archlinux：Iptables](https://wiki.archlinux.org/index.php/Iptables_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

- [iptables 防火墙基本配置和使用](https://windard.com/opinion/2016/10/15/About-Iptables)

- [Linux的 iptables 常用配置范例（1）](http://www.ha97.com/3928.html)

- [开启 ufw 导致断网不能 ping? ufw 和 iptables 的那些坑](https://www.bennythink.com/ufw-iptables.html)

- [Linux 网络层收发包流程及 Netfilter 框架浅析](https://zhuanlan.zhihu.com/p/93630586)

- []()
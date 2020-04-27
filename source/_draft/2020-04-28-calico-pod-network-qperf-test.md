---
title: 
date: 2020-01-01
updated:
slug:
categories:
tag:
copyright: true
comment: true
---

## Pod 网络性能测试

从容器网络性能测试的角度来说，关注点主要在于不同场景下带宽、计算资源消耗的情况。下面简单介绍一下相关的测试场景和测试策略以及涉及的测试工具：

> 由于k8s网络插件在工作过程中存在Linux的`User Space`和`Kernel Space`的交互（封包解包），这是性能损耗的主要来源之一；如果考虑网络安全，需要加上网络插件的限制隔离机制（Network Policies）的测试。

- 场景一：同主机Pod间通信
- 场景二：跨主机Pod间通信
- 场景三：集群内主机和主机间通信
- 场景四：Pod与宿主机间通信
- 场景五：Pod与非宿主机间通信
- 测试策略：固定网络带宽，固定网络类型，测试不同数据包大小对网络吞吐量的影响，例如可以测试获取文件传输量超过10G，系统在文件传输高峰时对局域网的**带宽要求**，并对比容器网络传输和非容器网络（Bare Metal）传输之间的**CPU消耗**以及**内存消耗**情况。
- 测试工具：[qperf](https://linux.die.net/man/1/qperf) 容器化运行在k8s集群上。

## 测试准备

**基础镜像**

```dockerfile
FROM debian:buster
RUN sed -i 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list ;\
    sed -i 's|security.debian.org/debian-security|mirrors.huaweicloud.com/debian-security|g' /etc/apt/sources.list ;\
    apt-get update ;\
    apt-get install -y qperf iperf net-tools;\
    rm -rf /var/lib/apt/lists
```

- 然后构建镜像并将镜像推送到私有的 harbor 镜像仓库中

```shell
╭─root@debian ~/k8s-test
╰─# docker build -t debian:qperf .
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM debian:buster
buster: Pulling from library/debian
90fe46dd8199: Pull complete
Digest: sha256:2857989334428416b1ef369d6e029e912a7fe3ee7e57adc20b494cc940198258
Status: Downloaded newer image for debian:buster
 ---> 3de0e2c97e5c
Step 2/2 : RUN sed -i 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list ;    sed -i 's|security.debian.org/debian-security|mirrors.huaweicloud.com/debian-security|g' /etc/apt/sources.list ;    apt-get update ;    apt-get install -y qperf top net-tools;    rm -rf /var/lib/apt/lists
 ---> Running in 3a847305a08e
Get:1 http://mirrors.huaweicloud.com/debian buster InRelease [122 kB]
Get:2 http://mirrors.huaweicloud.com/debian-security buster/updates InRelease [65.4 kB]
Get:3 http://mirrors.huaweicloud.com/debian buster-updates InRelease [49.3 kB]
Get:4 http://mirrors.huaweicloud.com/debian buster/main amd64 Packages [7907 kB]
Get:5 http://mirrors.huaweicloud.com/debian-security buster/updates/main amd64 Packages [189 kB]
Get:6 http://mirrors.huaweicloud.com/debian buster-updates/main amd64 Packages [7380 B]
Fetched 8339 kB in 3s (3128 kB/s)
Reading package lists...
Reading package lists...
Building dependency tree...
Reading state information...
E: Unable to locate package top
Removing intermediate container 3a847305a08e
 ---> 487bfcf052fe
Successfully built 487bfcf052fe
Successfully tagged debian:qperf
╭─root@debian ~/k8s-test
╰─# docker tag debian:qperf 10.10.107.217/ops/debian:qperf
╭─root@debian ~/k8s-test
╰─# docker push 10.10.107.217/ops/debian:test
The push refers to repository [10.10.107.217/ops/debian]
c7e68aed01d7: Pushed
e40d297cf5f8: Pushed
test: digest: sha256:fba23915e139c038f6d3d238025b218db76f5f69703b25b0c9c0914d8a109e28 size: 736
```



```shell
[root@k8s-master-01 k8s-test]# kubectl get pod -n ops-test
NAME                              READY   STATUS    RESTARTS   AGE
debian-node-02-85c54958cd-4h8jl   1/1     Running   0          156m
debian-node-02-85c54958cd-vjfmw   1/1     Running   0          156m
debian-node-03-857fb88b4c-cq8jf   1/1     Running   0          65s
debian-node-03-857fb88b4c-sx7d9   1/1     Running   0          65s
```

### 对照组：集群内主机和主机间通

`k8s-node-02` > `k8s-node-03`

```ini
tcp_bw:
    bw              =   116 MB/sec
    msg_rate        =  1.77 K/sec
    time            =    30 sec
    send_cost       =  2.26 sec/GB
    recv_cost       =   465 ms/GB
    send_cpus_used  =  26.2 % cpus
    recv_cpus_used  =   5.4 % cpus
tcp_lat:
    latency        =   402 us
    msg_rate       =  2.48 K/sec
    time           =    30 sec
    loc_cpus_used  =  23.1 % cpus
    rem_cpus_used  =  1.93 % cpus
udp_bw:
    send_bw         =   118 MB/sec
    recv_bw         =   140 KB/sec
    msg_rate        =  4.27 /sec
    time            =    30 sec
    send_cost       =  2.83 sec/GB
    recv_cost       =  35.8 sec/GB
    send_cpus_used  =  33.6 % cpus
    recv_cpus_used  =   0.5 % cpus
udp_lat:
    latency        =   131 us
    msg_rate       =  7.66 K/sec
    time           =    30 sec
    loc_cpus_used  =  24.8 % cpus
    rem_cpus_used  =   4.8 % cpus
conf:
    loc_node   =  k8s-node-02
    loc_cpu    =  4 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    loc_os     =  Linux 3.10.0-862.el7.x86_64
    loc_qperf  =  0.4.9
    rem_node   =  k8s-node-03
    rem_cpu    =  4 Cores: Intel Core i5-4590 @ 3.30GHz
    rem_os     =  Linux 4.19.0-5-amd64
    rem_qperf  =  0.4.11
```

### 场景一：同主机 Pod 间通信

`debian-node-02-656868cc46-72lc9` > `debian-node-02-656868cc46-xftvq`

```ini
root@debian-node-02-656868cc46-72lc9:/# qperf  -t 30 100.107.127.100 -v tcp_bw udp_bw tcp_lat udp_lat conf
tcp_bw:
    bw              =  3.24 GB/sec
    msg_rate        =  49.4 K/sec
    time            =    30 sec
    send_cost       =   542 ms/GB
    recv_cost       =   542 ms/GB
    send_cpus_used  =   176 % cpus
    recv_cpus_used  =   176 % cpus
udp_bw:
    send_bw         =  2.62 GB/sec
    recv_bw         =  2.37 GB/sec
    msg_rate        =  72.3 K/sec
    time            =    30 sec
    send_cost       =   542 ms/GB
    recv_cost       =   598 ms/GB
    send_cpus_used  =   142 % cpus
    recv_cpus_used  =   142 % cpus
tcp_lat:
    latency        =  17.3 us
    msg_rate       =  57.7 K/sec
    time           =    30 sec
    loc_cpus_used  =   110 % cpus
    rem_cpus_used  =   110 % cpus
udp_lat:
    latency        =  15.4 us
    msg_rate       =  64.8 K/sec
    time           =    30 sec
    loc_cpus_used  =   111 % cpus
    rem_cpus_used  =   111 % cpus
conf:
    loc_node   =  debian-node-02-656868cc46-72lc9
    loc_cpu    =  8 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    loc_os     =  Linux 3.10.0-862.el7.x86_64
    loc_qperf  =  0.4.11
    rem_node   =  debian-node-02-656868cc46-xftvq
    rem_cpu    =  8 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    rem_os     =  Linux 3.10.0-862.el7.x86_64
    rem_qperf  =  0.4.11
```

### 场景二：跨主机 Pod 间通信

`debian-node-02-656868cc46-xftvq` > `debian-node-03-5f554796f4-rflzs`

```ini
root@debian-node-02-656868cc46-xftvq:/# qperf -t 30 100.78.36.72 -v tcp_bw udp_bw tcp_lat udp_lat conf
tcp_bw:
    bw              =  60.1 MB/sec
    msg_rate        =   917 /sec
    time            =    30 sec
    send_cost       =  2.21 sec/GB
    recv_cost       =  6.19 sec/GB
    send_cpus_used  =  13.3 % cpus
    recv_cpus_used  =  37.2 % cpus
udp_bw:
    send_bw         =  3.13 GB/sec
    recv_bw         =  13.3 MB/sec
    msg_rate        =   406 /sec
    time            =    30 sec
    send_cost       =   364 ms/GB
    recv_cost       =  7.73 sec/GB
    send_cpus_used  =   114 % cpus
    recv_cpus_used  =  10.3 % cpus
tcp_lat:
    latency        =   203 us
    msg_rate       =  4.93 K/sec
    time           =    30 sec
    loc_cpus_used  =  19.5 % cpus
    rem_cpus_used  =    17 % cpus
udp_lat:
    latency        =   252 us
    msg_rate       =  3.97 K/sec
    time           =    30 sec
    loc_cpus_used  =  14.9 % cpus
    rem_cpus_used  =  12.9 % cpus
conf:
    loc_node   =  debian-node-02-656868cc46-xftvq
    loc_cpu    =  8 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    loc_os     =  Linux 3.10.0-862.el7.x86_64
    loc_qperf  =  0.4.11
    rem_node   =  debian-node-03-5f554796f4-rflzs
    rem_cpu    =  4 Cores: Intel Core i5-4590 @ 3.30GHz
    rem_os     =  Linux 3.10.0-957.el7.x86_64
    rem_qperf  =  0.4.11
```

### 场景四：Pod 与宿主机间通信

`debian-node-02-5d576b86b6-lfqzm`

```ini
root@debian-node-02-5d576b86b6-lfqzm:/# qperf -t 30 10.20.172.135 -v tcp_bw udp_bw tcp_lat udp_lat conf
tcp_bw:
    bw              =   115 MB/sec
    msg_rate        =  1.75 K/sec
    time            =    30 sec
    send_cost       =  1.12 sec/GB
    recv_cost       =   389 ms/GB
    send_cpus_used  =  12.9 % cpus
    recv_cpus_used  =  4.47 % cpus
udp_bw:
    send_bw         =   4.1 GB/sec
    recv_bw         =   132 KB/sec
    msg_rate        =  4.03 /sec
    time            =    30 sec
    send_cost       =   284 ms/GB
    recv_cost       =  22.7 sec/GB
    send_cpus_used  =   116 % cpus
    recv_cpus_used  =   0.3 % cpus
tcp_lat:
    latency        =   140 us
    msg_rate       =  7.13 K/sec
    time           =    30 sec
    loc_cpus_used  =  17.3 % cpus
    rem_cpus_used  =   4.7 % cpus
udp_lat:
    latency        =   133 us
    msg_rate       =  7.52 K/sec
    time           =    30 sec
    loc_cpus_used  =  18.2 % cpus
    rem_cpus_used  =   4.3 % cpus
conf:
    loc_node   =  debian-node-02-5d576b86b6-lfqzm
    loc_cpu    =  8 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    loc_os     =  Linux 3.10.0-862.el7.x86_64
    loc_qperf  =  0.4.11
    rem_node   =  k8s-node-3
    rem_cpu    =  4 Cores: Intel Core i5-4590 @ 3.30GHz
    rem_os     =  Linux 4.19.0-5-amd64
    rem_qperf  =  0.4.11

```

### 场景五：宿主机与 Pod 之间通信

```ini
╭─root@k8s-node-3 ~
╰─# qperf -t 30 100.107.127.100 -v tcp_bw udp_bw tcp_lat udp_lat conf
tcp_bw:
    bw              =  58.4 MB/sec
    msg_rate        =   891 /sec
    time            =    30 sec
    send_cost       =  1.89 sec/GB
    recv_cost       =  5.52 sec/GB
    send_cpus_used  =  11.1 % cpus
    recv_cpus_used  =  32.2 % cpus
udp_bw:
    send_bw         =   117 MB/sec
    recv_bw         =  12.5 MB/sec
    msg_rate        =   380 /sec
    time            =    30 sec
    send_cost       =  1.54 sec/GB
    recv_cost       =  9.33 sec/GB
    send_cpus_used  =    18 % cpus
    recv_cpus_used  =  11.6 % cpus
tcp_lat:
    latency        =   202 us
    msg_rate       =  4.94 K/sec
    time           =    30 sec
    loc_cpus_used  =  13.2 % cpus
    rem_cpus_used  =  15.8 % cpus
udp_lat:
    latency        =   200 us
    msg_rate       =     5 K/sec
    time           =    30 sec
    loc_cpus_used  =    12 % cpus
    rem_cpus_used  =  15.6 % cpus
conf:
    loc_node   =  k8s-node-3
    loc_cpu    =  4 Cores: Intel Core i5-4590 @ 3.30GHz
    loc_os     =  Linux 3.10.0-957.el7.x86_64
    loc_qperf  =  0.4.9
    rem_node   =  debian-node-02-656868cc46-xftvq
    rem_cpu    =  8 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    rem_os     =  Linux 3.10.0-862.el7.x86_64
    rem_qperf  =  0.4.11

```

### 场景五：Pod 与非宿主机间通信

debian-node-02-656868cc46-72lc9 > k8s-node-3

```ini
root@debian-node-02-656868cc46-72lc9:/# qperf  -t 30 10.20.172.135 -v tcp_bw udp_bw tcp_lat udp_lat conf
tcp_bw:
    bw              =   112 MB/sec
    msg_rate        =  1.71 K/sec
    time            =    30 sec
    send_cost       =  1.09 sec/GB
    recv_cost       =   597 ms/GB
    send_cpus_used  =  12.3 % cpus
    recv_cpus_used  =   6.7 % cpus
udp_bw:
    send_bw         =  4.15 GB/sec
    recv_bw         =   147 KB/sec
    msg_rate        =   4.5 /sec
    time            =    30 sec
    send_cost       =   277 ms/GB
    recv_cost       =  13.6 sec/GB
    send_cpus_used  =   115 % cpus
    recv_cpus_used  =   0.2 % cpus
tcp_lat:
    latency        =   135 us
    msg_rate       =  7.39 K/sec
    time           =    30 sec
    loc_cpus_used  =  16.5 % cpus
    rem_cpus_used  =   4.3 % cpus
udp_lat:
    latency        =   133 us
    msg_rate       =  7.55 K/sec
    time           =    30 sec
    loc_cpus_used  =  16.8 % cpus
    rem_cpus_used  =  4.43 % cpus
conf:
    loc_node   =  debian-node-02-656868cc46-72lc9
    loc_cpu    =  8 Cores: Intel Xeon E3-1271 v3 @ 3.60GHz
    loc_os     =  Linux 3.10.0-862.el7.x86_64
    loc_qperf  =  0.4.11
    rem_node   =  k8s-node-3
    rem_cpu    =  4 Cores: Intel Core i5-4590 @ 3.30GHz
    rem_os     =  Linux 4.19.0-5-amd64
    rem_qperf  =  0.4.11
```
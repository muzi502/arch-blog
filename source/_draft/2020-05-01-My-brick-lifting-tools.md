---
title: 木子的搬砖工具😂
date: 2020-05-11
updated:
slug:
categories: 技术
tag:
  - Linux
  - 搬砖
  - 工具
  - 命令行
copyright: true
comment: true
---

俗话说**好人修电脑，坏人床上搞；电脑修得好，好人当到老。** 作为一名`面向文档编程`的运维工程师，主业也无非就是搓集群搓虚拟机搓镜像，线上环境遇到故障就在 StackOverflow 搬一些 ~~Code~~ 砖来解决问题，帮同事配置一下 CI/CD 流水线，除此之外还要 7*24 小时 on-call。如果进入 IDC 机房的话还要有一身扛 2U 服务器十层楼不换🙋‍♂️本领。

## Linux

确切地来讲 Linux 仅仅是一个操作系统的内核，而且它的代码在一个发行版中的占用率也不到 20%。

### 入门

咱一直觉着学习技术吧，并不是看书看视频能学会的。对于一些底层的只是确实需要仔细研读书籍来吃透他，这趟会让我们对操作系统这个体系结构有更下透彻的认识。但是呢，光看不练还是不行滴，咱学习 Linux 纯靠瞎玩，瞎折腾。咱大学时学校没有开设 Linux 课程，只能靠自己自学。于是乎，和大家一样，搭建 WordPress ，一步步安装 LAMP 环境，配置 iptables，写 shell 脚本备份网站，搭建梯子等等。可谓是玩得不亦乐乎😂。

所以说学习和入门 Linux 咱还是推荐鸟哥的《鸟哥 Linux 私房菜》这本书，结合着自己搭建网站一步步来就可以。

### 放弃

入门完 Linux 之后就开始挑战高难度的啦，比如：

- OpenStack
- Docker
- Kubernetes
- CI/CD

目前来讲在运维这个搬砖行业，kubernetes 云原生无疑是最具有挑战性和前景的，所以如果哈想更近一层楼就不妨学习一下 Docker 和 Kuberneets 这一块。

### 发行版

从运维这个搬砖行业来讲，企业内部使用的 Linux 发行版当属 RedHat 和 Debian 家族的最多，像其他的什么 archlinux 咱还真没见过有在生产环境使用的，毕竟滚动更新不小心就滚挂了不好说😂。国内企业和云计算厂商使用最多的当然是 CentOS 啦，我记得是在 2018 年年末的时候阿里云/腾讯云还没有 Ubuntu 1804 的云主机可用😑。国外使用 Ubuntu 的较多一些，咱是倾向于使用 Ubuntu 😝

从 [datanyze](https://www.datanyze.com) 家偷来一张企业 Linux 市场占有率的统计表格 [Operating Systems](https://www.datanyze.com/market-share/operating-systems--443)😂

| Ranking | Technology                                                   | Domains | Market Share |
| :-----: | :----------------------------------------------------------- | ------: | -----------: |
|    1    | [Ubuntu](https://www.datanyze.com/market-share/operating-systems--443/ubuntu-market-share) | 278,611 |       29.30% |
|    2    | [Unix](https://www.datanyze.com/market-share/operating-systems--443/unix-market-share) | 192,215 |       20.21% |
|    3    | [CentOS](https://www.datanyze.com/market-share/operating-systems--443/centos-market-share) | 165,640 |       17.42% |
|    4    | [Debian](https://www.datanyze.com/market-share/operating-systems--443/debian-market-share) | 108,373 |       11.40% |
|    5    | [Linux](https://www.datanyze.com/market-share/operating-systems--443/linux-market-share) |  24,563 |        2.58% |
|    6    | [Windows Server](https://www.datanyze.com/market-share/operating-systems--443/windows-server-market-share) |  23,872 |        2.51% |
|    7    | [Gentoo](https://www.datanyze.com/market-share/operating-systems--443/gentoo-market-share) |  16,756 |        1.76% |
|    8    | [Red Hat Enterprise Linux](https://www.datanyze.com/market-share/operating-systems--443/red-hat-enterprise-linux-market-share) |  13,659 |        1.44% |
|    9    | [Windows 7](https://www.datanyze.com/market-share/operating-systems--443/windows-7-market-share) |  11,843 |        1.25% |
|   10    | [Microsoft Windows OS](https://www.datanyze.com/market-share/operating-systems--443/microsoft-windows-os-market-share) |  10,986 |        1.16% |

| op Competitors                                               | Websites | Market Share |                                                  Versus Page |
| :----------------------------------------------------------- | -------: | -----------: | -----------------------------------------------------------: |
| [Ubuntu](https://www.datanyze.com/market-share/operating-systems--443/ubuntu-market-share) |  278,611 |       29.30% | [Linux vs. Ubuntu](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-ubuntu) |
| [Unix](https://www.datanyze.com/market-share/operating-systems--443/unix-market-share) |  192,215 |       20.21% | [Linux vs. Unix](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-unix) |
| [CentOS](https://www.datanyze.com/market-share/operating-systems--443/centos-market-share) |  165,640 |       17.42% | [Linux vs. CentOS](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-centos) |
| [Debian](https://www.datanyze.com/market-share/operating-systems--443/debian-market-share) |  108,373 |       11.40% | [Linux vs. Debian](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-debian) |
| [Windows Server](https://www.datanyze.com/market-share/operating-systems--443/windows-server-market-share) |   23,872 |        2.51% | [Linux vs. Windows Server](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-windows-server) |
| [Gentoo](https://www.datanyze.com/market-share/operating-systems--443/gentoo-market-share) |   16,756 |        1.76% | [Linux vs. Gentoo](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-gentoo) |
| [Red Hat Enterprise Linux](https://www.datanyze.com/market-share/operating-systems--443/red-hat-enterprise-linux-market-share) |   13,659 |        1.44% | [Linux vs. Red Hat Enterprise Linux](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-red-hat-enterprise-linux) |
| [Windows 7](https://www.datanyze.com/market-share/operating-systems--443/windows-7-market-share) |   11,843 |        1.25% | [Linux vs. Windows 7](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-windows-7) |
| [Microsoft Windows OS](https://www.datanyze.com/market-share/operating-systems--443/microsoft-windows-os-market-share) |   10,986 |        1.16% | [Linux vs. Microsoft Windows OS](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-microsoft-windows-os) |
| [FreeBSD](https://www.datanyze.com/market-share/operating-systems--443/freebsd-market-share) |    9,633 |        1.01% | [Linux vs. FreeBSD](https://www.datanyze.com/market-share/operating-systems--443/linux-vs-freebsd) |

#### RedHat/CentOS

#### Debian/Ubuntu

咱的 VPS 清一色 Ubuntu 1804 ，主要是省事儿。

## 命令行工具

### 文本处理

提到 Linux 上的文本处理工具当然是离不开三剑客（awk、grep、sed），这也是咱当初跟着《鸟哥 Linux 私房菜》学来的😂。

#### sed

#### awk

#### grep

#### jq

#### tr

#### sort

#### wc

#### join

#### cut

### 系统信息

#### htop

top 黑乎乎的颜值太低了，咱还是喜欢花花绿绿的 htop （大雾

- install

```shell
# RHEL/CentOS
yum install htop

# Debian/Ubuntu
apt install htop
```

![image-20200506142544440](img/image-20200506142544440.png)

### [bashtop](https://github.com/aristocratos/bashtop)

- install

安装起来很简单，其实这是一个 shell 可执行文件，直接使用 curl 或者 wget 命令下载到本地并赋予 +x 权限即可。

```shell
curl -fsSL https://raw.githubusercontent.com/aristocratos/bashtop/master/bashtop -o /usr/bin/bashtop && chmod +x /usr/bin/bashtop
```

国内用户推荐使用 jsdelivr.net 的 CDN 来下载该脚本😑，（fuck GFW by jsdelivr😡

```shell
curl -fsSL https://cdn.jsdelivr.net/gh/aristocratos/bashtop/bashtop  -o /usr/bin/bashtop ;chmod +x /usr/bin/bashtop
```

![image-20200506151706148](img/image-20200506151706148.png)

#### pstree

- install

```shell
# RHEL/CentOS
yum install psmisc

# Debian/Ubuntu
apt install psmisc
```

- output example

```shell
╭─root@k8s-node-3 /proc
╰─# pstree
systemd─┬─agetty
        ├─auditd───{auditd}
        ├─containerd─┬─6*[containerd-shim─┬─pause]
        │            │                    └─9*[{containerd-shim}]]
        │            ├─containerd-shim─┬─kube-proxy───12*[{kube-proxy}]
        │            │                 └─9*[{containerd-shim}]
        │            ├─4*[containerd-shim─┬─pause]
        │            │                    └─10*[{containerd-shim}]]
        │            ├─containerd-shim─┬─lvscare───11*[{lvscare}]
        │            │                 └─10*[{containerd-shim}]
        │            ├─containerd-shim─┬─agent───10*[{agent}]
        │            │                 └─10*[{containerd-shim}]
        │            ├─containerd-shim─┬─runsvdir─┬─runsv───bird6
        │            │                 │          ├─runsv───calico-node───18*[{calico-node}]
        │            │                 │          ├─runsv───calico-node───15*[{calico-node}]
        │            │                 │          └─runsv───bird
        │            │                 └─12*[{containerd-shim}]
        │            ├─containerd-shim─┬─node_exporter───4*[{node_exporter}]
        │            │                 └─10*[{containerd-shim}]
        │            ├─containerd-shim─┬─nginx-proxy─┬─confd───11*[{confd}]
        │            │                 │             └─nginx───nginx
        │            │                 └─9*[{containerd-shim}]
        │            ├─containerd-shim─┬─deploy.sh───sleep
        │            │                 └─10*[{containerd-shim}]
        │            ├─containerd-shim─┬─nginx-ingress─┬─nginx───4*[nginx]
        │            │                 │               └─14*[{nginx-ingress}]
        │            │                 └─10*[{containerd-shim}]
        │            ├─containerd-shim─┬─configmap-reloa───4*[{configmap-reloa}]
        │            │                 └─9*[{containerd-shim}]
        │            ├─containerd-shim─┬─bash
        │            │                 └─9*[{containerd-shim}]
        │            ├─containerd-shim─┬─ruby2.3─┬─ruby2.3───4*[{ruby2.3}]
        │            │                 │         └─11*[{ruby2.3}]
        │            │                 └─10*[{containerd-shim}]
        │            └─46*[{containerd}]
        ├─crond
        ├─dbus-daemon───{dbus-daemon}
        ├─dockerd───25*[{dockerd}]
        ├─gssproxy───5*[{gssproxy}]
        ├─irqbalance
        ├─kubelet───26*[{kubelet}]
        ├─lvmetad
        ├─polkitd───6*[{polkitd}]
        ├─rpc.idmapd
        ├─rpc.mountd
        ├─rpc.statd
        ├─rpcbind
        ├─rsyslogd───2*[{rsyslogd}]
        ├─sshd───sshd───zsh───pstree
        ├─systemd-journal
        ├─systemd-logind
        ├─systemd-udevd
        └─tuned───4*[{tuned}]
```

#### ncdu

使用 `ncdu` 的好处就是可以通过交互式的方式查看目录占用空间的大小，要比 `du -sh` 命令方便很多

- install

```shell
# RHEL/CentOS
yum install ncdu

# Debian/Ubuntu
apt install ncdu
```

- output example

使用反向键和回车键进行目录奇幻，很方便的说😂

```shell
ncdu 1.13 ~ Use the arrow keys to navigate, press ? for help
--- / ------------
    5.2 GiB [##########] /var
    2.2 GiB [####      ] /opt
    2.0 GiB [###       ] /usr
  363.6 MiB [          ] /root
	45.8 MiB [          ] /boot
	45.2 MiB [          ] /run
	 4.6 MiB [          ] /etc
	44.0 KiB [          ] /tmp
	24.0 KiB [          ] /home
e  16.0 KiB [          ] /lost+found
	 8.0 KiB [          ] /media
e   4.0 KiB [          ] /srv
e   4.0 KiB [          ] /mnt
.   0.0   B [          ] /proc
	 0.0   B [          ] /sys
	 0.0   B [          ] /dev
@   0.0   B [          ]  initrd.img.old
@   0.0   B [          ]  initrd.img
@   0.0   B [          ]  vmlinuz.old
@   0.0   B [          ]  vmlinuz
@   0.0   B [          ]  libx32
@   0.0   B [          ]  lib64
@   0.0   B [          ]  lib32
@   0.0   B [          ]  sbin

ncdu 1.13 ~ Use the arrow keys to navigate, press ? for help
--- /var --------------
	 3.5 GiB [##########] /lib
	 1.4 GiB [####      ] /opt
  156.9 MiB [          ] /cache
	79.6 MiB [          ] /log
	 1.8 MiB [          ] /backups
	20.0 KiB [          ] /tmp
	16.0 KiB [          ] /spool
e   4.0 KiB [          ] /mail
e   4.0 KiB [          ] /local
@   0.0   B [          ]  lock
@   0.0   B [          ]  run
```

- G/GB

> The SIZE argument is an integer and optional unit (example: 10K is 10*1024). Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).

#### nload

- install

```shell
# RHEL/CentOS
yum install nload

# Debian/Ubuntu
apt install nload
```

- output example

按下回车键可以切换不同的网卡

![image-20200506143310955](img/image-20200506143310955.png)

### ls 兄弟们

```bash
╭─root@gitlab /opt
╰─# ls
ls           lsblk        LS_COLORS    lsinitramfs  lslogins     lsns         lspgpot
lsa          lsb_release  lscpu        lsipc        lsmem        lsof
lsattr       LSCOLORS     lshw         lslocks      lsmod        lspci
```

#### ls

> ls - list directory contents 列出文件夹内容

#### lsattr

> lsattr - list file attributes on a Linux second extended file system

#### lsblk

> lsblk - list block devices 列出块设备

```bash
╭─root@gitlab /opt
╰─# lsblk
NAME                      MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda                         8:0    0  30G  0 disk
├─sda1                      8:1    0   1M  0 part
├─sda2                      8:2    0   1G  0 part /boot
└─sda3                      8:3    0  29G  0 part
  └─ubuntu--vg-ubuntu--lv 253:0    0  28G  0 lvm  /
```

#### lsb_release

> lsb_release - print distribution-specific information 打印发行版详情

#### lscpu

> lscpu - display information about the CPU architecture

`lscpu`

```yaml
╭─root@gitlab /opt
╰─# lscpu
Architecture:        x86_64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Little Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           4
NUMA node(s):        1
Vendor ID:           GenuineIntel
CPU family:          6
Model:               60
Model name:          Intel(R) Xeon(R) CPU E3-1271 v3 @ 3.60GHz
Stepping:            3
CPU MHz:             3591.683
BogoMIPS:            7183.36
Hypervisor vendor:   VMware
Virtualization type: full
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            8192K
NUMA node0 CPU(s):   0-3
Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc cpuid aperfmperf pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault epb invpcid_single pti fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid xsaveopt dtherm ida arat pln pts
```

`cat /proc/cpuinfo`

```yaml
╭─root@gitlab /opt
╰─# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 60
model name      : Intel(R) Xeon(R) CPU E3-1271 v3 @ 3.60GHz
stepping        : 3
microcode       : 0x1c
cpu MHz         : 3591.683
cache size      : 8192 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc cpuid aperfmperf pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault epb invpcid_single pti fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid xsaveopt dtherm ida arat pln pts
bugs            : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs
bogomips        : 7183.36
clflush size    : 64
cache_alignment : 64
address sizes   : 42 bits physical, 48 bits virtual
power management:
```

#### lshw

```bash
lshw - list hardware 列出硬件设备
lshw is a small tool to extract detailed information on the hardware configuration of the machine. It  can report exact memory configuration, firmware version, mainboard configuration, CPU version and speed, cache configuration, bus speed, etc. on DMI-capable x86 or IA-64 systems and on some PowerPC machines  (PowerMac G4 is known to work).It  currently  supports  DMI (x86 and IA-64 only), OpenFirmware device tree (PowerPC only), PCI/AGP, CPUID (x86), IDE/ATA/ATAPI, PCMCIA (only tested on x86), SCSI and USB.
```

#### lsinitramfs

> lsinitramfs - list content of an initramfs image
>
> The  lsinitramfs  command  lists the content of given initramfs images. It allows one to quickly check the content of one (or multiple) specified initramfs files.

```bash
╭─root@gitlab /opt
╰─# lsinitramfs /boot/initrd.img-4.15.0-58-generic | head -n 10
.
usr
usr/share
usr/share/plymouth
usr/share/plymouth/themes
usr/share/plymouth/themes/details
usr/share/plymouth/themes/details/details.plymouth
usr/share/plymouth/themes/text.plymouth
usr/share/plymouth/themes/ubuntu-text
usr/share/plymouth/themes/ubuntu-text/ubuntu-text.plymouth.in
```

#### lsipc

> lsipc - show information on IPC facilities currently employed in the system
>
> lsipc  shows  information  on the inter-process communication facilities for which the calling process has read access.

```bash
╭─root@gitlab /opt
╰─# lsipc
RESOURCE DESCRIPTION                                     LIMIT USED  USE%
MSGMNI   Number of message queues                        32000    0 0.00%
MSGMAX   Max size of message (bytes)                      8192    -     -
MSGMNB   Default max size of queue (bytes)               16384    -     -
SHMMNI   Shared memory segments                           4096    1 0.02%
SHMALL   Shared memory pages                           4194304    0 0.00%
SHMMAX   Max size of shared memory segment (bytes) 17179869184    -     -
SHMMIN   Min size of shared memory segment (bytes)           1    -     -
SEMMNI   Number of semaphore identifiers                   262    0 0.00%
SEMMNS   Total number of semaphores                      32000    0 0.00%
SEMMSL   Max semaphores per semaphore set.                 250    -     -
SEMOPM   Max number of operations per semop(2)              32    -     -
SEMVMX   Semaphore max value                             32767    -     -
```

#### lslocks

> lslocks - list local system locks
>
> lslocks lists information about all the currently held file locks in a Linux system

```bash
╭─root@gitlab /opt
╰─# lslocks
COMMAND           PID  TYPE SIZE MODE  M START END PATH
cron              900 FLOCK   4B WRITE 0     0   0 /run/crond.pid
svlogd          53065 FLOCK   0B WRITE 0     0   0 /var/log/gitlab/redis/lock
runsv           54095 FLOCK   0B WRITE 0     0   0 /opt/gitlab/sv/sidekiq/supervise/lock
runsv           54095 FLOCK   0B WRITE 0     0   0 /opt/gitlab/sv/sidekiq/log/supervise/lock
```

#### lslogins

> lslogins - display information about known users in the system
>
> Examine the wtmp and btmp logs, /etc/shadow (if necessary) and /etc/passwd and output the desired data. The default action is to list info about all the users in the system.

```bash
╭─root@gitlab /opt
╰─# lslogins
  UID USER              PROC PWD-LOCK PWD-DENY LAST-LOGIN GECOS
	 0 root               211        0        0      06:58 root
	 1 daemon               1        0        1            daemon
	 2 bin                  0        0        1            bin
	 3 sys                  0        0        1            sys
	 4 sync                 0        0        1            sync
	 5 games                0        0        1            games
	 6 man                  0        0        1            man
	 7 lp                   0        0        1            lp
	 8 mail                 0        0        1            mail
	 9 news                 0        0        1            news
	10 uucp                 0        0        1            uucp
	13 proxy                0        0        1            proxy
	33 www-data             0        0        1            www-data
	34 backup               0        0        1            backup
	38 list                 0        0        1            Mailing List Manager
	39 irc                  0        0        1            ircd
	41 gnats                0        0        1            Gnats Bug-Reporting System (admin)
  100 systemd-network      1        0        1            systemd Network Management,,,
  101 systemd-resolve      1        0        1            systemd Resolver,,,
  102 syslog               1        0        1
  103 messagebus           1        0        1
  104 _apt                 0        0        1
  105 lxd                  0        0        1
  106 uuidd                0        0        1
  107 dnsmasq              0        0        1            dnsmasq,,,
  108 landscape            0        0        1
  109 pollinate            0        0        1
  110 sshd                 0        0        1
  995 gitlab-prometheus    4        0        1
  996 gitlab-psql         18        0        1
  997 gitlab-redis         2        0        1
  998 git                 16        0        1
  999 gitlab-www           5        0        1
 1000 ubuntu               0        0        0 2019-Aug28 ubuntu
65534 nobody               0        0        1            nobody
```

#### lsmem

> lsmem - list the ranges of available memory with their online status
>
> The  lsmem command lists the ranges of available memory with their online status. The listed memory blocks correspond to the memory block representation in sysfs. The command also shows the memory block  size  and the amount of memory in online and offline state.

```bash
╭─root@gitlab /opt
╰─# lsmem                                                                                                     127 ↵
RANGE                                  SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x0000000007ffffff  128M online        no     0
0x0000000008000000-0x000000000fffffff  128M online       yes     1
0x0000000010000000-0x000000001fffffff  256M online        no   2-3
0x0000000020000000-0x0000000027ffffff  128M online       yes     4
0x0000000028000000-0x0000000037ffffff  256M online        no   5-6
0x0000000038000000-0x000000003fffffff  128M online       yes     7
0x0000000040000000-0x000000006fffffff  768M online        no  8-13
0x0000000070000000-0x0000000077ffffff  128M online       yes    14
0x0000000078000000-0x00000000bfffffff  1.1G online        no 15-23
0x0000000100000000-0x000000013fffffff    1G online        no 32-39

Memory block size:       128M
Total online memory:       4G
Total offline memory:      0B
```

#### lsmod

> lsmod - Show the status of modules in the Linux Kernel

```bash
╭─root@gitlab /opt
╰─# lsmod
Module                  Size  Used by
tcp_diag               16384  0
inet_diag              24576  1 tcp_diag
joydev                 24576  0
input_leds             16384  0
vmw_balloon            20480  0
serio_raw              16384  0
vmw_vsock_vmci_transport    28672  1
vsock                  36864  2 vmw_vsock_vmci_transport
vmw_vmci               69632  2 vmw_balloon,vmw_vsock_vmci_transport
sch_fq_codel           20480  5
ib_iser                49152  0
rdma_cm                61440  1 ib_iser
iw_cm                  45056  1 rdma_cm
ib_cm                  53248  1 rdma_cm
ib_core               225280  4 rdma_cm,iw_cm,ib_iser,ib_cm
iscsi_tcp              20480  0
libiscsi_tcp           20480  1 iscsi_tcp
libiscsi               53248  3 libiscsi_tcp,iscsi_tcp,ib_iser
scsi_transport_iscsi    98304  3 iscsi_tcp,ib_iser,libiscsi
ip_tables              28672  0
x_tables               40960  1 ip_tables
autofs4                40960  2
btrfs                1130496  0
zstd_compress         163840  1 btrfs
raid10                 53248  0
raid456               143360  0
async_raid6_recov      20480  1 raid456
async_memcpy           16384  2 raid456,async_raid6_recov
async_pq               16384  2 raid456,async_raid6_recov
async_xor              16384  3 async_pq,raid456,async_raid6_recov
async_tx               16384  5 async_pq,async_memcpy,async_xor,raid456,async_raid6_recov
xor                    24576  2 async_xor,btrfs
raid6_pq              114688  4 async_pq,btrfs,raid456,async_raid6_recov
libcrc32c              16384  1 raid456
raid1                  40960  0
raid0                  20480  0
multipath              16384  0
linear                 16384  0
crct10dif_pclmul       16384  0
crc32_pclmul           16384  0
ghash_clmulni_intel    16384  0
pcbc                   16384  0
vmwgfx                274432  1
ttm                   106496  1 vmwgfx
drm_kms_helper        172032  1 vmwgfx
aesni_intel           188416  0
syscopyarea            16384  1 drm_kms_helper
aes_x86_64             20480  1 aesni_intel
sysfillrect            16384  1 drm_kms_helper
crypto_simd            16384  1 aesni_intel
sysimgblt              16384  1 drm_kms_helper
glue_helper            16384  1 aesni_intel
fb_sys_fops            16384  1 drm_kms_helper
cryptd                 24576  3 crypto_simd,ghash_clmulni_intel,aesni_intel
psmouse               147456  0
drm                   401408  4 vmwgfx,drm_kms_helper,ttm
mptspi                 24576  2
mptscsih               40960  1 mptspi
mptbase               102400  2 mptspi,mptscsih
ahci                   40960  0
libahci                32768  1 ahci
i2c_piix4              24576  0
vmxnet3                57344  0
scsi_transport_spi     32768  1 mptspi
pata_acpi              16384  0
```

#### lsns - list namespaces

lsns  lists  information  about all the currently accessible namespaces or about the given namespace.  The namespace identifier is an inode number.

```bash
╭─root@gitlab /opt
╰─# lsns
		  NS TYPE   NPROCS   PID USER             COMMAND
4026531835 cgroup    264     1 root             /lib/systemd/systemd --system --deserialize 39
4026531836 pid       264     1 root             /lib/systemd/systemd --system --deserialize 39
4026531837 user      264     1 root             /lib/systemd/systemd --system --deserialize 39
4026531838 uts       264     1 root             /lib/systemd/systemd --system --deserialize 39
4026531839 ipc       264     1 root             /lib/systemd/systemd --system --deserialize 39
4026531840 mnt       259     1 root             /lib/systemd/systemd --system --deserialize 39
4026531861 mnt         1    31 root             kdevtmpfs
4026531993 net       264     1 root             /lib/systemd/systemd --system --deserialize 39
4026532531 mnt         1 37609 root             /lib/systemd/systemd-udevd
4026532556 mnt         1 42954 systemd-timesync /lib/systemd/systemd-timesyncd
4026532557 mnt         1 42900 systemd-network  /lib/systemd/systemd-networkd
4026532603 mnt         1 42924 systemd-resolve  /lib/systemd/systemd-resolved
```

#### lsof - list open files

#### lspci - list all PCI devices

> lspci is a utility for displaying information about PCI buses in the system and devices connected to them.

```bash
╭─root@gitlab /opt
╰─# lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 01)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 01)
00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 08)
00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 08)
00:07.7 System peripheral: VMware Virtual Machine Communication Interface (rev 10)
00:0f.0 VGA compatible controller: VMware SVGA II Adapter
00:10.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
00:11.0 PCI bridge: VMware PCI bridge (rev 02)
```

#### lspgpot

> lspgpot - extracts the ownertrust values from PGP keyrings and list them in GnuPG ownertrust format.

```shell
╭─root@sg-02 /home/ubuntu
╰─# lshw
sg-02
	 description: Computer
	 product: HVM domU
	 vendor: Xen
	 version: 4.2.amazon
	 serial: ec2c5773-d127-c5a4-60a3-221becf4e6ae
	 width: 64 bits
	 capabilities: smbios-2.7 dmi-2.7 vsyscall32
	 configuration: boot=normal uuid=73572CEC-27D1-A4C5-60A3-221BECF4E6AE
  *-core
		 description: Motherboard
		 physical id: 0
	  *-firmware
			 description: BIOS
			 vendor: Xen
			 physical id: 0
			 version: 4.2.amazon
			 date: 08/24/2006
			 size: 96KiB
			 capabilities: pci edd
	  *-cpu
			 description: CPU
			 product: Intel(R) Xeon(R) CPU E5-2676 v3 @ 2.40GHz
			 vendor: Intel Corp.
			 physical id: 401
			 bus info: cpu@0
			 slot: CPU 1
			 size: 2400MHz
			 capacity: 2400MHz
			 width: 64 bits
			 capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp x86-64 constant_tsc rep_good nopl xtopology cpuid pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti fsgsbase bmi1 avx2 smep bmi2 erms invpcid xsaveopt
	  *-memory
			 description: System Memory
			 physical id: 1000
			 size: 1GiB
			 capacity: 1GiB
			 capabilities: ecc
			 configuration: errordetection=multi-bit-ecc
		  *-bank
				 description: DIMM RAM
				 physical id: 0
				 slot: DIMM 0
				 size: 1GiB
				 width: 64 bits
	  *-pci
			 description: Host bridge
			 product: 440FX - 82441FX PMC [Natoma]
			 vendor: Intel Corporation
			 physical id: 100
			 bus info: pci@0000:00:00.0
			 version: 02
			 width: 32 bits
			 clock: 33MHz
		  *-isa
				 description: ISA bridge
				 product: 82371SB PIIX3 ISA [Natoma/Triton II]
				 vendor: Intel Corporation
				 physical id: 1
				 bus info: pci@0000:00:01.0
				 version: 00
				 width: 32 bits
				 clock: 33MHz
				 capabilities: isa bus_master
				 configuration: latency=0
		  *-ide
				 description: IDE interface
				 product: 82371SB PIIX3 IDE [Natoma/Triton II]
				 vendor: Intel Corporation
				 physical id: 1.1
				 bus info: pci@0000:00:01.1
				 version: 00
				 width: 32 bits
				 clock: 33MHz
				 capabilities: ide bus_master
				 configuration: driver=ata_piix latency=64
				 resources: irq:0 ioport:1f0(size=8) ioport:3f6 ioport:170(size=8) ioport:376 ioport:c100(size=16)
		  *-bridge UNCLAIMED
				 description: Bridge
				 product: 82371AB/EB/MB PIIX4 ACPI
				 vendor: Intel Corporation
				 physical id: 1.3
				 bus info: pci@0000:00:01.3
				 version: 01
				 width: 32 bits
				 clock: 33MHz
				 capabilities: bridge bus_master
				 configuration: latency=0
		  *-display UNCLAIMED
				 description: VGA compatible controller
				 product: GD 5446
				 vendor: Cirrus Logic
				 physical id: 2
				 bus info: pci@0000:00:02.0
				 version: 00
				 width: 32 bits
				 clock: 33MHz
				 capabilities: vga_controller bus_master
				 configuration: latency=0
				 resources: memory:f0000000-f1ffffff memory:f3000000-f3000fff memory:c0000-dffff
		  *-generic
				 description: Unassigned class
				 product: Xen Platform Device
				 vendor: XenSource, Inc.
				 physical id: 3
				 bus info: pci@0000:00:03.0
				 version: 01
				 width: 32 bits
				 clock: 33MHz
				 capabilities: bus_master
				 configuration: driver=xen-platform-pci latency=0
				 resources: irq:28 ioport:c000(size=256) memory:f2000000-f2ffffff
  *-network:0
		 description: Ethernet interface
		 physical id: 1
		 logical name: eth0
		 serial: 02:24:d2:49:f2:94
		 capabilities: ethernet physical
		 configuration: broadcast=yes driver=vif ip=172.26.17.53 link=yes multicast=yes
  *-network:1
		 description: Ethernet interface
		 physical id: 2
		 logical name: docker0
		 serial: 02:42:37:cf:cf:aa
		 capabilities: ethernet physical
		 configuration: broadcast=yes driver=bridge driverversion=2.3 firmware=N/A ip=172.17.0.1 link=no multicast=yes
╭─root@sg-02 /home/ubuntu
╰─#
```

### proc

确切来说这并不是一个工具，而是 Linux 的内存文件系统，它可以帮助我们了解一些系统信息，方便排查一些故障等。

#### CPU

`cat /proc/cpuinfo` 和 `lscpu`

```yaml
[root@k8s-master-01 ~]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 60
model name      : Intel(R) Xeon(R) CPU E3-1271 v3 @ 3.60GHz
stepping        : 3
microcode       : 0x1c
cpu MHz         : 3591.683
cache size      : 8192 KB
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc aperfmperf eagerfpu pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm epb fsgsbase tsc_adjust bmi1 avx2 smep bmi2 invpcid xsaveopt dtherm ida arat pln pts
bogomips        : 7183.36
clflush size    : 64
cache_alignment : 64
address sizes   : 42 bits physical, 48 bits virtual
power management:
```

#### RAM

```yaml
[root@k8s-master-01 proc]# cat meminfo
MemTotal:        3863636 kB
MemFree:          247016 kB
MemAvailable:    2096628 kB
Buffers:           85612 kB
Cached:          1952072 kB
SwapCached:            0 kB
Active:          2250028 kB
Inactive:        1003588 kB
Active(anon):    1224120 kB
Inactive(anon):    21344 kB
Active(file):    1025908 kB
Inactive(file):   982244 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:               128 kB
Writeback:             0 kB
AnonPages:       1215816 kB
Mapped:           196080 kB
Shmem:             29532 kB
Slab:             222544 kB
SReclaimable:      92156 kB
SUnreclaim:       130388 kB
KernelStack:       15904 kB
PageTables:        13024 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     1931816 kB
Committed_AS:    7402668 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      187276 kB
VmallocChunk:   34359310332 kB
HardwareCorrupted:     0 kB
AnonHugePages:    264192 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      206720 kB
DirectMap2M:     3987456 kB
DirectMap1G:     2097152 kB
```

#### net

- arp

```shell
╭─root@k8s-node-3 /proc/net
╰─# cat arp
IP address       HW type     Flags       HW address            Mask     Device
169.254.169.254  0x1         0x0         00:00:00:00:00:00     *        ens160
100.78.36.67     0x1         0x2         ee:25:17:a5:e9:3b     *        cali35f7ecfd8a4
10.20.172.212    0x1         0x2         00:0c:29:16:f5:1f     *        ens160
100.78.36.65     0x1         0x2         d6:80:af:8a:22:c7     *        calid838acfbeda
10.20.172.1      0x1         0x2         00:00:5e:00:01:3a     *        ens160
10.20.172.102    0x1         0x2         00:21:91:53:e8:a3     *        ens160
10.20.172.254    0x1         0x2         5c:dd:70:05:e8:53     *        ens160
10.20.172.106    0x1         0x2         98:90:96:d0:86:8a     *        ens160
```

- route

```shell
╭─root@k8s-node-3 ~
╰─# cat /proc/net/fib_trie
Main:
  +-- 0.0.0.0/0 3 1 5
	  +-- 0.0.0.0/4 2 0 2
		  |-- 0.0.0.0
			  /0 universe UNICAST
		  +-- 10.0.0.0/9 2 0 2
			  +-- 10.20.172.0/24 2 1 2
				  |-- 10.20.172.0
					  /32 link BROADCAST
					  /24 link UNICAST
				  +-- 10.20.172.192/26 2 0 2
					  |-- 10.20.172.211
						  /32 host LOCAL
					  |-- 10.20.172.255
						  /32 link BROADCAST
			  +-- 10.96.0.0/12 4 1 7
				  +-- 10.96.0.0/16 2 0 1
					  +-- 10.96.0.0/28 2 0 2
						  |-- 10.96.0.1
							  /32 host LOCAL
						  |-- 10.96.0.10
							  /32 host LOCAL
					  |-- 10.96.94.140
						  /32 host LOCAL
					  |-- 10.96.130.114
						  /32 host LOCAL
				  |-- 10.99.89.188
					  /32 host LOCAL
				  |-- 10.101.71.131
					  /32 host LOCAL
				  |-- 10.104.241.211
					  /32 host LOCAL
				  |-- 10.107.246.53
					  /32 host LOCAL
				  |-- 10.108.171.54
					  /32 host LOCAL
				  |-- 10.109.20.145
					  /32 host LOCAL
				  |-- 10.110.206.28
					  /32 host LOCAL
				  |-- 10.111.25.53
					  /32 host LOCAL
	  +-- 96.0.0.0/3 2 0 2
		  +-- 100.64.0.0/10 3 0 3
			  +-- 100.78.36.64/26 3 0 6
				  +-- 100.78.36.64/30 2 0 0
					  |-- 100.78.36.64
						  /32 host LOCAL
						  /32 link BROADCAST
						  /26 universe BLACKHOLE
					  |-- 100.78.36.65
						  /32 link UNICAST
					  |-- 100.78.36.66
						  /32 link UNICAST
					  |-- 100.78.36.67
						  /32 link UNICAST
				  |-- 100.78.36.105
					  /32 link UNICAST
			  |-- 100.87.114.192
				  /26 universe UNICAST
			  |-- 100.107.127.64
				  /26 universe UNICAST
			  |-- 100.112.151.128
				  /26 universe UNICAST
			  |-- 100.123.190.192
				  /26 universe UNICAST
		  +-- 127.0.0.0/8 2 0 2
			  +-- 127.0.0.0/31 1 0 0
				  |-- 127.0.0.0
					  /32 link BROADCAST
					  /8 host LOCAL
				  |-- 127.0.0.1
					  /32 host LOCAL
			  |-- 127.255.255.255
				  /32 link BROADCAST
	  +-- 168.0.0.0/5 2 0 2
		  |-- 169.254.0.0
			  /16 link UNICAST
		  +-- 172.16.0.0/14 3 0 6
			  +-- 172.17.0.0/31 1 0 0
				  |-- 172.17.0.0
					  /32 link BROADCAST
					  /16 link UNICAST
				  |-- 172.17.0.1
					  /32 host LOCAL
			  |-- 172.17.255.255
				  /32 link BROADCAST
```

- nf_conntrack

```shell
╭─root@k8s-node-3 /proc/net
╰─# cat nf_conntrack | head -n 4
ipv4     2 tcp      6 102 SYN_SENT src=10.20.172.211 dst=10.10.107.214 sport=42562 dport=179 [UNREPLIED] src=10.10.107.214 dst=10.20.172.211 sport=179 dport=42562 mark=0 secctx=system_u:object_r:unlabeled_t:s0 zone=0 use=2
ipv4     2 tcp      6 79 SYN_SENT src=10.20.172.211 dst=10.10.107.214 sport=60579 dport=179 [UNREPLIED] src=10.10.107.214 dst=10.20.172.211 sport=179 dport=60579 mark=0 secctx=system_u:object_r:unlabeled_t:s0 zone=0 use=2
ipv4     2 tcp      6 86366 ESTABLISHED src=10.20.172.211 dst=10.10.107.121 sport=58589 dport=179 src=10.10.107.121 dst=10.20.172.211 sport=179 dport=58589 [ASSURED] mark=0 secctx=system_u:object_r:unlabeled_t:s0 zone=0 use=2
ipv4     2 tcp      6 62 SYN_SENT src=10.20.172.211 dst=10.10.107.214 sport=37531 dport=179 [UNREPLIED] src=10.10.107.214 dst=10.20.172.211 sport=179 dport=37531 mark=0 secctx=system_u:object_r:unlabeled_t:s0 zone=0 use=2
```

#### kernel

```shell
[root@k8s-master-01 proc]# uname -a
Linux k8s-master-01 3.10.0-862.el7.x86_64 #1 SMP Fri Apr 20 16:44:24 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@k8s-master-01 proc]# cat version
Linux version 3.10.0-862.el7.x86_64 (builder@kbuilder.dev.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-28) (GCC) ) #1 SMP Fri Apr 20 16:44:24 UTC 2018
```

### 网络

#### nc netcat

#### nmap

### 测试

#### [fio](https://github.com/axboe/fio)

- install

```shell
# RHEL/CentOS
yum install fio

# Debian/Ubuntu
apt install fio
```

- usage

```ini
filename=/tmp        # 测试文件名称，通常选择需要测试的盘的 data 目录
direct=1             # 测试过程绕过机器自带的 buffer。使测试结果更真实
rw=randwrite         # 测试随机写的 I/O
rw=randrw            # 测试随机写和读的 I/O
bs=16k               # 单次 io 的块文件大小为 16k
bsrange=512-2048     # 同上，提定数据块的大小范围
size=5G              # 本次的测试文件大小为 5g，以每次 4k 的 io 进行测试
numjobs=30           # 本次的测试线程为 30 个
runtime=1000         # 测试时间 1000 秒，如果不写则一直将 5g 文件分 4k 每次写完为止
ioengine=psync       #io 引擎使用 psync 方式
rwmixwrite=30        # 在混合读写的模式下，写占 30%
group_reporting      # 关于显示结果的，汇总每个进程的信息

lockmem=1G           # 只使用 1g 内存进行测试s
zero_buffers         # 用 0 初始化系统 buffer
nrfiles=8            # 每个进程生成文件的数量
```

`注意：` 只要不是测试空盘，`filename` 参数千万不要使用类似 `/dev/sda` 这无异于删库跑路😂。所以推荐使用路径而不是设备。

- output example

```shell
╭─root@nfs ~
╰─# fio -filename=/tmp/test.file -direct=1 -iodepth 1 -thread -rw=randrw -rwmixread=70 -ioengine=psync -bs=16k -size=1G -numjobs=30 -runtime=100 -group_reporting -name=mytest1
mytest1: (g=0): rw=randrw, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
...
fio-3.7
Starting 30 threads
mytest1: Laying out IO file (1 file / 1024MiB)
Jobs: 30 (f=30): [m(30)][100.0%][r=1265KiB/s,w=560KiB/s][r=79,w=35 IOPS][eta 00m:00s]
mytest1: (groupid=0, jobs=30): err= 0: pid=45930: Mon Apr 27 23:09:21 2020
	read: IOPS=71, BW=1149KiB/s (1177kB/s)(113MiB/100321msec)
	 clat (usec): min=349, max=999812, avg=292473.60, stdev=188905.70
	  lat (usec): min=349, max=999813, avg=292473.83, stdev=188905.69
	 clat percentiles (msec):
	  |  1.00th=[    5],  5.00th=[    8], 10.00th=[   11], 20.00th=[   24],
	  | 30.00th=[  247], 40.00th=[  313], 50.00th=[  342], 60.00th=[  372],
	  | 70.00th=[  401], 80.00th=[  430], 90.00th=[  481], 95.00th=[  542],
	  | 99.00th=[  751], 99.50th=[  818], 99.90th=[  894], 99.95th=[  936],
	  | 99.99th=[ 1003]
	bw (  KiB/s): min=   31, max=   96, per=3.53%, avg=40.55, stdev=14.30, samples=5661
	iops        : min=    1, max=    6, avg= 2.48, stdev= 0.93, samples=5661
  write: IOPS=30, BW=483KiB/s (494kB/s)(47.3MiB/100321msec)
	 clat (msec): min=2, max=937, avg=297.02, stdev=194.75
	  lat (msec): min=2, max=937, avg=297.02, stdev=194.75
	 clat percentiles (msec):
	  |  1.00th=[    5],  5.00th=[    9], 10.00th=[   11], 20.00th=[   16],
	  | 30.00th=[  266], 40.00th=[  326], 50.00th=[  355], 60.00th=[  380],
	  | 70.00th=[  405], 80.00th=[  435], 90.00th=[  481], 95.00th=[  550],
	  | 99.00th=[  760], 99.50th=[  810], 99.90th=[  902], 99.95th=[  927],
	  | 99.99th=[  936]
	bw (  KiB/s): min=   31, max=  256, per=9.65%, avg=46.52, stdev=25.43, samples=2071
	iops        : min=    1, max=   16, avg= 2.85, stdev= 1.61, samples=2071
  lat (usec)   : 500=0.02%, 750=0.02%
  lat (msec)   : 4=0.28%, 10=8.53%, 20=10.86%, 50=6.42%, 100=0.90%
  lat (msec)   : 250=2.90%, 500=62.21%, 750=6.79%, 1000=1.06%
  cpu          : usr=0.00%, sys=0.01%, ctx=19413, majf=0, minf=7
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
	  submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
	  complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
	  issued rwts: total=7204,3026,0,0 short=0,0,0,0 dropped=0,0,0,0
	  latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
	READ: bw=1149KiB/s (1177kB/s), 1149KiB/s-1149KiB/s (1177kB/s-1177kB/s), io=113MiB (118MB), run=100321-100321msec
  WRITE: bw=483KiB/s (494kB/s), 483KiB/s-483KiB/s (494kB/s-494kB/s), io=47.3MiB (49.6MB), run=100321-100321msec

Disk stats (read/write):
	 dm-0: ios=7750/3320, merge=0/0, ticks=200950/123253, in_queue=324237, util=99.83%, aggrios=7765/3135, aggrmerge=0/192, aggrticks=201237/111717, aggrin_queue=312951, aggrutil=99.81%
  sda: ios=7765/3135, merge=0/192, ticks=201237/111717, in_queue=312951, util=99.81%
```

#### qperf

- install

```shell
yum install qperf
apt install qperf
```

- usage

```shell
╭─root@debian /opt/trojan
╰─# qperf --help examples
In these examples, we first run qperf on a node called myserver in server
mode by invoking it with no arguments.  In all the subsequent examples, we
run qperf on another node and connect to the server which we assume has a
hostname of myserver.
	 * To run a TCP bandwidth and latency test:
		  qperf myserver tcp_bw tcp_lat
	 * To run a SDP bandwidth test for 10 seconds:
		  qperf myserver -t 10 sdp_bw
	 * To run a UDP latency test and then cause the server to terminate:
		  qperf myserver udp_lat quit
	 * To measure the RDMA UD latency and bandwidth:
		  qperf myserver ud_lat ud_bw
	 * To measure RDMA UC bi-directional bandwidth:
		  qperf myserver rc_bi_bw
	 * To get a range of TCP latencies with a message size from 1 to 64K
		  qperf myserver -oo msg_size:1:64K:*2 -vu tcp_lat
```

- output example

```shell
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

#### iperf

- install

- usage

- output example

#### [wrk](https://github.com/wg/wrk/)

- install

```shell
git clone https://github.com/wg/wrk.git --depth=1
cd wrk
make
```

- usage

```shell
./wrk
Usage: wrk <options> <url>
  Options:
	 -c, --connections <N>  Connections to keep open 需要模拟的个并发请求连接数量
	 -d, --duration    <T>  Duration of test 测试的测试时长
	 -t, --threads     <N>  Number of threads to use 并发线程数量
	 -s, --script      <S>  Load Lua script file  指定 Lua 脚本的路径
	 -H, --header      <H>  Add header to request 指定请求带的 Header 参数
		  --latency          Print latency statistics 是否打印请求延迟统计
		  --timeout     <T>  Socket/request timeout 设置请求超时时间

```

- output example

```shell
# 对 10.20.172.196 nginx 服务器进行测试
╭─root@test ~/wrk ‹master›
╰─# ./wrk -t100 -c512 -d30s http://10.20.172.196
Running 30s test @ http://10.20.172.196
  100 threads and 512 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
	 Latency    44.71ms  108.75ms   1.99s    89.05%
	 Req/Sec   369.78    207.57     1.68k    71.50%
  987158 requests in 30.10s, 840.66MB read
  Socket errors: connect 0, read 0, write 0, timeout 22
Requests/sec:  32797.65
Transfer/sec:     27.93MB
# 测试结果，基本能达到 3W+ 的 QPS 的性能
```

#### httperf

- install

- usage

- output example

```shell
╭─root@ubuntu-238 ~
╰─# httperf --server 10.20.172.196 --port 80 --num-conns 100 --rate 10 --timeout 1
httperf --timeout=1 --client=0/1 --server=10.20.172.196 --port=80 --uri=/ --rate=10 --send-buffer=4096 --recv-buffer=16384 --num-conns=100 --num-calls=1
httperf: warning: open file limit > FD_SETSIZE; limiting max. # of open files to FD_SETSIZE
Maximum connect burst length: 1
# 响应速率
Total: connections 100 requests 100 replies 100 test-duration 9.900 s
Connection rate: 10.1 conn/s (99.0 ms/conn, <=1 concurrent connections)
Connection time [ms]: min 0.1 avg 0.1 max 0.2 median 0.5 stddev 0.0
Connection time [ms]: connect 0.0
Connection length [replies/conn]: 1.000
Request rate: 10.1 req/s (99.0 ms/req)
Request size [B]: 66.0
# 服务器从请求中接收到第一个字节开始，到连接收到第一个字节所消耗的时间
Reply rate [replies/s]: min 10.0 avg 10.0 max 10.0 stddev 0.0 (1 samples)
Reply time [ms]: response 0.1 transfer 0.0
# 统计每个回复的大小，每个维度的单位都是字节(bytes),且都是平均数
Reply size [B]: header 244.0 content 649.0 footer 0.0 (total 893.0)
Reply status: 1xx=0 2xx=100 3xx=0 4xx=0 5xx=0
# 客户端CPU使用率的统计，User用户模式，System模式
CPU time [s]: user 3.85 system 6.05 (user 38.9% system 61.1% total 100.0%)
# 网络的吞吐量
Net I/O: 9.5 KB/s (0.1*10^6 bps)
# 发生错误的总数,客户端超时计数，每次从生成请求开始，如果没有响应即超时,
# TCP连接失败
Errors: total 0 client-timo 0 socket-timo 0 connrefused 0 connreset 0
Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0
```

#### [ab]()

- install

- usage

- output example

```shell
╭─root@test ~
╰─# ab -n 1000 -c 1000 http://10.20.172.196/
This is ApacheBench, Version 2.3 <$Revision: 1430300 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/
Benchmarking 10.20.172.196 (be patient)
Completed 100 requests
Completed 200 requests
Completed 300 requests
Completed 400 requests
Completed 500 requests
Completed 600 requests
Completed 700 requests
Completed 800 requests
Completed 900 requests
Completed 1000 requests
Finished 1000 requests
Server Software:        nginx/1.15.8.1
Server Hostname:        10.20.172.196
Server Port:            80
Document Path:          /
Document Length:        649 bytes
Concurrency Level:      1000
Time taken for tests:   0.107 seconds
Complete requests:      1000
Failed requests:        0
Write errors:           0
Total transferred:      888000 bytes
HTML transferred:       649000 bytes
Requests per second:    9313.50 [#/sec] (mean)
Time per request:       107.371 [ms] (mean)
Time per request:       0.107 [ms] (mean, across all concurrent requests)
Transfer rate:          8076.55 [Kbytes/sec] received

Connection Times (ms)
				  min  mean[+/-sd] median   max
Connect:        0   29   8.1     29      42
Processing:    17   36  14.3     45      51
Waiting:        0   35  14.3     44      50
Total:         42   65   9.0     64      87

Percentage of the requests served within a certain time (ms)
  50%     64
  66%     69
  75%     71
  80%     73
  90%     78
  95%     81
  98%     84
  99%     86
 100%     87 (longest request)
```

#### stress

> [Stress/Stress-NG](https://www.tecmint.com/linux-cpu-load-stress-test-with-stress-ng-tool/)是Linux下两个常用的系统级压力测试工具，**stress**命令简单易用，**stress-ng**是stress的升级版，支持**数百个参数定制各种压CPU、内存、IO、网络**的姿势。在系统过载的场景下，应用服务可能会出现意想不到的错误或异常，在测试**负载均衡和熔断降级**时非常有用。这里只列举了几个常用的命令，详细使用参考”stress-ng –help”或”man stress-ng”。另外，这些“烤机”命令来测试服务器性能也是不错的。

- install

```shell
# RHRL/CentOS
yum install epel-release
yum install stress stress-ng

# Debian/Ubuntu
apt install stress stress-ng

# stress-ng 基本用法与stress完全兼容，但有更多的参数可选，并且可以查看统计信息
```

- usage

```shell
# 在两个CPU核心上跑开方运算，并且启动一个不断分配释放1G内存的线程，运行10秒后停止
stress --cpu 2 --vm 1 --vm-bytes 1G  -v --timeout 10

# 启动一个线程不断执行sync系统调用回写磁盘缓存，并且启动一个线程不停地写入删除512MB数据，运行10秒停止
stress --io 1 --hdd 1 --hdd-bytes 512M -v --timeout 10

# --sock 可以模拟大量的socket连接断开以及数据的发送接收等等
stress-ng --sock 2 -v --timeout 10 --metrics-brief
```

- output example

```shell
╭─root@debian /bashtop  ‹master›
╰─# stress --cpu 4 --vm 1 --vm-bytes 1G  -v --timeout 3
stress: info: [18174] dispatching hogs: 4 cpu, 0 io, 1 vm, 0 hdd
stress: dbug: [18174] using backoff sleep of 3000us
stress: dbug: [18174] setting timeout to 3s
stress: dbug: [18174] --> hogcpu worker 1 [18179] forked
stress: dbug: [18176] allocating 1073741824 bytes ...
stress: dbug: [18176] allocating 1073741824 bytes ...
stress: dbug: [18176] touching bytes in strides of 4096 bytes ...
stress: dbug: [18174] <-- worker 18175 signalled normally
stress: dbug: [18174] <-- worker 18177 signalled normally
stress: dbug: [18174] <-- worker 18178 signalled normally
stress: dbug: [18174] <-- worker 18179 signalled normally
stress: dbug: [18174] <-- worker 18176 signalled normally
stress: info: [18174] successful run completed in 3s
```

![image-20200506154459952](img/image-20200506154459952.png)


### 小工具

### 镜像源

## 发行版



### pxder

下班之后回到小窝之后就开始一天中最最愉悦的时刻，在 pixiv.net 上刷图。收藏喜欢的~~老婆~~插画。为了管理和下载自己收藏的插画作品，当然还是选择食用工具来下载啦😂。

在二月份的时候帮小土豆和 nova 同学测试 webp server go 的 benchmark ，这个 pxder 帮了咱很大的忙，下载了 3W 多张图片做测试样本，最终使用脚本筛选出合适的文件大小来进行 prefetc 测试。

```shell
╭─debian@debian /mnt/f/illustrations
╰─$ du -sh
50G     .
╭─debian@debian /mnt/f/illustrations
╰─$ tree
203 directories, 31831 files
```

### 杂七杂八的

#### nginx

nginx，除了建站當 Web 服務器，是咱在 openwrt 上裝的，目的是為了擺脫 ip 的辦定限制。因為有些設備通過域名來訪問，更換網絡環境，比如搬家之後只需要維修改一下域名解析即可。比如咱使用 X.lo.502.li 作為三級子域名分配給本地內網機器用。

#### ffmpeg

ffmpeg 能干的事情太多了，咱使用最多的还是合并视频转码视频，比如咱的 [mbcf]() ，全称 Merge bilibili cilent file

#### [pandoc](https://github.com/jgm/pandoc)

#### rsync

#### resilio sync

resilio sync ，是咱最重要的數據備份工具，比如咱使用 pxder 下載好收藏的老婆們，為了在手機上仔細欣賞老婆們，咱就用。resilio sync 將目錄同步到手機上，並且使用它來與 PC，iPhone ，Android ，Linux 三者無縫同步。簡直好用極了。

需要注意的是，如果跨公網同步，在一些網絡環境下因為 GFW 的緣故，無法建立起鏈接，這時候需要使用到預定義主機。其中有兩種比較好的方案，一是在公網 VPS 機器上安裝 resilio sync 並且加入到同步主機當中。這點缺點也明顯，需要佔用磁盤空間，如果同步大量文件以及幾十幾百GB級別的話，小盤機是扛不住的，需要另外添加磁盤。方法二是咱想到的，屢試不爽，就是將本機的 resilio sync 監聽端口 11354 使用 frp 內網穿透到公網服務器，然後在另一台機器上添加上預定義主機，IP 就是 frp 服務器的 IP，端口就是 frp 內網穿透的 remote port。這樣添加好預訂與主機之後，不到一分鐘就能發現主機並建立起連接。

#### curl

#### wget

#### oh-my-zsh

#### zsh

#### frp

#### openwrt

#### Trojan

### shell 常用脚本

#### VPS init

```shell
apt update
apt install nload ncdu zsh git wget curl htop sysstat psmisc nginx-full fail2ban
curl  https://get.acme.sh | sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="bira"/g' ~/.zshrc
```

#### rawg

raw wget 的缩写

```shell
#!/bin/bash
# data: 2020-03-31
# author: muzi502
# for: Fuck GFW and download some raw file form github without proxy using jsDelivr CDN
# usage: save the .she to your local such as /usr/bin/rawg, and chmod +x /usr/bin/rawg
# use rawg https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh to download

set -xue
# GitHub rul: https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh
# jsDelivr url: https://cdn.jsdelivr.net/gh/ohmyzsh/ohmyzsh/tools/install.sh

wget $(echo $1 | sed 's/raw.githubusercontent.com/cdn.jsdelivr.net\/gh/' \
                | sed 's/github.com/cdn.jsdelivr.net\/gh/' \
                | sed 's/\/master//' | sed 's/\/blob//' )

# curl $(echo $1 | sed 's/raw.githubusercontent.com/cdn.jsdelivr.net\/gh/' \
#                | sed 's/github.com/cdn.jsdelivr.net\/gh/' \
#                | sed 's/\/master//' | sed 's/\/blob//' )
```

#### kubeadm pull images

```shell
#!/bin/bash
# for: pull kubeamd images and get kubeadm kubectl kubelet binary
# date: 2020-04-29
# author: muzi502

set -xue
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update

for version in 1.17.5
do
    apt purge -y kubeadm kubelet kubectl
    apt install -y kubeadm=${version}-00 kubelet=${version}-00 kubectl=${version}-00
    mkdir -p ${version}/bin
    rm -rf ${version}/bin/*
    cp -a $(whereis kubelet | awk -F ":" '{print $2}') ${version}/bin/
    cp -a $(whereis kubeadm | awk -F ":" '{print $2}') ${version}/bin/
    cp -a $(whereis kubectl | awk -F ":" '{print $2}') ${version}/bin/
    kubeadm config images pull --kubernetes-version=${version}
    docker save -o kubeadm_v${version}.tar `kubeadm config images list --kubernetes-version=${version}`
    mv kubeadm_v${version}.tar ${version}
    tar -czvf ${version}{.tar.gz,}
done
```

#### ss-obfs

```shell

#/bin/bash
# for: install shadowsocks-libev and obfs
# date: 2019-03-11
# by: muzi502
apt-get update
apt-get -y  install shadowsocks-libev simple-obfs rng-tools
rngd -r /dev/urandom
mkdir -p /etc/shadowsocks-libev/

cat > /etc/shadowsocks-libev/config.json <<EOF
{
    "server":"0.0.0.0",
    "server_port":8964,
    "local_port":1080,
    "password":"1984fuckGFW",
    "timeout":60,
    "method":"chacha20",
    "plugin":"obfs-server",
    "plugin_opts":"obfs=http"
}
EOF
systemctl restart shadowsocks-libev.service
modprobe tcp_bbr
echo "tcp_bbr" >> /etc/modules-load.d/modules.conf
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control
sysctl net.ipv4.tcp_congestion_control
touch /etc/sysctl.d/local.conf
echo "net.core.wmem_max = 67108864" >>/etc/sysctl.d/local.conf
echo "net.core.rmem_default = 65536" >>/etc/sysctl.d/local.conf
echo "net.core.wmem_default = 65536" >>/etc/sysctl.d/local.conf
echo "net.core.netdev_max_backlog = 4096" >>/etc/sysctl.d/local.conf
echo "net.core.somaxconn = 4096" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_syncookies = 1" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_tw_reuse = 1" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_tw_recycle = 0" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_fin_timeout = 30" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_keepalive_time = 1200" >>/etc/sysctl.d/local.conf
echo "net.ipv4.ip_local_port_range = 10000 65000" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_max_syn_backlog = 4096" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_max_tw_buckets = 5000" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_fastopen = 3" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_rmem = 4096 87380 67108864" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_wmem = 4096 65536 67108864" >>/etc/sysctl.d/local.conf
echo "net.ipv4.tcp_mtu_probing = 1" >>/etc/sysctl.d/local.conf
sysctl --system
lsmod | grep bbr
```

#### mcbf

```shell
#!/bin/bash
# for: bulk merge bilibili UWP download file *.flv
# by: blog.502.li
# date: 2019-01-12
# 将该脚放到 UWP 客户端下载缓存主目录下执行，安装 ffmpeg、jq

set -xu
download_dir=$(pwd)
mp4_dir=${download_dir}/mp4
mkdir -p ${mp4_dir}

for video_dir in $(ls | sort -n | grep -E -v "\.|mp4")
do
  cd ${download_dir}/${video_dir}
  up_name=$(jq ".Uploader" *.dvi | tr -d "[:punct:]\040\011\012\015")
  mkdir -p ${mp4_dir}/${up_name}
  for p_dir in $(ls | sort -n | grep -v "\.")
  do
    cd ${download_dir}/${video_dir}/${p_dir}
    video_name=$(jq ".Title" *.info | tr -d "[:punct:]\040\011\012\015")
    part_name=$(jq ".PartName" *.info | tr -d "[:punct:]\040\011\012\015")
    upload_time=$(grep -Eo "20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]" *.info)
    Uploader=$(jq ".Uploader" *.info | tr -d "[:punct:]\040\011\012\015")
    mp4_audio=$(jq ".VideoDashInfo" *.info | tr -d "[:punct:]\040\011\012\015")

    if [ "null" = "${part_name}" ];then
    mp4_file_name=${video_name}.mp4
    else
    mp4_file_name=${video_name}_${p_dir}_${part_name}.mp4
    fi

    if [ "null" = "${mp4_audio}" ];then
    ls *.flv | sort -n > ff.txt
    sed -i 's/^/file /g' ff.txt
    ffmpeg -f concat -i ff.txt -c copy ${mp4_dir}/${up_name}/"${mp4_file_name}";rm -rf ff.txt
    else
    ffmpeg  -i video.mp4 -i audio1.mp4 -c:v copy -c:a copy ${mp4_dir}/${up_name}/"${mp4_file_name}"
    fi
    cd ${download_dir}/${video_dir}
  cd ${download_dir}
  done
# 如果需要保留原视频请注释掉下面这一行
#rm -rf ${download_dir}/${video_dir}
done
```

#### conoha wallpaper download

```shell
#!/bin/bash
# for: download conoha wallpaper
# by: muzi502
# date: 2020-02-11
set -xue

p=$(curl https://conoha.mikumo.com/wallpaper/ \
| grep li | grep data-wallpaper-design= \
| sed -e 's/<li//g' | sed -e 's/">//g' | sed -e 's/^[ \t]*//g' \
| sed -e 's/data-wallpaper-design="//g' \
| sed 's/^/https:\/\/conoha.mikumo.com\/wp-content\/themes\/conohamikumo\/images\/wallpaper\//')

for pic in ${p}
do
    file_name=$(echo ${pic} | awk -F "/" '{print $9}')
    wget ${pic}/1080_1920.jpg -O ${file_name}_1080.jpg
    wget ${pic}/2560_1440.jpg -O ${file_name}_1440.jpg
done
```

## 参考

- [[DevOps] Linux操作系统层的故障注入](http://code2life.top/2019/05/02/0035-fault-injection/)
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

## Linux 和它的小伙伴

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

>  lsb_release - print distribution-specific information 打印发行版详情

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

####  lslocks

>  lslocks - list local system locks
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
>  The  lsmem command lists the ranges of available memory with their online status. The listed memory blocks correspond to the memory block representation in sysfs. The command also shows the memory block  size  and the amount of memory in online and offline state.

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

>  lsmod - Show the status of modules in the Linux Kernel

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

###  lspci - list all PCI devices

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


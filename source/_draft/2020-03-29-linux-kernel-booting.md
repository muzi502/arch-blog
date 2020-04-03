```verilog
[    0.000000] microcode: microcode updated early to revision 0x27, date = 2019-02-26
[    0.000000] Linux version 4.15.0-74-generic (buildd@lcy01-amd64-022) (gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)) #84-Ubuntu SMP Thu Dec 19 08:06:28 UTC 2019 (Ubuntu 4.15.0-74.84-generic 4.15.18)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-74-generic root=UUID=e6026d43-8cc6-437f-8b9c-e5ec5161ca61 ro maybe-ubiquity
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.

[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000917ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000091800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d16e0fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d16e1000-0x00000000d16e7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d16e8000-0x00000000d1b15fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d1b16000-0x00000000d1f96fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d1f97000-0x00000000d7eeafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d7eeb000-0x00000000d7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8000000-0x00000000d875ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8760000-0x00000000d87fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8800000-0x00000000d8fadfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8fae000-0x00000000d8ffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d9000000-0x00000000da71bfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000da71c000-0x00000000da7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000da800000-0x00000000dbe11fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dbe12000-0x00000000dbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df1fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021edfffff] usable
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x21ee00 max_arch_pfn = 0x400000000

[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DBFFF write-protect
[    0.000000]   DC000-E7FFF uncachable
[    0.000000]   E8000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000000000 mask 7E00000000 write-back
[    0.000000]   1 base 0200000000 mask 7FE0000000 write-back
[    0.000000]   2 base 00E0000000 mask 7FE0000000 uncachable
[    0.000000]   3 base 00DE000000 mask 7FFE000000 uncachable
[    0.000000]   4 base 00DD000000 mask 7FFF000000 uncachable
[    0.000000]   5 base 021F000000 mask 7FFF000000 uncachable
[    0.000000]   6 base 021EE00000 mask 7FFFE00000 uncachable
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.000000] total RAM covered: 8126M

[    0.000000] Found optimal setting for mtrr clean up
[    0.000000]  gran_size: 64K  chunk_size: 64M         num_reg: 9      lose cover RAM: 0G
[    0.000000] e820: update [mem 0xdd000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xdbe12 max_arch_pfn = 0x400000000
   
   
[    0.000000] found SMP MP-table at [mem 0x000fd940-0x000fd94f]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x17f8e000, 0x17f8efff] PGTABLE
[    0.000000] BRK [0x17f8f000, 0x17f8ffff] PGTABLE
[    0.000000] BRK [0x17f90000, 0x17f90fff] PGTABLE
[    0.000000] BRK [0x17f91000, 0x17f91fff] PGTABLE
[    0.000000] BRK [0x17f92000, 0x17f92fff] PGTABLE
[    0.000000] BRK [0x17f93000, 0x17f93fff] PGTABLE
[    0.000000] BRK [0x17f94000, 0x17f94fff] PGTABLE
[    0.000000] BRK [0x17f95000, 0x17f95fff] PGTABLE
[    0.000000] BRK [0x17f96000, 0x17f96fff] PGTABLE
[    0.000000] BRK [0x17f97000, 0x17f97fff] PGTABLE
[    0.000000] BRK [0x17f98000, 0x17f98fff] PGTABLE
[    0.000000] BRK [0x17f99000, 0x17f99fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3118d000-0x348bdfff]
   
   
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0490 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000D8FEE088 000094 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000D8FF94B0 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000D8FEE1B0 00B2FD (v02 DELL   CBX3     00000014 INTL 20091112)
[    0.000000] ACPI: FACS 0x00000000DA7FE080 000040
[    0.000000] ACPI: APIC 0x00000000D8FF95C0 000072 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000D8FF9638 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: SLIC 0x00000000D8FF9680 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
[    0.000000] ACPI: LPIT 0x00000000D8FF97F8 00005C (v01 DELL   CBX3     00000000 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000D8FF9858 000539 (v01 PmRef  Cpu0Ist  00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000D8FF9D98 000AD8 (v01 PmRef  CpuPm    00003000 INTL 20120711)
[    0.000000] ACPI: SSDT 0x00000000D8FFA870 0001C7 (v01 PmRef  LakeTiny 00003000 INTL 20120711)
[    0.000000] ACPI: HPET 0x00000000D8FFAA38 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000D8FFAA70 00036D (v01 SataRe SataTabl 00001000 INTL 20120711)
[    0.000000] ACPI: MCFG 0x00000000D8FFADE0 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x00000000D8FFAE20 003406 (v01 SaSsdt SaSsdt   00003000 INTL 20091112)
[    0.000000] ACPI: ASF! 0x00000000D8FFE228 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: DMAR 0x00000000D8FFE2D0 0000B8 (v01 INTEL  HSW      00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
   
   
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021edfffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21edd3000-0x21edfdfff]
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021edfffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000090fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000d16e0fff]
[    0.000000]   node   0: [mem 0x00000000d16e8000-0x00000000d1b15fff]
[    0.000000]   node   0: [mem 0x00000000d1f97000-0x00000000d7eeafff]
[    0.000000]   node   0: [mem 0x00000000d8000000-0x00000000d875ffff]
[    0.000000]   node   0: [mem 0x00000000d8800000-0x00000000d8fadfff]
[    0.000000]   node   0: [mem 0x00000000d9000000-0x00000000da71bfff]
[    0.000000]   node   0: [mem 0x00000000da800000-0x00000000dbe11fff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021edfffff]
[    0.000000] Reserved but unavailable: 112 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021edfffff]
[    0.000000] On node 0 totalpages: 2073647
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3984 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13979 pages used for memmap
[    0.000000]   DMA32 zone: 894623 pages, LIFO batch:31
[    0.000000]   Normal zone: 18360 pages used for memmap
[    0.000000]   Normal zone: 1175040 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics memory at 0x00000000dd200000-0x00000000df1fffff
[    0.000000] ACPI: PM-Timer IO Port: 0x1808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
   
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00091000-0x00091fff]
[    0.000000] PM: Registered nosave memory: [mem 0x00092000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd16e1000-0xd16e7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd1b16000-0xd1f96fff]
[    0.000000] PM: Registered nosave memory: [mem 0xd7eeb000-0xd7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd8760000-0xd87fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd8fae000-0xd8ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xda71c000-0xda7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdbe12000-0xdbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdc000000-0xdcffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdd000000-0xdf1fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf200000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xdf200000-0xf7ffffff] available for PCI devices
   
   
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] random: get_random_bytes called from start_kernel+0x99/0x4fd with crng_init=0
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 45 pages/cpu s147456 r8192 d28672 u524288
[    0.000000] pcpu-alloc: s147456 r8192 d28672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2041223
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.15.0-74-generic root=UUID=e6026d43-8cc6-437f-8b9c-e5ec5161ca61 ro maybe-ubiquity
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8011744K/8294588K available (12300K kernel code, 2481K rwdata, 4260K rodata, 2428K init, 2704K bss, 282844K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] ftrace: allocating 39322 entries in 154 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=4.
[    0.000000]  Tasks RCU enabled.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 524544, nr_irqs: 456, preallocated irqs: 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] ACPI: Core revision 20170831
[    0.000000] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.000000] DMAR: Host address width 39
[    0.000000] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.000000] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c0000020660462 ecap f0101a
[    0.000000] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.000000] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008020660462 ecap f010da
[    0.000000] DMAR: RMRR base: 0x000000dbf7c000 end: 0x000000dbf89fff
[    0.000000] DMAR: RMRR base: 0x000000dd000000 end: 0x000000df1fffff
[    0.000000] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed91000 IOMMU 1
[    0.000000] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.000000] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.000000] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.000000] x2apic enabled
[    0.000000] Switched APIC routing to cluster x2apic.
[    0.000000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.020000] tsc: Fast TSC calibration using PIT
[    0.024000] tsc: Detected 3192.746 MHz processor
[    0.024000] Calibrating delay loop (skipped), value calculated using timer frequency.. 6385.49 BogoMIPS (lpj=12770984)
[    0.024000] pid_max: default: 32768 minimum: 301
[    0.024000] Security Framework initialized
[    0.024000] Yama: becoming mindful.
[    0.024000] AppArmor: AppArmor initialized
[    0.024000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.024000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.024000] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.024000] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.024000] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.024000] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.024000] CPU0: Thermal monitoring enabled (TM1)
[    0.024000] process: using mwait in idle threads
[    0.024000] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.024000] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.024000] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.024000] Spectre V2 : Mitigation: Full generic retpoline
[    0.024000] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.024000] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.024000] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.024000] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.024000] MDS: Mitigation: Clear CPU buffers
[    0.024000] Freeing SMP alternatives memory: 36K
[    0.029207] TSC deadline timer enabled
[    0.029210] smpboot: CPU0: Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz (family: 0x6, model: 0x3c, stepping: 0x3)
[    0.029261] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.029295] ... version:                3
[    0.029296] ... bit width:              48
[    0.029297] ... generic registers:      8
[    0.029299] ... value mask:             0000ffffffffffff
[    0.029300] ... max period:             00007fffffffffff
[    0.029301] ... fixed-purpose events:   3
[    0.029302] ... event mask:             00000007000000ff
[    0.029328] Hierarchical SRCU implementation.
[    0.030029] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.030041] smp: Bringing up secondary CPUs ...
[    0.030095] x86: Booting SMP configuration:
[    0.030097] .... node  #0, CPUs:      #1 #2 #3
[    0.033429] smp: Brought up 1 node, 4 CPUs
[    0.033429] smpboot: Max logical packages: 1
[    0.033429] smpboot: Total of 4 processors activated (25541.96 BogoMIPS)
[    0.036197] devtmpfs: initialized
[    0.036197] x86/mm: Memory block size: 128MB
[    0.036475] evm: security.selinux
[    0.036476] evm: security.SMACK64
[    0.036477] evm: security.SMACK64EXEC
[    0.036478] evm: security.SMACK64TRANSMUTE
[    0.036480] evm: security.SMACK64MMAP
[    0.036481] evm: security.apparmor
[    0.036482] evm: security.ima
[    0.036483] evm: security.capability
[    0.036494] PM: Registering ACPI NVS region [mem 0xd16e1000-0xd16e7fff] (28672 bytes)
[    0.036494] PM: Registering ACPI NVS region [mem 0xda71c000-0xda7fffff] (933888 bytes)
[    0.036494] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.036494] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.036494] pinctrl core: initialized pinctrl subsystem
[    0.036494] RTC time:  0:57:56, date: 03/23/20
[    0.036494] NET: Registered protocol family 16
[    0.036494] audit: initializing netlink subsys (disabled)
[    0.036494] audit: type=2000 audit(1584925076.036:1): state=initialized audit_enabled=0 res=1
[    0.036494] cpuidle: using governor ladder
[    0.036494] cpuidle: using governor menu
[    0.036494] ACPI: bus type PCI registered
[    0.036494] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.036494] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.036494] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.036494] PCI: Using configuration type 1 for base access
[    0.036494] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
[    0.036840] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.036840] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.036840] ACPI: Added _OSI(Module Device)
[    0.036840] ACPI: Added _OSI(Processor Device)
[    0.036840] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.036840] ACPI: Added _OSI(Processor Aggregator Device)
[    0.036840] ACPI: Added _OSI(Linux-Dell-Video)
[    0.036840] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.036840] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.036840] ACPI: Executed 1 blocks of module-level executable AML code
[    0.041221] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.041710] ACPI: Dynamic OEM Table Load:
[    0.041710] ACPI: SSDT 0xFFFF893E94E70000 0003D3 (v01 PmRef  Cpu0Cst  00003001 INTL 20120711)
[    0.041710] ACPI: Dynamic OEM Table Load:
[    0.041710] ACPI: SSDT 0xFFFF893E94E44800 0005AA (v01 PmRef  ApIst    00003000 INTL 20120711)
[    0.041710] ACPI: Dynamic OEM Table Load:
[    0.041710] ACPI: SSDT 0xFFFF893E948C0E00 000119 (v01 PmRef  ApCst    00003000 INTL 20120711)
[    0.041710] ACPI: Interpreter enabled
[    0.041710] ACPI: (supports S0 S3 S4 S5)
[    0.041710] ACPI: Using IOAPIC for interrupt routing
[    0.041710] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.041710] ACPI: GPE 0x1E active on init
[    0.044002] ACPI: Enabled 9 GPEs in block 00 to 3F
[    0.054826] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.054831] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.055410] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.055836] PCI host bridge to bus 0000:00
[    0.055839] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.055841] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.055842] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.055844] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.055846] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.055848] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.055850] pci_bus 0000:00: root bus resource [mem 0xdf200000-0xfeafffff window]
[    0.055852] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.055858] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
[    0.055928] pci 0000:00:02.0: [8086:0412] type 00 class 0x030000
[    0.055936] pci 0000:00:02.0: reg 0x10: [mem 0xf7800000-0xf7bfffff 64bit]
[    0.055940] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.055943] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.056005] pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
[    0.056012] pci 0000:00:03.0: reg 0x10: [mem 0xf7c34000-0xf7c37fff 64bit]
[    0.056098] pci 0000:00:14.0: [8086:8c31] type 00 class 0x0c0330
[    0.056116] pci 0000:00:14.0: reg 0x10: [mem 0xf7c20000-0xf7c2ffff 64bit]
[    0.056168] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.056226] pci 0000:00:16.0: [8086:8c3a] type 00 class 0x078000
[    0.056245] pci 0000:00:16.0: reg 0x10: [mem 0xf7c40000-0xf7c4000f 64bit]
[    0.056299] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.056357] pci 0000:00:19.0: [8086:153a] type 00 class 0x020000
[    0.056373] pci 0000:00:19.0: reg 0x10: [mem 0xf7c00000-0xf7c1ffff]
[    0.056380] pci 0000:00:19.0: reg 0x14: [mem 0xf7c3d000-0xf7c3dfff]
[    0.056387] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
[    0.056436] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.056495] pci 0000:00:1a.0: [8086:8c2d] type 00 class 0x0c0320
[    0.056514] pci 0000:00:1a.0: reg 0x10: [mem 0xf7c3c000-0xf7c3c3ff]
[    0.056585] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.056642] pci 0000:00:1b.0: [8086:8c20] type 00 class 0x040300
[    0.056659] pci 0000:00:1b.0: reg 0x10: [mem 0xf7c30000-0xf7c33fff 64bit]
[    0.056719] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.056777] pci 0000:00:1c.0: [8086:8c10] type 01 class 0x060400
[    0.056840] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.056942] pci 0000:00:1c.1: [8086:8c12] type 01 class 0x060400
[    0.057005] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.057107] pci 0000:00:1d.0: [8086:8c26] type 00 class 0x0c0320
[    0.057126] pci 0000:00:1d.0: reg 0x10: [mem 0xf7c3b000-0xf7c3b3ff]
[    0.057198] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.057258] pci 0000:00:1f.0: [8086:8c4e] type 00 class 0x060100
[    0.057402] pci 0000:00:1f.2: [8086:2822] type 00 class 0x010400
[    0.057416] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    0.057423] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    0.057428] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    0.057434] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    0.057440] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.057447] pci 0000:00:1f.2: reg 0x24: [mem 0xf7c3a000-0xf7c3a7ff]
[    0.057476] pci 0000:00:1f.2: PME# supported from D3hot
[    0.057529] pci 0000:00:1f.3: [8086:8c22] type 00 class 0x0c0500
[    0.057545] pci 0000:00:1f.3: reg 0x10: [mem 0xf7c39000-0xf7c390ff 64bit]
[    0.057561] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.057677] acpiphp: Slot [1] registered
[    0.057684] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.057755] pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
[    0.057889] pci 0000:02:00.0: supports D1 D2
[    0.068014] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    0.068150] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.068899] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.068955] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.069009] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.069068] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.069118] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.069168] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.069218] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.069268] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.069559] SCSI subsystem initialized
[    0.069568] libata version 3.00 loaded.
[    0.069568] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.069568] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.069568] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.069568] vgaarb: loaded
[    0.069568] ACPI: bus type USB registered
[    0.069568] usbcore: registered new interface driver usbfs
[    0.069568] usbcore: registered new interface driver hub
[    0.069568] usbcore: registered new device driver usb
[    0.069568] EDAC MC: Ver: 3.0.0
[    0.069568] PCI: Using ACPI for IRQ routing
[    0.069568] PCI: pci_cache_line_size set to 64 bytes
[    0.069568] e820: reserve RAM buffer [mem 0x00091800-0x0009ffff]
[    0.069568] e820: reserve RAM buffer [mem 0xd16e1000-0xd3ffffff]
[    0.069568] e820: reserve RAM buffer [mem 0xd1b16000-0xd3ffffff]
[    0.069568] e820: reserve RAM buffer [mem 0xd7eeb000-0xd7ffffff]
[    0.069568] e820: reserve RAM buffer [mem 0xd8760000-0xdbffffff]
[    0.069568] e820: reserve RAM buffer [mem 0xd8fae000-0xdbffffff]
[    0.069568] e820: reserve RAM buffer [mem 0xda71c000-0xdbffffff]
[    0.069568] e820: reserve RAM buffer [mem 0xdbe12000-0xdbffffff]
[    0.069568] e820: reserve RAM buffer [mem 0x21ee00000-0x21fffffff]
[    0.069568] NetLabel: Initializing
[    0.069568] NetLabel:  domain hash size = 128
[    0.069568] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.069568] NetLabel:  unlabeled traffic allowed by default
[    0.069568] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.069568] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.073016] clocksource: Switched to clocksource hpet
[    0.079694] VFS: Disk quotas dquot_6.6.0
[    0.079708] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.079783] AppArmor: AppArmor Filesystem Enabled
[    0.079803] pnp: PnP ACPI init
[    0.079887] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.079892] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.080062] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.080065] system 00:01: [io  0xffff] has been reserved
[    0.080067] system 00:01: [io  0xffff] has been reserved
[    0.080068] system 00:01: [io  0xffff] has been reserved
[    0.080070] system 00:01: [io  0x1c00-0x1cfe] has been reserved
[    0.080072] system 00:01: [io  0x1d00-0x1dfe] has been reserved
[    0.080073] system 00:01: [io  0x1e00-0x1efe] has been reserved
[    0.080075] system 00:01: [io  0x1f00-0x1ffe] has been reserved
[    0.080076] system 00:01: [io  0x1800-0x18fe] has been reserved
[    0.080078] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.080081] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.080098] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.080137] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.080141] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.080231] system 00:04: [io  0x0a00-0x0a0f] has been reserved
[    0.080235] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.080272] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.080275] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.080789] pnp 00:06: [dma 0 disabled]
[    0.080819] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.081193] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.081196] system 00:07: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.081198] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.081200] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.081201] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.081203] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.081205] system 00:07: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.081207] system 00:07: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.081210] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
[    0.081212] system 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.081214] system 00:07: [mem 0xf7fdf000-0xf7fdffff] has been reserved
[    0.081216] system 00:07: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.081219] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.081428] pnp: PnP ACPI: found 8 devices
[    0.087134] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.087163] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.087173] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.087190] pci 0000:00:1c.1: PCI bridge to [bus 02-03]
[    0.087200] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.087201] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.087202] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.087202] pci_bus 0000:00: resource 7 [mem 0x000dc000-0x000dffff window]
[    0.087203] pci_bus 0000:00: resource 8 [mem 0x000e0000-0x000e3fff window]
[    0.087204] pci_bus 0000:00: resource 9 [mem 0x000e4000-0x000e7fff window]
[    0.087205] pci_bus 0000:00: resource 10 [mem 0xdf200000-0xfeafffff window]
[    0.087292] NET: Registered protocol family 2
[    0.087396] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.087476] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.087597] TCP: Hash tables configured (established 65536 bind 65536)
[    0.087620] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.087640] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.087681] NET: Registered protocol family 1
[    0.087691] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.136091] PCI: CLS 64 bytes, default 64
[    0.136119] Unpacking initramfs...
[    0.685768] Freeing initrd memory: 56516K
[    0.685801] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.685803] software IO TLB: mapped [mem 0xd3eeb000-0xd7eeb000] (64MB)
[    0.686002] Scanning for low memory corruption every 60 seconds
[    0.686444] Initialise system trusted keyrings
[    0.686452] Key type blacklist registered
[    0.686476] workingset: timestamp_bits=36 max_order=21 bucket_order=0
[    0.687202] zbud: loaded
[    0.687556] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.687647] fuse init (API version 7.26)
[    0.688898] Key type asymmetric registered
[    0.688900] Asymmetric key parser 'x509' registered
[    0.688924] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    0.688953] io scheduler noop registered
[    0.688954] io scheduler deadline registered
[    0.688971] io scheduler cfq registered (default)
[    0.689372] pcieport 0000:00:1c.0: Signaling PME with IRQ 26
[    0.689387] pcieport 0000:00:1c.1: Signaling PME with IRQ 27
[    0.689433] vesafb: mode is 640x480x32, linelength=2560, pages=0
[    0.689435] vesafb: scrolling: redraw
[    0.689437] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.689444] vesafb: framebuffer at 0xe0000000, mapped to 0x        (ptrval), using 1216k, total 1216k
[    0.708376] Console: switching to colour frame buffer device 80x30
[    0.727753] fb0: VESA VGA frame buffer device
[    0.728159] intel_idle: MWAIT substates: 0x42120
[    0.728160] intel_idle: v0.4.1 model 0x3C
[    0.728266] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.728370] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.729144] ACPI: Power Button [PWRB]
[    0.729496] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.752480] ACPI: Power Button [PWRF]
[    0.763976] ACPI: Invalid active0 threshold
[    0.775044] (NULL device *): hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    0.797926] thermal LNXTHERM:00: registered as thermal_zone0
[    0.809514] ACPI: Thermal Zone [TZ00] (28 C)
[    0.821129] thermal LNXTHERM:01: registered as thermal_zone1
[    0.832775] ACPI: Thermal Zone [TZ01] (30 C)
[    0.844406] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.877047] 00:06: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.902417] Linux agpgart interface v0.103
[    0.915648] loop: module loaded
[    0.927638] libphy: Fixed MDIO Bus: probed
[    0.939479] tun: Universal TUN/TAP device driver, 1.6
[    0.951681] PPP generic driver version 2.4.2
[    0.963688] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.976419] ehci-pci: EHCI PCI platform driver
[    0.988950] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    1.001447] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.026358] ehci-pci 0000:00:1a.0: debug port 2
[    1.042627] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    1.042636] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7c3c000
[    1.068016] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.080106] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.092108] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.115308] usb usb1: Product: EHCI Host Controller
[    1.126965] usb usb1: Manufacturer: Linux 4.15.0-74-generic ehci_hcd
[    1.138572] usb usb1: SerialNumber: 0000:00:1a.0
[    1.150163] hub 1-0:1.0: USB hub found
[    1.161681] hub 1-0:1.0: 2 ports detected
[    1.173019] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.184111] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.205813] ehci-pci 0000:00:1d.0: debug port 2
[    1.220603] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.220610] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7c3b000
[    1.244016] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.254747] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    1.265406] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.286122] usb usb2: Product: EHCI Host Controller
[    1.296845] usb usb2: Manufacturer: Linux 4.15.0-74-generic ehci_hcd
[    1.307782] usb usb2: SerialNumber: 0000:00:1d.0
[    1.318643] hub 2-0:1.0: USB hub found
[    1.329313] hub 2-0:1.0: 2 ports detected
[    1.339786] ehci-platform: EHCI generic platform driver
[    1.350227] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.360800] ohci-pci: OHCI PCI platform driver
[    1.371303] ohci-platform: OHCI generic platform driver
[    1.381647] uhci_hcd: USB Universal Host Controller Interface driver
[    1.392294] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.402899] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    1.425171] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    1.446940] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    1.447120] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[    1.458438] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.480559] usb usb3: Product: xHCI Host Controller
[    1.491875] usb usb3: Manufacturer: Linux 4.15.0-74-generic xhci-hcd
[    1.503536] usb usb3: SerialNumber: 0000:00:14.0
[    1.515062] hub 3-0:1.0: USB hub found
[    1.516032] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.526529] hub 3-0:1.0: 15 ports detected
[    1.551811] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.563422] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    1.586658] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[    1.598660] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[    1.610649] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.634221] usb usb4: Product: xHCI Host Controller
[    1.646196] usb usb4: Manufacturer: Linux 4.15.0-74-generic xhci-hcd
[    1.658381] usb usb4: SerialNumber: 0000:00:14.0
[    1.670815] hub 4-0:1.0: USB hub found
[    1.680034] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.682968] hub 4-0:1.0: 6 ports detected
[    1.695195] tsc: Refined TSC clocksource calibration: 3192.648 MHz
[    1.708136] i8042: PNP: No PS/2 controller found.
[    1.720046] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e052936eb5, max_idle_ns: 440795343075 ns
[    1.732508] mousedev: PS/2 mouse device common for all mice
[    1.757617] usb 1-1: New USB device found, idVendor=8087, idProduct=8008
[    1.770350] rtc_cmos 00:02: RTC can wake from S4
[    1.782836] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.795637] hub 1-1:1.0: USB hub found
[    1.808197] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.820738] hub 1-1:1.0: 6 ports detected
[    1.833242] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.870744] i2c /dev entries driver
[    1.883430] device-mapper: uevent: version 1.0.3
[    1.896165] device-mapper: ioctl: 4.37.0-ioctl (2017-09-20) initialised: dm-devel@redhat.com
[    1.921780] intel_pstate: Intel P-state driver initializing
[    1.932399] usb 2-1: New USB device found, idVendor=8087, idProduct=8000
[    1.948054] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.961204] ledtrig-cpu: registered to indicate activity on CPUs
[    1.961402] hub 2-1:1.0: USB hub found
[    1.974610] NET: Registered protocol family 10
[    1.987261] hub 2-1:1.0: 8 ports detected
[    2.002877] Segment Routing with IPv6
[    2.025688] NET: Registered protocol family 17
[    2.038300] Key type dns_resolver registered
[    2.051134] mce: Using 9 MCE banks
[    2.063457] RAS: Correctable Errors collector initialized.
[    2.075938] microcode: sig=0x306c3, pf=0x2, revision=0x27
[    2.088413] microcode: Microcode Update Driver: v2.2.
[    2.088419] sched_clock: Marking stable (2088409000, 0)->(2065917792, 22491208)
[    2.125405] registered taskstats version 1
[    2.137878] Loading compiled-in X.509 certificates
[    2.151452] Loaded X.509 cert 'Build time autogenerated kernel key: 62d24f9c726e026b112735485dad6e6e4b50c923'
[    2.175248] zswap: loaded using pool lzo/zbud
[    2.189447] Key type big_key registered
[    2.196030] usb 1-1.1: new full-speed USB device number 3 using ehci-pci
[    2.201236] Key type trusted registered
[    2.226067] Key type encrypted registered
[    2.237577] AppArmor: AppArmor sha1 policy hashing enabled
[    2.249168] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    2.260918] ima: Allocated hash algorithm: sha1
[    2.272534] evm: HMAC attrs: 0x1
[    2.283925]   Magic number: 12:149:962
[    2.294980] memory memory13: hash matches
[    2.305846] rtc_cmos 00:02: setting system clock to 2020-03-23 00:57:58 UTC (1584925078)
[    2.322241] usb 1-1.1: New USB device found, idVendor=1532, idProduct=020e
[    2.327978] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.339163] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.350667] EDD information not available.
[    2.385476] usb 1-1.1: Product: Razer Cynosa
[    2.385477] usb 1-1.1: Manufacturer: Razer
[    2.410553] Freeing unused kernel image memory: 2428K
[    2.436058] Write protecting the kernel read-only data: 20480k
[    2.448332] Freeing unused kernel image memory: 2008K
[    2.460373] Freeing unused kernel image memory: 1884K
[    2.464028] usb 1-1.2: new low-speed USB device number 4 using ehci-pci
[    2.488162] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.499731] x86/mm: Checking user space page tables
[    2.516075] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.596483] usb 1-1.2: New USB device found, idVendor=413c, idProduct=301a
[    2.608630] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.632080] usb 1-1.2: Product: Dell MS116 USB Optical Mouse
[    2.644139] usb 1-1.2: Manufacturer: PixArt
[    2.656716] hidraw: raw HID events driver (C) Jiri Kosina
[    2.669126] pps_core: LinuxPPS API ver. 1 registered
[    2.681000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.706908] ahci 0000:00:1f.2: version 3.0
[    2.707064] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x8 impl RAID mode
[    2.732250] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part ems apst
[    2.743308] usbcore: registered new interface driver usbhid
[    2.757963] scsi host0: ahci
[    2.770077] usbhid: USB HID core driver
[    2.782391] scsi host1: ahci
[    2.805575] clocksource: Switched to clocksource tsc
[    2.805710] scsi host2: ahci
[    2.829208] scsi host3: ahci
[    2.840502] PTP clock support registered
[    2.853440] input: Razer Razer Cynosa as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.0/0003:1532:020E.0001/input/input2
[    2.856003] scsi host4: ahci
[    2.890502] scsi host5: ahci
[    2.902403] ata1: DUMMY
[    2.914033] ata2: DUMMY
[    2.925334] ata3: DUMMY
[    2.936166] ata4: SATA max UDMA/133 abar m2048@0xf7c3a000 port 0xf7c3a280 irq 29
[    2.958630] ata5: DUMMY
[    2.958743] hid-generic 0003:1532:020E.0001: input,hidraw0: USB HID v1.11 Keyboard [Razer Razer Cynosa] on usb-0000:00:1a.0-1.1/input0
[    2.969416] ata6: DUMMY
[    3.003888] input: Razer Razer Cynosa as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.1/0003:1532:020E.0002/input/input3
[    3.028089] AVX2 version of gcm_enc/dec engaged.
[    3.039504] AES CTR mode by8 optimization enabled
[    3.052759] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    3.064187] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.075425] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.098848] hid-generic 0003:1532:020E.0002: input,hidraw1: USB HID v1.11 Keyboard [Razer Razer Cynosa] on usb-0000:00:1a.0-1.1/input1
[    3.121421] input: Razer Razer Cynosa as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.1/1-1.1:1.2/0003:1532:020E.0003/input/input4
[    3.145470] hid-generic 0003:1532:020E.0003: input,hidraw2: USB HID v1.11 Mouse [Razer Razer Cynosa] on usb-0000:00:1a.0-1.1/input2
[    3.170368] input: PixArt Dell MS116 USB Optical Mouse as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:413C:301A.0004/input/input5
[    3.175648] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[    3.196687] hid-generic 0003:413C:301A.0004: input,hidraw3: USB HID v1.11 Mouse [PixArt Dell MS116 USB Optical Mouse] on usb-0000:00:1a.0-1.2/input0
[    3.283684] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 34:17:eb:9b:e8:39
[    3.303065] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.312547] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.329828] ata4.00: ATA-8: WDC WD3200BPVT-00HXZT3, 01.01A01, max UDMA/133
[    3.343266] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
[    3.358432] ata4.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    3.361335] ata4.00: configured for UDMA/133
[    3.405164] scsi 3:0:0:0: Direct-Access     ATA      WDC WD3200BPVT-0 1A01 PQ: 0 ANSI: 5
[    3.435545] [drm] Memory usable by graphics device = 2048M
[    3.435562] checking generic (e0000000 130000) vs hw (e0000000 10000000)
[    3.451344] fb: switching to inteldrmfb from VESA VGA
[    3.451448] sd 3:0:0:0: Attached scsi generic sg0 type 0
[    3.467185] sd 3:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
[    3.483421] e1000e 0000:00:19.0 eno1: renamed from eth0
[    3.513960] sd 3:0:0:0: [sda] 4096-byte physical blocks
[    3.513970] sd 3:0:0:0: [sda] Write Protect is off
[    3.560219] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.560236] sd 3:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    3.560249] Console: switching to colour dummy device 80x25
[    3.560414] [drm] Replacing VGA console driver
[    3.566130] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.566135] [drm] Driver supports precise vblank timestamp query.
[    3.568053] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    3.569412] ------------[ cut here ]------------
[    3.569415] Could not determine valid watermarks for inherited state
[    3.569462] WARNING: CPU: 2 PID: 170 at /build/linux-PIILow/linux-4.15.0/drivers/gpu/drm/i915/intel_display.c:14537 intel_modeset_init+0xfcf/0x1010 [i915]
[    3.569465] Modules linked in: fjes(-) crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc i915(+) e1000e i2c_algo_bit aesni_intel aes_x86_64 drm_kms_helper crypto_simd hid_generic glue_helper ptp cryptd syscopyarea usbhid sysfillrect sysimgblt fb_sys_fops ahci libahci drm pps_core hid video
[    3.569481] CPU: 2 PID: 170 Comm: systemd-udevd Not tainted 4.15.0-74-generic #84-Ubuntu
[    3.569482] Hardware name: Dell Inc. OptiPlex 9020/0DNKMN, BIOS A05 12/05/2013
[    3.569507] RIP: 0010:intel_modeset_init+0xfcf/0x1010 [i915]
[    3.569508] RSP: 0018:ffff9ac34112b9b0 EFLAGS: 00010286
[    3.569510] RAX: 0000000000000000 RBX: ffff893e895c0000 RCX: ffffffffa4263a28
[    3.569512] RDX: 0000000000000001 RSI: 0000000000000082 RDI: 0000000000000246
[    3.569514] RBP: ffff9ac34112ba40 R08: 00000000000002b2 R09: 0000000000000000
[    3.569515] R10: 0000000000000040 R11: ffffffffa332fa70 R12: ffff893e891abc00
[    3.569517] R13: ffff893e895edc00 R14: 00000000ffffffea R15: ffff893e895c0358
[    3.569519] FS:  00007f264f819680(0000) GS:ffff893e9eb00000(0000) knlGS:0000000000000000
[    3.569521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.569522] CR2: 00007f264f5f66e8 CR3: 00000002098d2005 CR4: 00000000001606e0
[    3.569524] Call Trace:
[    3.569546]  i915_driver_load+0xa73/0xe60 [i915]
[    3.569566]  i915_pci_probe+0x42/0x70 [i915]
[    3.569570]  local_pci_probe+0x47/0xa0
[    3.569572]  pci_device_probe+0x10e/0x1c0
[    3.569575]  driver_probe_device+0x30c/0x490
[    3.569578]  __driver_attach+0xcc/0xf0
[    3.569580]  ? driver_probe_device+0x490/0x490
[    3.569582]  bus_for_each_dev+0x70/0xc0
[    3.569584]  driver_attach+0x1e/0x20
[    3.569585]  bus_add_driver+0x1c7/0x270
[    3.569587]  ? 0xffffffffc04ff000
[    3.569589]  driver_register+0x60/0xe0
[    3.569590]  ? 0xffffffffc04ff000
[    3.569592]  __pci_register_driver+0x5a/0x60
[    3.569616]  i915_init+0x5c/0x5f [i915]
[    3.569619]  do_one_initcall+0x52/0x19f
[    3.569622]  ? __vunmap+0x8e/0xc0
[    3.569625]  ? _cond_resched+0x19/0x40
[    3.569628]  ? kmem_cache_alloc_trace+0xa6/0x1b0
[    3.569631]  ? do_init_module+0x27/0x213
[    3.569634]  do_init_module+0x5f/0x213
[    3.569636]  load_module+0x16bc/0x1f10
[    3.569639]  ? ima_post_read_file+0x96/0xa0
[    3.569642]  SYSC_finit_module+0xfc/0x120
[    3.569644]  ? SYSC_finit_module+0xfc/0x120
[    3.569647]  SyS_finit_module+0xe/0x10
[    3.569649]  do_syscall_64+0x73/0x130
[    3.569652]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[    3.569653] RIP: 0033:0x7f264f322839
[    3.569655] RSP: 002b:00007ffd53dcf748 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    3.569657] RAX: ffffffffffffffda RBX: 000055664b03bae0 RCX: 00007f264f322839
[    3.569658] RDX: 0000000000000000 RSI: 00007f264f001145 RDI: 0000000000000012
[    3.569660] RBP: 00007f264f001145 R08: 0000000000000000 R09: 000055664b03bae0
[    3.569662] R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
[    3.569663] R13: 000055664b03c730 R14: 0000000000020000 R15: 000055664b03bae0
[    3.569665] Code: e9 46 fc ff ff 48 c7 c6 d7 dd 48 c0 48 c7 c7 2f d1 48 c0 e8 94 e8 a8 e2 0f 0b e9 73 fe ff ff 48 c7 c7 b0 35 4a c0 e8 81 e8 a8 e2 <0f> 0b e9 4b fe ff ff 48 c7 c6 e4 dd 48 c0 48 c7 c7 2f d1 48 c0
[    3.569685] ---[ end trace d5ea98272d8e605a ]---
[    3.571543] [drm] Initialized i915 1.6.0 20171023 for 0000:00:02.0 on minor 0
[    3.572835] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    3.573065] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input6
[    3.622051] [drm] Cannot find any crtc or sizes
[    3.635307]  sda: sda1 sda2
[    3.635500] sd 3:0:0:0: [sda] Attached SCSI disk
[    3.660093] [drm] Cannot find any crtc or sizes
[    3.863255] random: fast init done
[    4.979842] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    4.979859] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    4.979863] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    5.095995] raid6: sse2x1   gen() 12310 MB/s
[    5.143993] raid6: sse2x1   xor()  8594 MB/s
[    5.191994] raid6: sse2x2   gen() 14692 MB/s
[    5.239995] raid6: sse2x2   xor()  9485 MB/s
[    5.287993] raid6: sse2x4   gen() 17265 MB/s
[    5.335993] raid6: sse2x4   xor() 10818 MB/s
[    5.383993] raid6: avx2x1   gen() 23988 MB/s
[    5.431993] raid6: avx2x1   xor() 16207 MB/s
[    5.479993] raid6: avx2x2   gen() 27854 MB/s
[    5.527993] raid6: avx2x2   xor() 17049 MB/s
[    5.575993] raid6: avx2x4   gen() 31854 MB/s
[    5.623993] raid6: avx2x4   xor() 19993 MB/s
[    5.623995] raid6: using algorithm avx2x4 gen() 31854 MB/s
[    5.623996] raid6: .... xor() 19993 MB/s, rmw enabled
[    5.624008] raid6: using avx2x2 recovery algorithm
[    5.624714] xor: automatically using best checksumming function   avx
[    5.625416] async_tx: api initialized (async)
[    5.656755] Btrfs loaded, crc32c=crc32c-intel
[    5.707383] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    7.566845] ip_tables: (C) 2000-2006 Netfilter Core Team
[    7.693016] systemd[1]: systemd 237 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    7.712101] systemd[1]: Detected architecture x86-64.
[    7.774674] systemd[1]: Set hostname to <ubuntu>.
[    8.312282] random: crng init done
[    8.312287] random: 7 urandom warning(s) missed due to ratelimiting
[   10.422655] systemd[1]: Configuration file /etc/systemd/system/kubelet.service is marked executable. Please remove executable permission bits. Proceeding anyway.
[   10.596073] systemd[1]: Reached target User and Group Name Lookups.
[   10.596869] systemd[1]: Created slice System Slice.
[   10.596960] systemd[1]: Listening on RPCbind Server Activation Socket.
[   10.597028] systemd[1]: Listening on LVM2 metadata daemon socket.
[   10.597087] systemd[1]: Listening on LVM2 poll daemon socket.
[   10.597148] systemd[1]: Listening on Syslog Socket.
[   11.246830] EXT4-fs (sda2): re-mounted. Opts: (null)
[   11.318934] Loading iSCSI transport class v2.0-870.
[   11.603585] systemd-journald[429]: Received request to flush runtime journal from PID 1
[   11.709078] iscsi: registered transport (tcp)
[   12.011414] Adding 3945468k swap on /swap.img.  Priority:-2 extents:5 across:4223996k FS
[   12.323613] iscsi: registered transport (iser)
[   16.031671] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20170831/utaddress-247)
[   16.031676] ACPI Warning: SystemIO range 0x0000000000001828-0x000000000000182F conflicts with OpRegion 0x0000000000001800-0x000000000000187F (\PMIO) (20170831/utaddress-247)
[   16.031679] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   16.031681] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[   16.031683] ACPI Warning: SystemIO range 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[   16.031685] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   16.031686] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20170831/utaddress-247)
[   16.031688] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20170831/utaddress-247)
[   16.031690] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[   16.031691] ACPI Warning: SystemIO range 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[   16.031693] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   16.031694] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20170831/utaddress-247)
[   16.031696] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20170831/utaddress-247)
[   16.031697] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[   16.031699] ACPI Warning: SystemIO range 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion 0x0000000000001C00-0x0000000000001FFF (\GPR) (20170831/utaddress-247)
[   16.031701] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   16.031701] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   16.486127] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   18.591179] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[   18.591180] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   18.591181] RAPL PMU: hw unit of domain package 2^-14 Joules
[   18.591181] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   18.591181] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   18.716891] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
[   20.548199] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   20.728727] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3220: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
[   20.728728] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   20.728729] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   20.728730] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   20.728730] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   20.728731] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x1a
[   20.728732] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   20.771081] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input7
[   20.771113] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input8
[   20.771141] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input9
[   20.771169] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input10
[   21.372281] audit: type=1400 audit(1584925097.563:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lxc-start" pid=572 comm="apparmor_parser"
[   21.376984] audit: type=1400 audit(1584925097.567:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=571 comm="apparmor_parser"
[   21.376985] audit: type=1400 audit(1584925097.567:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-client.action" pid=571 comm="apparmor_parser"
[   21.376987] audit: type=1400 audit(1584925097.567:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/NetworkManager/nm-dhcp-helper" pid=571 comm="apparmor_parser"
[   21.376989] audit: type=1400 audit(1584925097.567:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/connman/scripts/dhclient-script" pid=571 comm="apparmor_parser"
[   21.385796] audit: type=1400 audit(1584925097.575:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=573 comm="apparmor_parser"
[   21.385798] audit: type=1400 audit(1584925097.575:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=573 comm="apparmor_parser"
[   21.385799] audit: type=1400 audit(1584925097.575:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=573 comm="apparmor_parser"
[   21.434154] audit: type=1400 audit(1584925097.623:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lxc-container-default" pid=570 comm="apparmor_parser"
[   21.434156] audit: type=1400 audit(1584925097.623:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lxc-container-default-cgns" pid=570 comm="apparmor_parser"
[   21.448930] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input11
[   21.448963] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input12
[   21.448990] input: HDA Intel HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/sound/card0/input13
[   21.449018] input: HDA Intel HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/sound/card0/input14
[   21.449045] input: HDA Intel HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/sound/card0/input15
[   21.488888] intel_rapl: Found RAPL domain package
[   21.488889] intel_rapl: Found RAPL domain core
[   21.488889] intel_rapl: Found RAPL domain uncore
[   21.488890] intel_rapl: Found RAPL domain dram
[   21.488892] intel_rapl: RAPL package 0 domain package locked by BIOS
[   21.488895] intel_rapl: RAPL package 0 domain dram locked by BIOS
[   36.008164] IPv6: ADDRCONF(NETDEV_UP): eno1: link is not ready
[   40.062262] e1000e: eno1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   40.062295] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
[   42.326135] new mount options do not match the existing superblock, will be ignored
[   42.517744] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   42.520676] IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
[   42.520705] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
[   42.716045] IPVS: ipvs loaded.
[   42.717780] IPVS: [rr] scheduler registered.
[   42.719256] IPVS: [wrr] scheduler registered.
[   42.720737] IPVS: [sh] scheduler registered.
[   48.553913] aufs 4.15-20180219
[   50.037556] kauditd_printk_skb: 9 callbacks suppressed
[   50.037557] audit: type=1400 audit(1584925126.227:21): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=1304 comm="apparmor_parser"
[   50.924181] fbcon: inteldrmfb (fb0) is primary device
[   50.975598] Console: switching to colour frame buffer device 170x48
[   50.993758] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   51.031584] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   51.032507] Bridge firewalling registered
[   51.927130] Initializing XFRM netlink socket
[   51.930181] Netfilter messages via NETLINK v0.30.
[   51.931289] ctnetlink v0.93: registering with nfnetlink.
[   52.100615] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[   52.123269] IPv6: ADDRCONF(NETDEV_UP): br-130777c57f8d: link is not ready
[   52.788919] br-130777c57f8d: port 1(veth15c0380) entered blocking state
[   52.788921] br-130777c57f8d: port 1(veth15c0380) entered disabled state
[   52.788960] device veth15c0380 entered promiscuous mode
[   52.789011] IPv6: ADDRCONF(NETDEV_UP): veth15c0380: link is not ready
[   52.789013] br-130777c57f8d: port 1(veth15c0380) entered blocking state
[   52.789014] br-130777c57f8d: port 1(veth15c0380) entered forwarding state
[   52.789028] IPv6: ADDRCONF(NETDEV_CHANGE): br-130777c57f8d: link becomes ready
[   52.789394] br-130777c57f8d: port 1(veth15c0380) entered disabled state
[   54.724865] eth0: renamed from veth15ed354
[   54.740379] IPv6: ADDRCONF(NETDEV_CHANGE): veth15c0380: link becomes ready
[   54.740415] br-130777c57f8d: port 1(veth15c0380) entered blocking state
[   54.740418] br-130777c57f8d: port 1(veth15c0380) entered forwarding state

```

```log
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 5.4.23-amlogic-flippy-28+ (root@x96-max) (gcc version 8.3.0 (Debian 8.3.0-6)) #52 SMP PREEMPT Sat Feb 29 23:58:15 CST 2020
[    0.000000] Machine model: Phicomm N1
[    0.000000] Reserved memory: created CMA memory pool at 0x000000003b400000, size 896 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] On node 0 totalpages: 477952
[    0.000000]   DMA32 zone: 7616 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 477952 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] percpu: Embedded 22 pages/cpu s51480 r8192 d30440 u90112
[    0.000000] pcpu-alloc: s51480 r8192 d30440 u90112 alloc=22*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 470336
[    0.000000] Kernel command line: root=UUID=69fd696a-85a4-4ec8-b604-4cefd053cbc1 rootfstype=btrfs rootflags=compress=zstd console=ttyAML0,115200n8 console=tty0 no_console_suspend consoleblank=0 fsck.fix=yes fsck.repair=yes net.ifnames=0 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1
[    0.000000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 924744K/1911808K available (12926K kernel code, 1108K rwdata, 5116K rodata, 640K init, 748K bss, 69560K reserved, 917504K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] irq_meson_gpio: 110 to 8 gpio interrupt mux initialized
[    0.000000] random: get_random_bytes called from start_kernel+0x2b8/0x440 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000003] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000216] Console: colour dummy device 80x25
[    0.000502] printk: console [tty0] enabled
[    0.000535] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.000555] pid_max: default: 32768 minimum: 301
[    0.000648] LSM: Security Framework initializing
[    0.000683] SELinux:  Initializing.
[    0.000729] *** VALIDATE SELinux ***
[    0.000779] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000803] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    0.000853] *** VALIDATE tmpfs ***
[    0.001209] *** VALIDATE proc ***
[    0.001406] *** VALIDATE cgroup1 ***
[    0.001418] *** VALIDATE cgroup2 ***
[    0.060010] ASID allocator initialised with 32768 entries
[    0.079997] rcu: Hierarchical SRCU implementation.
[    0.120049] smp: Bringing up secondary CPUs ...
[    0.200258] Detected VIPT I-cache on CPU1
[    0.200305] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.280298] Detected VIPT I-cache on CPU2
[    0.280337] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
[    0.360341] Detected VIPT I-cache on CPU3
[    0.360378] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
[    0.360442] smp: Brought up 1 node, 4 CPUs
[    0.360504] SMP: Total of 4 processors activated.
[    0.360515] CPU features: detected: 32-bit EL0 Support
[    0.360526] CPU features: detected: CRC32 instructions
[    0.360902] CPU: All CPU(s) started at EL2
[    0.360924] alternatives: patching kernel code
[    0.361706] devtmpfs: initialized
[    0.366284] Registered cp15_barrier emulation handler
[    0.366312] Registered setend emulation handler
[    0.366566] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.366596] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.388608] xor: measuring software checksum speed
[    0.480283]    8regs     :  2374.800 MB/sec
[    0.580319]    32regs    :  2724.800 MB/sec
[    0.680348]    arm64_neon:  2404.400 MB/sec
[    0.680358] xor: using function: 32regs (2724.800 MB/sec)
[    0.680414] pinctrl core: initialized pinctrl subsystem
[    0.681083] NET: Registered protocol family 16
[    0.691294] DMA: preallocated 256 KiB pool for atomic allocations
[    0.691333] audit: initializing netlink subsys (disabled)
[    0.691472] audit: type=2000 audit(0.690:1): state=initialized audit_enabled=0 res=1
[    0.692062] cpuidle: using governor menu
[    0.692421] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.693090] Serial: AMBA PL011 UART driver
[    0.705434] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.705459] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.705472] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.705484] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.708716] cryptd: max_cpu_qlen set to 1000
[    0.880519] raid6: neonx8   gen()  1631 MB/s
[    1.050581] raid6: neonx8   xor()  1505 MB/s
[    1.220647] raid6: neonx4   gen()  1560 MB/s
[    1.390684] raid6: neonx4   xor()  1471 MB/s
[    1.560783] raid6: neonx2   gen()  1198 MB/s
[    1.730812] raid6: neonx2   xor()  1217 MB/s
[    1.900916] raid6: neonx1   gen()   785 MB/s
[    2.070912] raid6: neonx1   xor()   914 MB/s
[    2.240985] raid6: int64x8  gen()  1194 MB/s
[    2.411043] raid6: int64x8  xor()   769 MB/s
[    2.581132] raid6: int64x4  gen()  1030 MB/s
[    2.751197] raid6: int64x4  xor()   752 MB/s
[    2.921275] raid6: int64x2  gen()   728 MB/s
[    3.091333] raid6: int64x2  xor()   615 MB/s
[    3.261516] raid6: int64x1  gen()   487 MB/s
[    3.431470] raid6: int64x1  xor()   466 MB/s
[    3.431481] raid6: using algorithm neonx8 gen() 1631 MB/s
[    3.431491] raid6: .... xor() 1505 MB/s, rmw enabled
[    3.431501] raid6: using neon recovery algorithm
[    3.431726] fbcon: Taking over console
[    3.432741] iommu: Default domain type: Translated
[    3.432886] vgaarb: loaded
[    3.433215] SCSI subsystem initialized
[    3.433385] usbcore: registered new interface driver usbfs
[    3.433425] usbcore: registered new interface driver hub
[    3.433497] usbcore: registered new device driver usb
[    3.433790] mc: Linux media interface: v0.10
[    3.433819] videodev: Linux video capture interface: v2.00
[    3.433910] pps_core: LinuxPPS API ver. 1 registered
[    3.433921] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.433944] PTP clock support registered
[    3.434056] EDAC MC: Ver: 3.0.0
[    3.434554] Advanced Linux Sound Architecture Driver Initialized.
[    3.434974] NetLabel: Initializing
[    3.434986] NetLabel:  domain hash size = 128
[    3.434995] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    3.435048] NetLabel:  unlabeled traffic allowed by default
[    3.435695] clocksource: Switched to clocksource arch_sys_counter
[    3.435721] *** VALIDATE bpf ***
[    3.435943] VFS: Disk quotas dquot_6.6.0
[    3.436005] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.436125] FS-Cache: Loaded
[    3.436136] *** VALIDATE ramfs ***
[    3.436158] *** VALIDATE hugetlbfs ***
[    3.440665] thermal_sys: Registered thermal governor 'step_wise'
[    3.440669] thermal_sys: Registered thermal governor 'power_allocator'
[    3.440969] NET: Registered protocol family 2
[    3.441450] tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
[    3.441497] TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    3.441613] TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
[    3.441818] TCP: Hash tables configured (established 16384 bind 16384)
[    3.441948] UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    3.442001] UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
[    3.442186] NET: Registered protocol family 1
[    3.442214] NET: Registered protocol family 44
[    3.442229] PCI: CLS 0 bytes, default 64
[    3.442399] Trying to unpack rootfs image as initramfs...
[    3.815729] Freeing initrd memory: 8800K
[    3.816496] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    3.816779] kvm [1]: IPA Size Limit: 40bits
[    3.817363] kvm [1]: vgic interrupt IRQ1
[    3.817471] kvm [1]: Hyp mode initialized successfully
[    4.176629] Initialise system trusted keyrings
[    4.176816] workingset: timestamp_bits=46 max_order=19 bucket_order=0
[    4.181236] zbud: loaded
[    4.182529] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    4.182814] fuse: init (API version 7.31)
[    4.182885] *** VALIDATE fuse ***
[    4.182898] *** VALIDATE fuse ***
[    4.183180] SGI XFS with ACLs, security attributes, no debug enabled
[    4.211668] Key type asymmetric registered
[    4.211692] Asymmetric key parser 'x509' registered
[    4.211754] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    4.211907] io scheduler mq-deadline registered
[    4.211920] io scheduler kyber registered
[    4.212066] io scheduler bfq registered
[    4.221136] soc soc0: Amlogic Meson GXL (S905D) Revision 21:d (4:2) Detected
[    4.222193] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.223454] Serial: AMBA driver
[    4.223789] c11084c0.serial: ttyAML6 at MMIO 0xc11084c0 (irq = 10, base_baud = 1500000) is a meson_uart
[    4.223919] serial serial0: tty port ttyAML6 registered
[    4.224110] c81004c0.serial: ttyAML0 at MMIO 0xc81004c0 (irq = 13, base_baud = 1500000) is a meson_uart
[    5.115642] printk: console [ttyAML0] enabled
[    5.125094] brd: module loaded
[    5.129367] loop: module loaded
[    5.130232] libphy: Fixed MDIO Bus: probed
[    5.131931] meson8b-dwmac c9410000.ethernet: IRQ eth_wake_irq not found
[    5.137553] meson8b-dwmac c9410000.ethernet: IRQ eth_lpi not found
[    5.143707] meson8b-dwmac c9410000.ethernet: PTP uses main clock
[    5.149590] meson8b-dwmac c9410000.ethernet: no reset control found
[    5.156249] meson8b-dwmac c9410000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[    5.162861] meson8b-dwmac c9410000.ethernet:         DWMAC1000
[    5.168056] meson8b-dwmac c9410000.ethernet: DMA HW capability register supported
[    5.175451] meson8b-dwmac c9410000.ethernet: RX Checksum Offload Engine supported
[    5.182883] meson8b-dwmac c9410000.ethernet: COE Type 2
[    5.188049] meson8b-dwmac c9410000.ethernet: TX Checksum insertion supported
[    5.195029] meson8b-dwmac c9410000.ethernet: Wake-Up On Lan supported
[    5.201449] meson8b-dwmac c9410000.ethernet: Normal descriptors
[    5.207283] meson8b-dwmac c9410000.ethernet: Ring mode enabled
[    5.213055] meson8b-dwmac c9410000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[    5.221147] libphy: stmmac: probed
[    5.225102] usbcore: registered new interface driver r8152
[    5.229854] usbcore: registered new interface driver ax88179_178a
[    5.236737] dwc3 c9000000.dwc3: Failed to get clk 'ref': -2
[    5.242444] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.247858] ehci-pci: EHCI PCI platform driver
[    5.252258] ehci-platform: EHCI generic platform driver
[    5.257555] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.263519] ohci-pci: OHCI PCI platform driver
[    5.267948] ohci-platform: OHCI generic platform driver
[    5.273595] usbcore: registered new interface driver usb-storage
[    5.280308] mousedev: PS/2 mouse device common for all mice
[    5.284718] i2c /dev entries driver
[    5.289233] sdhci: Secure Digital Host Controller Interface driver
[    5.294129] sdhci: Copyright(c) Pierre Ossman
[    5.298555] Synopsys Designware Multimedia Card Interface Driver
[    5.305788] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    5.336299] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    5.363266] sdhci-pltfm: SDHCI platform and OF driver helper
[    5.364846] meson-sm: secure-monitor enabled
[    5.368090] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
[    5.375432] gxl-crypto c883e000.crypto: will run requests pump with realtime priority
[    5.398608] hidraw: raw HID events driver (C) Jiri Kosina
[    5.399017] usbcore: registered new interface driver usbhid
[    5.403900] usbhid: USB HID core driver
[    5.407717] exFAT: Version 1.3.0
[    5.411233] platform-mhu c883c404.mailbox: Platform MHU Mailbox registered
[    5.420796] debugfs: Directory 'c1105400.audio' with parent 'regmap' already present!
[    5.429328] Initializing XFRM netlink socket
[    5.431911] NET: Registered protocol family 10
[    5.466158] mmc1: new HS200 MMC card at address 0001
[    5.466918] mmcblk1: mmc1:0001 NCard  7.28 GiB
[    5.470322] mmcblk1boot0: mmc1:0001 NCard  partition 1 4.00 MiB
[    5.476211] mmcblk1boot1: mmc1:0001 NCard  partition 2 4.00 MiB
[    5.480612] Segment Routing with IPv6
[    5.481972] mmcblk1rpmb: mmc1:0001 NCard  partition 3 4.00 MiB, chardev (240:0)
[    5.485560] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    5.494666]  mmcblk1: p1 p2 p3
[    5.501008] bpfilter: Loaded bpfilter_umh pid 329
[    5.506198] NET: Registered protocol family 17
[    5.510552] NET: Registered protocol family 15
[    5.514971] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[    5.528006] 8021q: 802.1Q VLAN Support v1.8
[    5.531958] Key type dns_resolver registered
[    5.536663] registered taskstats version 1
[    5.540192] Loading compiled-in X.509 certificates
[    5.545039] zswap: loaded using pool lzo/zbud
[    5.549540] Key type ._fscrypt registered
[    5.553216] Key type .fscrypt registered
[    5.557931] Btrfs loaded, crc32c=crc32c-generic
[    5.581877] Key type encrypted registered
[    5.597254] meson-drm d0100000.vpu: Queued 2 outputs on vpu
[    5.597546] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.603749] [drm] No driver support for vblank timestamp query.
[    5.609722] meson-drm d0100000.vpu: CVBS Output connector not available
[    5.665743] meson-dw-hdmi c883a000.hdmi-tx: Detected HDMI TX controller v2.01a with HDCP (meson_dw_hdmi_phy)
[    5.670336] meson-dw-hdmi c883a000.hdmi-tx: registered DesignWare HDMI I2C bus driver
[    5.678155] meson-drm d0100000.vpu: bound c883a000.hdmi-tx (ops meson_dw_hdmi_ops)
[    5.685557] [drm] Initialized meson 1.0.0 20161109 for d0100000.vpu on minor 0
[    5.692388] [drm] Cannot find any crtc or sizes
[    5.697271] libphy: mdio_mux: probed
[    5.700448] [drm] Cannot find any crtc or sizes
[    5.708300] libphy: mdio_mux: probed
[    5.715952] phy phy-d0078080.phy.2: unsupported PHY mode 5
[    5.718019] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    5.721422] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
[    5.728968] xhci-hcd xhci-hcd.0.auto: hcc params 0x0228f664 hci version 0x100 quirks 0x0000000002010010
[    5.738194] xhci-hcd xhci-hcd.0.auto: irq 39, io mem 0xc9000000
[    5.744252] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
[    5.752221] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.759385] usb usb1: Product: xHCI Host Controller
[    5.764193] usb usb1: Manufacturer: Linux 5.4.23-amlogic-flippy-28+ xhci-hcd
[    5.771186] usb usb1: SerialNumber: xhci-hcd.0.auto
[    5.776423] hub 1-0:1.0: USB hub found
[    5.779736] hub 1-0:1.0: 2 ports detected
[    5.783919] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    5.789273] xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
[    5.796732] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
[    5.803230] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    5.811283] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.04
[    5.819402] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.826559] usb usb2: Product: xHCI Host Controller
[    5.831382] usb usb2: Manufacturer: Linux 5.4.23-amlogic-flippy-28+ xhci-hcd
[    5.838374] usb usb2: SerialNumber: xhci-hcd.0.auto
[    5.843583] hub 2-0:1.0: USB hub found
[    5.846946] hub 2-0:1.0: config failed, hub doesn't have any ports! (err -19)
[    5.855243] meson-gx-mmc d0070000.mmc: allocated mmc-pwrseq
[    5.886322] scpi_protocol scpi: SCP Protocol legacy pre-1.0 firmware
[    5.897143] hctosys: unable to open rtc device (rtc0)
[    5.898747] ALSA device list:
[    5.899501]   No soundcards found.
[    5.903127] Freeing unused kernel memory: 640K
[    5.907330] Run /init as init process
[    5.925215] random: fast init done
[    5.925425] mmc2: new high speed SDIO card at address 0001
[    6.139503] input: adc-keys as /devices/platform/adc-keys/input/input0
[    6.155756] usb 1-1: new high-speed USB device number 2 using xhci-hcd
[    6.186567] usb 1-1: New USB device found, idVendor=14cd, idProduct=1212, bcdDevice= 1.00
[    6.189112] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=2
[    6.196226] usb 1-1: Product: Mass Storage Device
[    6.200838] usb 1-1: Manufacturer: Generic
[    6.204889] usb 1-1: SerialNumber: 121220160204
[    6.210617] usb-storage 1-1:1.0: USB Mass Storage device detected
[    6.218829] scsi host0: usb-storage 1-1:1.0
[    6.249402] usbcore: registered new interface driver uas
[    6.535524] BTRFS: device label EMMC_SHARED devid 1 transid 85 /dev/mmcblk1p3
[    6.538572] BTRFS: device label EMMC_ROOTFS devid 1 transid 490 /dev/mmcblk1p2
[    6.613142] BTRFS info (device mmcblk1p2): use zstd compression, level 3
[    6.614225] BTRFS info (device mmcblk1p2): disk space caching is enabled
[    6.620907] BTRFS info (device mmcblk1p2): has skinny extents
[    6.643335] BTRFS info (device mmcblk1p2): enabling ssd optimizations
[    6.871161] init: Console is alive
[    7.276359] scsi 0:0:0:0: Direct-Access     Mass     Storage Device   1.00 PQ: 0 ANSI: 0 CCS
[    7.282189] sd 0:0:0:0: [sda] 125042688 512-byte logical blocks: (64.0 GB/59.6 GiB)
[    7.287095] sd 0:0:0:0: [sda] Write Protect is off
[    7.291557] sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
[    7.291786] sd 0:0:0:0: [sda] No Caching mode page found
[    7.296819] sd 0:0:0:0: [sda] Assuming drive cache: write through
[    7.358783]  sda: sda1
[    7.360472] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   10.705340] kmodloader: loading kernel modules from /etc/modules-boot.d/*
[   10.726205] ehci-fsl: Freescale EHCI Host controller driver
[   10.748238] uhci_hcd: USB Universal Host Controller Interface driver
[   10.759162] kmodloader: done loading kernel modules from /etc/modules-boot.d/*
[   10.770137] init: - preinit -
[   10.878168] random: jshn: uninitialized urandom read (4 bytes read)
[   10.895990] random: jshn: uninitialized urandom read (4 bytes read)
[   10.904551] random: jshn: uninitialized urandom read (4 bytes read)
[   10.950519] meson8b-dwmac c9410000.ethernet eth0: PHY [0.2009087f:00] driver [RTL8211F Gigabit Ethernet]
[   10.957978] meson8b-dwmac c9410000.ethernet eth0: No Safety Features support found
[   10.961881] meson8b-dwmac c9410000.ethernet eth0: PTP not supported by HW
[   10.968634] meson8b-dwmac c9410000.ethernet eth0: configuring for phy/rgmii link mode
[   14.075641] mount_root: mounting /dev/root
[   14.089532] BTRFS info (device mmcblk1p2): disk space caching is enabled
[   14.091881] mount_root: loading kmods from internal overlay
[   14.349437] kmodloader: loading kernel modules from //etc/modules-boot.d/*
[   14.357691] kmodloader: done loading kernel modules from //etc/modules-boot.d/*
[   14.584143] block: attempting to load /tmp/overlay/upper/etc/config/fstab
[   14.585470] block: unable to load configuration (fstab: Entry not found)
[   14.592117] block: attempting to load /tmp/overlay/etc/config/fstab
[   14.598247] block: unable to load configuration (fstab: Entry not found)
[   14.604843] block: attempting to load /etc/config/fstab
[   14.614439] block: extroot: unable to determine root device
[   14.618272] urandom-seed: Seeding with /etc/urandom.seed
[   14.650460] procd: - early -
[   14.740715] urandom_read: 1 callbacks suppressed
[   14.740722] random: jshn: uninitialized urandom read (4 bytes read)
[   14.794550] random: jshn: uninitialized urandom read (4 bytes read)
[   14.882442] random: jshn: uninitialized urandom read (4 bytes read)
[   15.192957] procd: - ubus -
[   15.244755] procd: - init -
[   15.469455] urngd: v1.0.2 started.
[   15.490031] random: crng init done
[   15.490065] random: 3 urandom warning(s) missed due to ratelimiting
[   15.628200] kmodloader: loading kernel modules from /etc/modules.d/*
[   15.674279] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised: dm-devel@redhat.com
[   15.734270] tun: Universal TUN/TAP device driver, 1.6
[   15.751650] ipip: IPv4 and MPLS over IPv4 tunneling driver
[   15.779645] gre: GRE over IPv4 demultiplexor driver
[   15.788940] ip_gre: GRE over IPv4 tunneling driver
[   15.807862] RPC: Registered named UNIX socket transport module.
[   15.808151] RPC: Registered udp transport module.
[   15.812809] RPC: Registered tcp transport module.
[   15.817529] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   15.837307] FS-Cache: Netfs 'nfs' registered for caching
[   16.055250] Mirror/redirect action on
[   16.124692] u32 classifier
[   16.124721]     Performance counters on
[   16.125584]     input device check on
[   16.129247]     Actions configured
[   16.206817] Bridge firewalling registered
[   16.208764] usbcore: registered new interface driver cdc_ether
[   16.212372] usbcore: registered new interface driver cdc_ncm
[   16.217772] usbcore: registered new interface driver cdc_wdm
[   16.229932] usbcore: registered new interface driver huawei_cdc_ncm
[   16.271758] usbcore: registered new interface driver rndis_host
[   16.275621] usbcore: registered new interface driver ums-alauda
[   16.278695] usbcore: registered new interface driver ums-cypress
[   16.284605] usbcore: registered new interface driver ums-datafab
[   16.290535] usbcore: registered new interface driver ums-freecom
[   16.296530] usbcore: registered new interface driver ums-isd200
[   16.302361] usbcore: registered new interface driver ums-jumpshot
[   16.308430] usbcore: registered new interface driver ums-karma
[   16.314319] usbcore: registered new interface driver ums-sddr09
[   16.320079] usbcore: registered new interface driver ums-sddr55
[   16.325973] usbcore: registered new interface driver ums-usbat
[   16.333343] usbcore: registered new interface driver usblp
[   16.339313] usbcore: registered new interface driver usbserial_generic
[   16.342952] usbserial: USB Serial support registered for generic
[   16.353088] wireguard: WireGuard 0.0.20191219 loaded. See www.wireguard.com for information.
[   16.357214] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
[   16.385397] xt_time: kernel timezone is -0000
[   16.404396] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   16.413360] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   16.415680] usbcore: registered new interface driver ch341
[   16.419843] usbserial: USB Serial support registered for ch341-uart
[   16.428469] usbcore: registered new interface driver cp210x
[   16.431500] usbserial: USB Serial support registered for cp210x
[   16.442666] usbcore: registered new interface driver pl2303
[   16.442830] usbserial: USB Serial support registered for pl2303
[   16.451184] PPP generic driver version 2.4.2
[   16.453972] PPP MPPE Compression module registered
[   16.458900] NET: Registered protocol family 24
[   16.479074] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[   16.482673] usbcore: registered new interface driver brcmfmac
[   16.492608] kmodloader: done loading kernel modules from /etc/modules.d/*
[   16.645983] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[   16.766005] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Feb 27 2018 03:15:32 version 7.45.154 (r684107 CY) FWID 01-4fbe0b04
[   17.062092] BTRFS info (device mmcblk1p3): disk space caching is enabled
[   17.063164] BTRFS info (device mmcblk1p3): has skinny extents
[   17.075352] BTRFS info (device mmcblk1p3): enabling ssd optimizations
[   17.386992] xt_FULLCONENAT: RFC3489 Full Cone NAT module
               xt_FULLCONENAT: Copyright (C) 2018 Chion Tang <tech@chionlab.moe>
[   17.675371] FAT-fs (mmcblk1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   18.833771] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   19.166146] meson8b-dwmac c9410000.ethernet eth0: PHY [0.2009087f:00] driver [RTL8211F Gigabit Ethernet]
[   19.183988] meson8b-dwmac c9410000.ethernet eth0: No Safety Features support found
[   19.187057] meson8b-dwmac c9410000.ethernet eth0: PTP not supported by HW
[   19.192739] meson8b-dwmac c9410000.ethernet eth0: configuring for phy/rgmii link mode
[   19.311318] netlink: 4 bytes leftover after parsing attributes in process `iw'.
[   19.363536] ieee80211 phy0: brcmf_cfg80211_add_iface: iface validation failed: err=-16
[   20.900165] meson8b-dwmac c9410000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   20.903183] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   26.226291] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready

```


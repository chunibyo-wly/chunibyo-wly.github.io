---
typora-root-url: ..
title: proc记录
mathjax: true
date: 2020-05-06 21:36:27
tags:
	- linux
categories:
	- linux

---

![What is /proc? | OpsTips](/images/slash-proc.png)

<!-- more -->

# 1. /proc/meminfo

```
  Ubuntu [21:24:03] ~
$ cat /proc/m
mdstat   meminfo  misc     modules  mounts   mtrr
  Ubuntu [21:24:03] ~
$ cat /proc/meminfo
MemTotal:        4039176 kB
MemFree:         2055004 kB
MemAvailable:    2138952 kB
Buffers:           22528 kB
Cached:           243984 kB
SwapCached:        59464 kB
Active:          1284028 kB
Inactive:         560252 kB
Active(anon):    1099636 kB
Inactive(anon):   474752 kB
Active(file):     184392 kB
Inactive(file):    85500 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:        969964 kB
SwapFree:         579308 kB
Dirty:                56 kB
Writeback:             0 kB
AnonPages:       1551440 kB
Mapped:            69568 kB
Shmem:                84 kB
Slab:              82848 kB
SReclaimable:      37660 kB
SUnreclaim:        45188 kB
KernelStack:        4192 kB
PageTables:         9644 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     2989552 kB
Committed_AS:    3738756 kB
VmallocTotal:   34359738367 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
HardwareCorrupted:     0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      663424 kB
DirectMap2M:     3530752 kB
DirectMap1G:     2097152 kB
```

1. `MemFree`
2. `MemAvailable`: 在不使用交换空间的情况下，启动一个应用可用的最大内存 
3. `Buffers`
4. `Cached`
5. `PageTables`: 内存页页面大小

实际可以挪用的内存数为free+cache+buffer

实际使用的内存数为used-cache-buffer(total-free-cache-buffer),

# 2. /proc/cpuinfo

```
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
stepping	: 4
microcode	: 0x1
cpu MHz		: 2500.014
cache size	: 33792 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti ibrs ibpb stibp fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit
bogomips	: 5000.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 85
model name	: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
stepping	: 4
microcode	: 0x1
cpu MHz		: 2500.014
cache size	: 33792 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti ibrs ibpb stibp fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1
bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs taa itlb_multihit
bogomips	: 5000.02
clflush size	: 64
cache_alignment	: 64
address sizes	: 46 bits physical, 48 bits virtual
power management:
```


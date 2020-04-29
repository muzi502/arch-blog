---
title: kubelet MountVolume.SetUp failed NFS
date: 2020-01-01
updated:
slug:
categories:
tag:
copyright: true
comment: true
---

```shell
[root@k8s-master-01 nfs]# kubectl describe pod nfs-test-7748dbb477-sprxg -n nfs-test
Name:           nfs-test-7748dbb477-sprxg
Namespace:      nfs-test
Priority:       0
Node:           k8s-node-02/10.10.107.124
Start Time:     Sun, 26 Apr 2020 16:15:21 +0800
Labels:         pod-template-hash=7748dbb477
                workload.user.cattle.io/workloadselector=deployment-nfs-test-nfs-test
Annotations:    cattle.io/timestamp: 2020-04-26T08:15:57Z
Status:         Pending
IP:
IPs:            <none>
Controlled By:  ReplicaSet/nfs-test-7748dbb477
Containers:
  nfs-test:
    Container ID:
    Image:          ubuntu:xenial
    Image ID:
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /tmp from vol1 (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-9g278 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  vol1:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  nfs216
    ReadOnly:   false
  default-token-9g278:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-9g278
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason       Age        From                  Message
  ----     ------       ----       ----                  -------
  Normal   Scheduled    <unknown>  default-scheduler     Successfully assigned nfs-test/nfs-test-7748dbb477-sprxg to k8s-nod
  Warning  FailedMount  41s        kubelet, k8s-node-02  MountVolume.SetUp failed for volume "nfs216" : mount failed: exits
Mounting command: systemd-run
Mounting arguments: --description=Kubernetes transient mount for /var/lib/kubelet/pods/ef075eb7-df67-4b5d-8d01-87064f7cbb1c/volumes/kubernetes.io~nfs/nfs211--scope -- mount -t nfs 10.10.107.216:/nfs /var/lib/kubelet/pods/ef075eb7-df67-4b5d-8d01-87064f7cbb1c/volumes/kubernetes.io~nfs/nfs216
Output: Running scope as unit run-55589.scope.
mount: wrong fs type, bad option, bad superblock on 10.10.107.216:/nfs,
       missing codepage or helper program, or other error
       (for several filesystems (e.g. nfs, cifs) you might
       need a /sbin/mount.<type> helper program)
      
       In some cases useful info is found in syslog - try
       dmesg | tail or so.
  Warning  FailedMount  40s  kubelet, k8s-node-02  MountVolume.SetUp failed for volume "nfs216" : mount failed: exit status
[root@k8s-master-01 nfs]#
```

在 node3 节点尝试挂载 NFS 存储

```shell
[root@k8s-master-03 ~]# mount -t nfs 10.20.172.211:/nfs /tmp
mount: wrong fs type, bad option, bad superblock on 10.20.172.211:/nfs,
       missing codepage or helper program, or other error
       (for several filesystems (e.g. nfs, cifs) you might
       need a /sbin/mount.<type> helper program)

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
```

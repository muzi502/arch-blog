---
title: kubelet MountVolume.SetUp failed NFS 分析
date: 2020-01-01
updated:
slug:
categories:
tag:
copyright: true
comment: true
---

最近在 kubernetes 中使用 NFS 存储的时候遇到了一个小问题，也找到了解决办法，不过还是想深入地了解一下 kubelet 挂载存储的原理和过程，于是就水了这篇博客 😂。虽然平时也知道 PV 、PVC 、存储类等怎么使用，但背后的过程和原理却没有深究过，有点一知半解的感觉。嗨，太菜了 😑 （`流下了没有技术的眼泪.jpg`

## 疑惑

> 当使用 NFS 存储的 Pod 调度到没有安装 NFS client (nfs-utils 、nfs-common) Node 节点上的时候，会提示 NFS volume 挂载失败，Node 宿主机安装上 NFS client 后就可以正常挂载了，我想是不是 kubelet 在启动容器之前是不是调用 system-run 去挂载 NFS ，如果 Node 宿主机没有安装 NFS client 就无法挂载。
>
> 翻了一下源码 [mount_linux.go](https://github.com/kubernetes/kubernetes/blob/master/vendor/k8s.io/utils/mount/mount_linux.go#L115) 和 [49640](https://github.com/kubernetes/kubernetes/pull/49640) 这个 PR。里面提到的是 kubelet 挂载存储卷的时候使用 system-run 挂载，这样一来，即便 kubelet 挂掉或者重启的时候也不会影响到容器使用 kubelet 挂载的存储卷。

请教了一下两个大佬 [Yiran](https://zdyxry.github.io/) 和 [高策](http://gaocegege.com/Blog/about/)，他们也不太熟悉😂，不过也找到了解决思路。在使用 GlusterFS 的时候，Node 节点也需要安装 GlusterFS 的客户端，不然 kubelet 也是无法挂载 Pod 的 volume。由此可以确认的是： kubelet 在为 Pod 挂载 volume 的时候，根据 volume 的类型（NFS、GlusterFS、Ceph 等），Pod 所在的 Node 节点宿主机也需要安装好对应的客户端程序。

## 问题复现

集群信息：

```shell
[root@k8s-master-01 opt]# kubectl get node
NAME            STATUS   ROLES    AGE    VERSION
k8s-master-01   Ready    master   8d     v1.17.4
k8s-master-02   Ready    master   8d     v1.17.4
k8s-master-03   Ready    master   8d     v1.17.4
k8s-node-02     Ready    <none>   8d     v1.17.4
k8s-node-3      Ready    <none>   3d3h   v1.17.4
node1           Ready    <none>   108s   v1.17.4
```

为了方便复现问题还是在 Rancher 上创建了 PV 和 PVC，以及包含两个 Pod 的一个 `Deploment`，在创建 Deploment 的时候，指定将 Pod 调度到新加入的节点上，即这个节点上并没有安装 NFS 客户端。

**PV 信息如下：**

```shell
[root@k8s-master-01 opt]# kubectl describe pv nfs211
Name:            nfs211
Labels:          cattle.io/creator=norman
Annotations:     field.cattle.io/creatorId: user-gwgpp
                 pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    nfs216
Status:          Bound
Claim:           ops-test/nfs-211
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        10Gi
Node Affinity:   <none>
Message:
Source:
    Type:      NFS (an NFS mount that lasts the lifetime of a pod)
    Server:    10.20.172.211
    Path:      /nfs
    ReadOnly:  false
Events:        <none>
```

**PVC 信息如下**

```json
{
    "accessModes": [
        "ReadWriteMany"
    ],
    "annotations": {
        "pv.kubernetes.io/bind-completed": "yes"
    },
    "baseType": "persistentVolumeClaim",
    "created": "2020-04-30T08:59:15Z",
    "createdTS": 1588237155000,
    "creatorId": "user-gwgpp",
    "id": "ops-test:nfs-211",
    "labels": {
        "cattle.io/creator": "norman"
    },
    "links": {
        "remove": "…/v3/project/c-rl5jz:p-knsxt/persistentVolumeClaims/ops-test:nfs-211",
        "self": "…/v3/project/c-rl5jz:p-knsxt/persistentVolumeClaims/ops-test:nfs-211",
        "update": "…/v3/project/c-rl5jz:p-knsxt/persistentVolumeClaims/ops-test:nfs-211",
        "yaml": "…/v3/project/c-rl5jz:p-knsxt/persistentVolumeClaims/ops-test:nfs-211/yaml"
    },
    "name": "nfs-211",
    "namespaceId": "ops-test",
    "projectId": "c-rl5jz:p-knsxt",
    "resources": {
        "requests": {
            "storage": "10Gi"
        },
        "type": "/v3/project/schemas/resourceRequirements"
    },
    "state": "bound",
    "status": {
        "accessModes": [
            "ReadWriteMany"
        ],
        "capacity": {
            "storage": "10Gi"
        },
        "phase": "Bound",
        "type": "/v3/project/schemas/persistentVolumeClaimStatus"
    },
    "storageClassId": "nfs216",
    "transitioning": "no",
    "transitioningMessage": "",
    "type": "persistentVolumeClaim",
    "uuid": "660dc8d1-7911-4d30-b575-b54990de8667",
    "volumeId": "nfs211",
    "volumeMode": "Filesystem"
}

```

**Deploment 信息如下：**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    field.cattle.io/creatorId: user-gwgpp
  creationTimestamp: "2020-04-30T09:00:19Z"
  generation: 1
  labels:
    cattle.io/creator: norman
    workload.user.cattle.io/workloadselector: deployment-ops-test-node1-nfs-test
  name: node1-nfs-test
  namespace: ops-test
  resourceVersion: "1940561"
  selfLink: /apis/apps/v1/namespaces/ops-test/deployments/node1-nfs-test
  uid: 5d14a158-1eef-4a94-8433-15ad002ee55c
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      workload.user.cattle.io/workloadselector: deployment-ops-test-node1-nfs-test
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  template:
    metadata:
      annotations:
        cattle.io/timestamp: "2020-04-30T09:01:05Z"
        workload.cattle.io/state: '{"bm9kZTE=":"c-rl5jz:machine-wbs6r"}'
      creationTimestamp: null
      labels:
        workload.user.cattle.io/workloadselector: deployment-ops-test-node1-nfs-test
    spec:
      containers:
      - image: alpine
        imagePullPolicy: Always
        name: node1-nfs-test
        resources: {}
        securityContext:
          allowPrivilegeEscalation: false
          capabilities: {}
          privileged: false
          readOnlyRootFilesystem: false
          runAsNonRoot: false
        stdin: true
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        tty: true
        volumeMounts:
        - mountPath: /tmp
          name: vol1
      dnsPolicy: ClusterFirst
      nodeName: node1
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - name: vol1
        persistentVolumeClaim:
          claimName: nfs-211
```

创建完 Deploment 之后，使用 kubectl get pod 命令查看 Pod 创建的进度，发现一直卡在 `ContainerCreating` 状态

```shell
[root@k8s-master-01 opt]# kubectl get pod -n ops-test
NAME                              READY   STATUS              RESTARTS   AGE
node1-nfs-test-547c4d7678-j6kwv   0/1     ContainerCreating   0          2m12s
node1-nfs-test-547c4d7678-vwdqg   0/1     ContainerCreating   0          2m12s
```

kubectl describe pod 的日志如下：

```shell
[root@k8s-master-01 opt]# kubectl describe pod node1-nfs-test-547c4d7678-j6kwv -n ops-test
Name:           node1-nfs-test-547c4d7678-j6kwv
Namespace:      ops-test
Priority:       0
Node:           node1/10.10.107.214
Start Time:     Thu, 30 Apr 2020 17:00:33 +0800
Labels:         pod-template-hash=547c4d7678
                workload.user.cattle.io/workloadselector=deployment-ops-test-node1-nfs-test
Annotations:    cattle.io/timestamp: 2020-04-30T09:01:05Z
                workload.cattle.io/state: {"bm9kZTE=":"c-rl5jz:machine-wbs6r"}
Status:         Pending
IP:
IPs:            <none>
Controlled By:  ReplicaSet/node1-nfs-test-547c4d7678
Containers:
  node1-nfs-test:
    Container ID:
    Image:          alpine
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
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-f6wjj (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  vol1:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  nfs-211
    ReadOnly:   false
  default-token-f6wjj:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-f6wjj
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason       Age    From            Message
  ----     ------       ----   ----            -------
  Warning  FailedMount  8m49s  kubelet, node1  MountVolume.SetUp failed for volume "nfs211" : mount failed: exit status 32
Mounting command: systemd-run
Mounting arguments: --description=Kubernetes transient mount for /var/lib/kubelet/pods/cddc94e7-8033-4150-bed5-d141e3b71e49/volumes/kubernetes.io~nfs/nfs211 --scope -- mount -t nfs 10.20.172.211:/nfs /var/lib/kubelet/pods/cddc94e7-8033-4150-bed5-d141e3b71e49/volumes/kubernetes.io~nfs/nfs211
Output: Running scope as unit run-38284.scope.
mount: wrong fs type, bad option, bad superblock on 10.20.172.211:/nfs,
       missing codepage or helper program, or other error
       (for several filesystems (e.g. nfs, cifs) you might
       need a /sbin/mount.<type> helper program)

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
  Warning  FailedMount  8m48s  kubelet, node1  MountVolume.SetUp failed for volume "nfs211" : mount failed: exit status 32
```

在 一台没有安装 NFS 客户端的节点尝试挂载一下 NFS 存储，发现报错的日志和 kubelet 的日志相同🤔

```shell
[root@k8s-master-03 ~]# mount -t nfs 10.20.172.211:/nfs /tmp
mount: wrong fs type, bad option, bad superblock on 10.20.172.211:/nfs,
       missing codepage or helper program, or other error
       (for several filesystems (e.g. nfs, cifs) you might
       need a /sbin/mount.<type> helper program)

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
```

## 解决问题

看到 kubelet 报错的日志和我们在宿主机上使用 mount 名挂载 NFS 存储时的错误一样就可以断定为是宿主机的问题。搜了一下报错日志，在 [Why do I get “wrong fs type, bad option, bad superblock” error?](https://askubuntu.com/questions/525243/why-do-i-get-wrong-fs-type-bad-option-bad-superblock-error) 得到提示说需要安装一下 NFS 客户端 (nfs-common、nfs-utils) 😂。

```shell
╭─root@node1 ~
╰─# yum install nfs-utils
………………
Install  1 Package (+15 Dependent packages)

Total download size: 1.5 M
Installed size: 4.3 M
Is this ok [y/d/N]:
```

yum 一把梭后发现 `nfs-utils` 还真没有安装😂。

安装完时候使用 kubectl 删除掉之前的 Pod，Deploment 控制器会自动帮我们将 Pod 数量调和到指定的数量。可以发现 Pod 所在宿主机安装 NFS 客户端之后 kubelet 就能正常为 Pod 挂载 volume 了 而且 Pod 也正常运行了。

```shell
[root@k8s-master-01 ~]# kubectl delete pod node1-nfs-test-547c4d7678-j6kwv node1-nfs-test-547c4d7678-vwdqg -n ops-test
pod "node1-nfs-test-547c4d7678-j6kwv" deleted
pod "node1-nfs-test-547c4d7678-vwdqg" deleted
[root@k8s-master-01 ~]# kubectl get pod -n ops-test
NAME                              READY   STATUS    RESTARTS   AGE
node1-nfs-test-7589fb4787-cknz4   1/1     Running   0          18s
node1-nfs-test-7589fb4787-l9bt2   1/1     Running   0          22s
```

进入容器内查看一下容器内挂载点的信息：

```shell
[root@k8s-master-01 ~]# kubectl exec -it node1-nfs-test-7589fb4787-cknz4 -n ops-test sh
/ # df -h
Filesystem                Size      Used Available Use% Mounted on
overlay                  28.9G      4.1G     23.3G  15% /
10.20.172.211:/nfs       28.9G     14.5G     12.9G  53% /tmp
tmpfs                     1.8G         0      1.8G   0% /sys/firmware
/ # mount
rootfs on / type rootfs (rw)
10.20.172.211:/nfs on /tmp type nfs (rw,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.20.172.211,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.20.172.211)

10.20.172.211:/nfs on /mnt/nfs type nfs (rw,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.20.172.211,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.20.172.211)
```

至此问题已经解决了，接下来就到了正文：开始分析一下  kubelet 为 Pod 挂载 volume 的流程和原理😂

## 分析

```json
"GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/2a846f62b759d87bf8b2731960c4031585fb4ee14bbf313f58e0374c4fee9ce0-init/diff:/var/lib/docker/overlay2/29f9a1e9523d4ec323402a3c2da8a5e288cfe0e6f3168a57dd2388b63775c20a/diff:/var/lib/docker/overlay2/015afa447ae2fcfa592d257644312b286173b9a00d0f2017a4c6ede448a87d47/diff:/var/lib/docker/overlay2/2f71b56cd5550bf299ed33a04e385ef5578511e3a17d35162148f4b84bda4b26/diff",
                "MergedDir": "/var/lib/docker/overlay2/2a846f62b759d87bf8b2731960c4031585fb4ee14bbf313f58e0374c4fee9ce0/merged",
                "UpperDir": "/var/lib/docker/overlay2/2a846f62b759d87bf8b2731960c4031585fb4ee14bbf313f58e0374c4fee9ce0/diff",
                "WorkDir": "/var/lib/docker/overlay2/2a846f62b759d87bf8b2731960c4031585fb4ee14bbf313f58e0374c4fee9ce0/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [
            {
                "Type": "bind",
                "Source": "/opt/wordpress-nginx-docker/webp-server/config.json",
                "Destination": "/etc/config.json",
                "Mode": "rw",
                "RW": true,
                "Propagation": "rprivate"
            },
            {
                "Type": "bind",
                "Source": "/opt/wordpress-nginx-docker/wordpress",
                "Destination": "/var/www/html",
                "Mode": "rw",
                "RW": true,
                "Propagation": "rprivate"
            },
            {
                "Type": "volume",
                "Name": "36d087638f2e9ba8472c441bcf906320cfd80419874291f56e039e4f7d1278e7",
                "Source": "/var/lib/docker/volumes/36d087638f2e9ba8472c441bcf906320cfd80419874291f56e039e4f7d1278e7/_data",
                "Destination": "/opt/exhaust",
                "Driver": "local",
                "Mode": "",
                "RW": true,
                "Propagation": ""
            }
        ],

```



### 容器存储

在分析 Pod 的 volume 之前需要先了解一下 docker 容器的存储，根据 docker 的官方文档 [Manage data in Docker](https://docs.docker.com/storage/) ，docker 提供了 3 种方法将数据从 Docker 宿主机挂载（mount）到容器内，如下：

![docker-data](img/types-of-mounts.png)

`图片从官方文档偷来的😂`

>   -   **Volumes** are stored in a part of the host filesystem which is *managed by Docker* (`/var/lib/docker/volumes/` on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.
>   -   **Bind mounts** may be stored *anywhere* on the host system. They may even be important system files or directories. Non-Docker processes on the Docker host or a Docker container can modify them at any time.
>   -   **`tmpfs` mounts** are stored in the host system’s memory only, and are never written to the host system’s filesystem.

可以看到容器存储一种有三种：

-   Volumes：使用 Docker 来管理的存储，默认存放在 ``/var/lib/docker/volumes/`` 下，我们可以使用 `docker volume` 子命令来管理这些 volume ，可以创建、查看、列出、清空、删除等操作。非 docker 进程不应该去修改该目录下的文件。**卷是 Docker 容器持久化数据的最好方式**。

>   `-v`或`--volume`：由3个域组成，`':'`分隔
>
>   -   第一个域：对于命名卷，为卷名；匿名卷，则忽略，此时会创建匿名卷
>   -   第二个域：容器中的挂载点
>   -   第三个域：可选参数，由`','`隔开，如`ro`

```shell
╭─root@sg-02 /home/ubuntu
╰─# docker volume
Usage:  docker volume COMMAND
Manage volumes
Commands:
  create      Create a volume
  inspect     Display detailed information on one or more volumes
  ls          List volumes
  prune       Remove all unused local volumes
  rm          Remove one or more volumes
Run 'docker volume COMMAND --help' for more information on a command.
```

假如在写 `Dockerfile` 的时候，使用 `VOLUME` 指令指定容器内的路径。在我们启动容器的时候 docker 会帮我们创建一个持久化存储的 volume。也可在 `docker run` 或者 `docker-compose.yaml` 指定 `volume` 。

```json
╭─root@sg-02 /home/ubuntu
╰─# docker volume ls
DRIVER              VOLUME NAME
local               docker-elk_elasticsearch
local               opt
╭─root@sg-02 /home/ubuntu
╰─# docker volume inspect opt
[
    {
        "CreatedAt": "2020-03-12T06:58:15Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/opt/_data",
        "Name": "opt",
        "Options": null,
        "Scope": "local"
    }
]
╭─root@sg-02 /home/ubuntu
╰─# docker inspect docker-elk_elasticsearch
[
    {
        "CreatedAt": "2020-04-24T01:37:07Z",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "docker-elk",
            "com.docker.compose.version": "1.25.4",
            "com.docker.compose.volume": "elasticsearch"
        },
        "Mountpoint": "/var/lib/docker/volumes/docker-elk_elasticsearch/_data",
        "Name": "docker-elk_elasticsearch",
        "Options": null,
        "Scope": "local"
    }
]
```

-   Bind mounts：

使用 `Bind mounts` 将宿主机的目录或者文件挂载进容器内，使用`Bind mounts`可能会有安全问题：容器中运行的进程可以修改宿主机的文件系统，包括创建，修改，删除重要的系统文件或目录。不过可以加参数挂载为只读。

>   `--mount`：由多个`','`隔开的键值对<key>=<value>组成：
>
>   -   挂载类型：key为`type`，value为`bind`、`volume`或`tmpfs`
>   -   挂载源：key为`source`或`src`，对于命名卷，value为卷名，对于匿名卷，则忽略
>   -   容器中的挂载点：key为`destination`、`dst`或`target`，value为容器中的路径
>   -   读写类型：value为`readonly`，没有key
>   -   读写类型：value为`readonly`，没有key
>   -   volume-opt选项，可以出现多次。比如`volume-driver=local,volume-opt=type=nfs,...`

-   tmps：用来存储一些不需要持久化的状态或敏感数据，比如 kubernetes 中的各种 securt

>   -   `--tmpfs`：直接指定容器中的挂载点。不允许指定任何配置选项
>
>   -   --mount：由多个','隔开的键值对<key>=<value>组成：
>
>       挂载类型：key为`type`，value为`bind`、`volume`或`tmpfs`
>
>       容器中的挂载点：key为`destination`、`dst`或`target`，value为容器中的路径
>
>       `tmpfs-size`和`tmpfs-mode`选项

### kubelet 挂载存储

当 Pod 被调度到一个 Node 节点上后，Node 节点上的 kubelet 组件就会为这个 Pod 创建它的 Volume 目录，默认情况下 kubelet 为 Volume 创建的目录在 kubelet 工作目录下面，kubelet 默认的工作目录在 `/var/lib/kubelet` ，在 kubelet 启动的时候可以根据 `–root-dir` 参数来指定工作目录，不过一般没啥特殊要求还是使用默认的就好😂。Pod 的 volume 目录就在该目录下，路径格式如下：

```shell
/var/lib/kubelet/pods/<Pod的ID>/volumes/kubernetes.io~<Volume类型>/<Volume名字>

# 比如:
/var/lib/kubelet/pods/c4b1998b-f5c1-440a-b9bc-7fbf87f3c267/volumes/kubernetes.io~nfs/nfs211
```

在 Node 节点上可以使用 mount 命令来查看 kubelet 为 Pod 挂载的挂载点信息。

```shell
10.10.107.216:/nfs on /var/lib/kubelet/pods/6750b756-d8e4-448a-93f9-8906f9c44788/volumes/kubernetes.io~nfs/nfs-test type nfs (rw,relatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.10.107.216,mountvers=3,mountport=56389,mountproto=udp,local_lock=none,addr=10.10.107.216)
```

```shell
10.20.172.211:/nfs on /mnt/nfs type nfs (rw,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.20.172.211,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.20.172.211)
```

```shell
╭─root@k8s-node-3 ~
╰─# mount | grep kubelet
tmpfs on /var/lib/kubelet/pods/45c55c5e-ce96-47fd-94b3-60a334e5a44d/volumes/kubernetes.io~secret/kube-proxy-token-h4dfb type tmpfs (rw,relatime,seclabel)
tmpfs on /var/lib/kubelet/pods/3fb63baa-27ec-4d76-8028-39a0a8f91749/volumes/kubernetes.io~secret/calico-node-token-4hks6 type tmpfs (rw,relatime,seclabel)
tmpfs on /var/lib/kubelet/pods/05c75313-f932-4913-b09f-d7bccdfb6e62/volumes/kubernetes.io~secret/nginx-ingress-token-5569x type tmpfs (rw,relatime,seclabel)
10.20.172.211:/nfs on /var/lib/kubelet/pods/c4b1998b-f5c1-440a-b9bc-7fbf87f3c267/volumes/kubernetes.io~nfs/nfs211 type nfs (rw,relatime,vers=3,rsize=524288,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.20.172.211,mountvers=3,mountport=20048,mountproto=udp,local_lock=none,addr=10.20.172.211)
tmpfs on /var/lib/kubelet/pods/73fed6f3-4cbe-46a7-af7b-6fd912e6ebd4/volumes/kubernetes.io~secret/default-token-wgfd9 type tmpfs (rw,relatime,seclabel)
```

使用 docker inspect  <容器 ID> 查看容器挂载的详细信息

```json
╭─root@k8s-node-3 ~
╰─# docker inspect f1111ee6ac84
"Mounts": [
  {
      "Type": "bind",
      "Source": "/var/lib/kubelet/pods/73fed6f3-4cbe-46a7-af7b-6fd912e6ebd4/volumes/kubernetes.io~nfs/nfs211",
      "Destination": "/var/www/html",
      "Mode": "",
      "RW": true,
      "Propagation": "rprivate"
  },
  {
      "Type": "bind",
      "Source": "/var/lib/kubelet/pods/73fed6f3-4cbe-46a7-af7b-6fd912e6ebd4/volumes/kubernetes.io~secret/default-token-wgfd9",
      "Destination": "/var/run/secrets/kubernetes.io/serviceaccount",
      "Mode": "ro,Z",
      "RW": false,
      "Propagation": "rprivate"
  },
  {
      "Type": "bind",
      "Source": "/var/lib/kubelet/pods/73fed6f3-4cbe-46a7-af7b-6fd912e6ebd4/etc-hosts",
      "Destination": "/etc/hosts",
      "Mode": "Z",
      "RW": true,
      "Propagation": "rprivate"
  },
  {
      "Type": "bind",
      "Source": "/var/lib/kubelet/pods/73fed6f3-4cbe-46a7-af7b-6fd912e6ebd4/containers/nginx/f760f2be",
      "Destination": "/dev/termination-log",
      "Mode": "Z",
      "RW": true,
      "Propagation": "rprivate"
  }
]
```

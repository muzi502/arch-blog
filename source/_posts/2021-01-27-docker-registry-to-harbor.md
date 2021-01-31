---
title: docker registry 迁移至 harbor
date: 2021-01-031
updated:
slug: docker-registry-to-harbor
categories: 技术
tag:
  - registry
  - harbor
  - 镜像
copyright: true
comment: true
---

## Registry

### Docker Distribution

[Docker Distribution](https://github.com/distribution/distribution) 是第一个是实现了打包、发布、存储和镜像分发的工具，起到 Docker registry 的作用。其中 Docker Distribution 中的 [spec 规范](https://github.com/distribution/distribution/tree/main/docs/spec) 后来也就成为了 OCI [distribution-spec](https://github.com/opencontainers/distribution-spec) 规范。可以认为 Docker Distribution 实现了大部分 OCI 镜像分发的规范，二者在很大程度上也是兼容的。 OCI 的指导思想时先有工业界的实践，再将这些实践总结成技术规范，因此尽管 OCI 的 [distribution-spec](https://github.com/opencontainers/distribution-spec) 规范还没有正式发布（目前版本是[v1.0.0-rc1](https://github.com/opencontainers/distribution-spec/releases/tag/v1.0.0-rc1)），但以 Docker Distribution 作为基础的镜像仓库已经成为普遍采用的方案，Docker registry HTTP API V2 也就成为了事实上的标准。

### Harbor

Harbor 也是采用了 Docker Distribution （docker registry）作为后端镜像存储，在 Harbor 2.0 之前的版本，镜像相关的功能大部分是由 Docker Distribution 来处理，镜像和 OCI 等制品的元数据时 harbor 组件从 docker registry 中提取出来的；从 Harbor 2.0 版本之后，镜像等 OCI 制品相关的元数据由 Harbor 自己来维护，而且**元数据是在 PUSH 这些制品时写入到 harbor 的数据库中的**。也正因得益于此，Harbor 不再仅仅是个用来存储和管理镜像的服务，而一个云原生仓库服务，能够存储和管理符合 OCI 规范的 Helm Chart、CNAB、OPA Bundle等 Artifact 。

### docker registry to harbor

好了，扯了这么多没用的概念，回到本文要解决的问题：**如何将 docker registry 中的镜像迁移至 harbor？**

> 假如内网环境中有两台机器，一台机器上运行着 docker registry，域名假设为 registry.k8s.li 。另一台机器运行着 harbor，假设域名为 harbor.k8s.li。现在 docker registry 中存放了五千个镜像。harbor 是刚刚部署了，里面还没有镜像。在磁盘和网络没有限制的情况下，如何将 docker registry 中的镜像迁移到 harbor 中？

## 获取 registry 所有镜像的列表

根据木子在  [深入浅出容器镜像的一生🤔](https://blog.k8s.li/Exploring-container-image.html) 文章中提到的 registry 的存储目录结构，我们可以使用如下命令获取 registry 中的所有镜像的列表

![img](img/registry-storage.jpeg)

```bash
# 首先进入到 registry 存储的主目录下
cd  /var/lib/registry
find docker -type d -name "current" | sed 's|docker/registry/v2/repositories/||g;s|/_manifests/tags/|:|g;s|/current||g' > images.list
```

## 方案一：docker retag

方案一可能是大多数人首先想到的办法，也是最简单粗暴的方法。就是在一台机器上使用 docker pull 下 docker  registry 中的所有镜像，然后再 docker retag 一下，再 docker push 到 harbor 中。

```bash
# 假设其中的一个镜像为 library/alpine:latest

docker pull registry.k8s.li/library/alpine:latest

docker tag registry.k8s.li/library/alpine:latest harbor.k8s.li/library/alpine:latest

docker push harbor.k8s.li/library/alpine:latest
```

如果你之前读过木子曾经写过的 [深入浅出容器镜像的一生🤔](https://blog.k8s.li/Exploring-container-image.html) 和 [镜像搬运工 skopeo 初体验](https://blog.k8s.li/skopeo.html) 并且已经在日常生活中使用 skopeo ，你一定会很觉着这个方案很蠢，因为 docker pull –> docker tag –> docker pull 的过程中会对镜像的 layer 进行解压缩，但对于只是将镜像从一个 registry 复制到另一个 registry 来说，这些过程中做了很多无用功。详细的原理可以翻看一下刚提到的两篇文章，在此就不再赘述。

那么对于准求极致的人来讲肯定不会采用 docker retag 这么蠢的办法啦，下面就讲一下方案二：

## 方案二：skopeo

在 [镜像搬运工 skopeo 初体验](https://blog.k8s.li/skopeo.html) 中介绍过可以使用 skopeo copy 直接从一个 registry 中复制镜像原始的 layer 到另一个 registry 中，期间不会涉及镜像 layer 解压缩操作。至于性能和耗时，比 docker 高到不知道哪里去了😂。

- 使用 skopeo copy

```bash
skopeo copy docker://registry.k8s.li/library/alpine:latest \ docker://harbor.k8s.li/library/alpine:latest
```

- 使用 skopeo sync

```bash
skopeo sync --insecure-policy --src-tls-verify=false --dest-tls-verify=false --src docker --dest docker registry.k8s.li/library/alpine:latest harbor.k8s.li/library/alpine:latest
```

但还有没有更好的办法？要知道无论是 docker 和 skopeo 本质上都是通过 registry 的 HTTP API 下载和上传镜像的，在这过程中还是多了不少 HTTP 请求的，还有没有更好的办法？

## 方案三：迁移存储目录

文章开篇提到 harbor 的后端镜像存储也是使用的  docker registry，那为何不直接将 registry 的存储目录打包复制并解压到 harbor 的 registry 存储目录呢？对于 harbor 1.x 版本来将，将 docker 的 registry 存储目录迁移到 harbor 的 registry 存储目录，然后删除 harbor 的 redis 数据，重启 harbor 就完事儿了。重启 harbor 之后，harbor 会调用后端的 registry 去提取镜像的元数据信息并存储到 redis 中。这样就完成了迁移的工作。

```bash
# 切换到 harbor 的存储目录
cd /data/harbor

# 将 docker registry 备份的 docker 目录解压到 harbor 的 registry 目录下，目录层级一定要对应好
tar -xf docker.tar.gz -C ./registry

# 删除 harbor 的 regis 数据，重启 harbor 后会重建 redis 数据。
rm -f redis/dump.rdb

# 切换到 harbor 的安装目录重启 harbor
cd /opt/harbor
docker-compose restart
```

## 方案四：

对于 harbor 2.x 来讲，由于 harbor 强化了 Artifact 的元数据管理能力，即元数据在 push 或者 sync 到 harbor 时会写入到 harbor 自身的数据库中。在 harbor 看来只要数据库中没有这个 Artifact 的 manifest 信息或者没有这一层 layer 的信息，harbor 都会认为该 Artifact 或者 layer 不存在，返回 404 的错误。所以按照方案三直接而将 registry 存储目录解压到 harbor 的 registry 存储目录时行不通的。那么现在看来只能通过 skopeo copy 的方法将镜像一个一个地 push 到 harbor 中了。

对于某些特定的场景下，不能像方案二那样拥有一个 docker registry 的 HTTP 服务，只有一个 docker registry 的压缩包，这如何将 docker registry 的存储目录中的镜像迁移到 harbor 2.0 中呢？

那么再次邀请我们的 skopeo 大佬出场，在 [镜像搬运工 skopeo 初体验](https://blog.k8s.li/skopeo.html) 中提到过 skopeo 支持的`镜像格式`有如下几种：

| IMAGE NAMES             | example                                    |
| :---------------------- | :----------------------------------------- |
| **containers-storage:** | containers-storage:                        |
| **dir:**                | dir:/PATH                                  |
| **docker://**           | docker://k8s.gcr.io/kube-apiserver:v1.17.5 |
| **docker-daemon:**      | docker-daemon:alpine:latest                |
| **docker-archive:**     | docker-archive:alpine.tar (docker save)    |
| **oci:**                | oci:alpine:latest                          |

> 需要注意的是，这几种镜像的名字，对应着镜像存在的方式，不同存在的方式对镜像的 layer 处理的方式也不一样，比如 `docker://` 这种方式是存在 registry 上的，`docker-daemon:` 是存在本地 docker pull 下来的，再比如 `docker-archive` 是通过 docker save 出来的镜像。同一个镜像有这几种存在的方式就像水有气体、液体、固体一样。可以这样去理解，他们表述的都是同一个镜像，只不过是存在的方式不一样而已。

既然镜像是存放在 registry 存储目录里的，那么使用 dir 的形式直接从文件系统读取镜像，理论上来讲会比方案二要好一些。虽然 skopeo 支持 dir 格式的镜像，但 skopeo 目前并不支持直接使用 registry 的存储目录，所以还是需要想办法将 docker registry 存储目录里的每一个镜像转换成 skopeo dir 的形式。

### skopeo dir

那么先来看一下 skopeo dir 是什么样子的？

为了方便测试方案的可行性，先使用 skopeo 命令先从 docker hub 上拉取一个镜像，并保存为 dir，命令如下：

```bash
skopeo copy docker://alpine:latest dir:./alpine
```

使用 tree 命令查看一下 alpine 文件夹的目录结构，如下：

```shell
╭─root@sg-02 /var/lib/registry
╰─# tree -h alpine
alpine
├── [2.7M]  4c0d98bf9879488e0407f897d9dd4bf758555a78e39675e72b5124ccf12c2580
├── [1.4K]  e50c909a8df2b7c8b92a6e8730e210ebe98e5082871e66edd8ef4d90838cbd25
├── [ 528]  manifest.json
└── [  33]  version

0 directories, 4 files
╭─root@sg-02 /var/lib/registry
╰─# file alpine/e50c909a8df2b7c8b92a6e8730e210ebe98e5082871e66edd8ef4d90838cbd25
alpine/e50c909a8df2b7c8b92a6e8730e210ebe98e5082871e66edd8ef4d90838cbd25: ASCII text, with very long lines, with no line terminators

╭─root@sg-02 /var/lib/registry
╰─# file alpine/4c0d98bf9879488e0407f897d9dd4bf758555a78e39675e72b5124ccf12c2580
alpine/4c0d98bf9879488e0407f897d9dd4bf758555a78e39675e72b5124ccf12c2580: gzip compressed data
```

从文件名和大小以及文件的内省我们可以判断出，manifest 文件对应的就是镜像的 manifests 文件；类型为 `ASCII text` 的文件正是镜像的 image config 文件，里面包含着镜像的元数据信息。而另一个 `gzip compressed data` 文件不就是经过 gzip 压缩过的镜像 layer 嘛。看一下 manifest 文件的内容也再次印证了这个结论：

- 镜像的 config 字段对应的正是 e50c909a8df2，而文件类型正是 `image.v1+json` 文本文件。
- 镜像的 layer 字段对应的也正是  4c0d98bf9879 而文件类型正是  `.tar.gzip` gzip 压缩文件。

```json
alpine/4c0d98bf9879488e0407f897d9dd4bf758555a78e39675e72b5124ccf12c2580: gzip compressed data
╭─root@sg-02 /var/lib/registry
╰─# cat alpine/manifest.json
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
   "config": {
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 1471,
      "digest": "sha256:e50c909a8df2b7c8b92a6e8730e210ebe98e5082871e66edd8ef4d90838cbd25"
   },
   "layers": [
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 2811321,
         "digest": "sha256:4c0d98bf9879488e0407f897d9dd4bf758555a78e39675e72b5124ccf12c2580"
      }
   ]
}
```

### 从 registry 存储目录中抠镜像出来

接下来到本文的精彩的地方了。如何将 registry 存储里的镜像提取出来，转换成 skopeo 所支持的 dir 格式。

![img](img/registry-storage.jpeg)

- 首先要得到镜像的 manifests 文件，从 manifests 文件中得到所有的 blob 文件。例如对于 registry 存储目录中的 `library/alpine:latest` 镜像。

```shell
╭─root@sg-02 /var/lib/registry/docker/registry/v2
╰─# tree
.
├── blobs
│   └── sha256
│       ├── 21
│       │   └── 21c83c5242199776c232920ddb58cfa2a46b17e42ed831ca9001c8dbc532d22d
│       │       └── data
│       ├── a1
│       │   └── a143f3ba578f79e2c7b3022c488e6e12a35836cd4a6eb9e363d7f3a07d848590
│       │       └── data
│       └── be
│           └── be4e4bea2c2e15b403bb321562e78ea84b501fb41497472e91ecb41504e8a27c
│               └── data
└── repositories
    └── library
        └── alpine
            ├── _layers
            │   └── sha256
            │       ├── 21c83c5242199776c232920ddb58cfa2a46b17e42ed831ca9001c8dbc532d22d
            │       │   └── link
            │       └── be4e4bea2c2e15b403bb321562e78ea84b501fb41497472e91ecb41504e8a27c
            │           └── link
            ├── _manifests
            │   ├── revisions
            │   │   └── sha256
            │   │       └── a143f3ba578f79e2c7b3022c488e6e12a35836cd4a6eb9e363d7f3a07d848590
            │   │           └── link
            │   └── tags
            │       └── latest
            │           ├── current
            │           │   └── link
            │           └── index
            │               └── sha256
            │                   └── a143f3ba578f79e2c7b3022c488e6e12a35836cd4a6eb9e363d7f3a07d848590
            │                       └── link
            └── _uploads

26 directories, 8 files
```

1. 通过 `repositories/library/alpine/_manifests/tags/latest/current/link` 文件得到 manifests 文件的 sha256 值，然后根据这个 sha256 值去 blobs 找到镜像的 manifests 文件;

```shell
╭─root@sg-02 /var/lib/registry/docker/registry/v2/repositories/library/alpine/_manifests/tags/latest/current/
╰─# cat link
sha256:39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01#
```

2. 根据 link 文件中的 sha256 值在 blobs 目录下找到与之对应的文件，blobs 目录下对应的 manifests 文件为 blobs/sha256/39/39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01/data;

```json
╭─root@sg-02 /var/lib/registry/docker/registry/v2/repositories/library/alpine/_manifests/tags/latest/current
╰─# cat /var/lib/registry/docker/registry/v2/blobs/sha256/39/39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01/data
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
   "config": {
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 1507,
      "digest": "sha256:f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a"
   },
   "layers": [
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 2813316,
         "digest": "sha256:cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08"
      }
   ]
}
```

3. 使用正则匹配，过滤出 manifests 文件中的所有 sha256 值，这些 sha256 值就对应着 blobs 目录下的 image config 文件和 image layer 文件

```bash
╭─root@sg-02 /var/lib/registry/docker/registry/v2/repositories/library/alpine/_manifests/tags/latest/current
╰─# cat /var/lib/registry/docker/registry/v2/blobs/sha256/39/39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01/data | grep -Eo "\b[a-f0-9]{64}\b"
f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a
cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08
```

4. 根据 manifests 文件就可以得到 blobs 目录中镜像的所有 layer 和 image config 文件，然后将这些文件拼成一个 dir 格式的镜像，在这里使用 cp 的方式将镜像从 registry 存储目录里 `捞` 出来😂

```shell

# 首先创建一个文件夹，为了保留镜像的 name 和 tag，文件夹的名称就对应的是 NAME:TAG
╭─root@sg-02 /var/lib/registry/docker
╰─# mkdir -p skopeo/library/alpine:latest
╭─root@sg-02 /var/lib/registry/docker
╰─# cp /var/lib/registry/docker/registry/v2/blobs/sha256/39/39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01/data skopeo/library/alpine:latest/manifest
╭─root@sg-02 /var/lib/registry/docker
╰─# cp /var/lib/registry/docker/registry/v2/blobs/sha256/f7/f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a/data skopeo/library/alpine:latest/f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a
╭─root@sg-02 /var/lib/registry/docker
╰─# cp /var/lib/registry/docker/registry/v2/blobs/sha256/cb/cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08/data skopeo/library/alpine:latest/cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08
╭─root@sg-02 /var/lib/registry/docker
╰─# tree skopeo/library/alpine:latest
skopeo/library/alpine:latest
├── cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08
├── f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a
└── manifest

0 directories, 3 files

```

和上面的 skopeo copy 出来的 dir 文件夹对比一下，到此为止镜像所需要的文件就基本上都齐全了，就差一个 version 文件，这个文件无关紧要可以去掉。

5. 再优化一下，将步骤 4 中的 cp 操作修改成硬链接操作，能极大减少磁盘的 IO 操作。需要注意，硬链接文件不能跨分区，所以要和 registry 存储目录在同一个分区下才行。

```shell
╭─root@sg-02 /var/lib/registry/docker
╰─# ln /var/lib/registry/docker/registry/v2/blobs/sha256/39/39eda93d15866957feaee28f8fc5adb545276a64147445c64992ef69804dbf01/data skopeo/library/alpine:latest/manifest
╭─root@sg-02 /var/lib/registry/docker
╰─# ln /var/lib/registry/docker/registry/v2/blobs/sha256/f7/f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a/data skopeo/library/alpine:latest/f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a
╭─root@sg-02 /var/lib/registry/docker
╰─# ln /var/lib/registry/docker/registry/v2/blobs/sha256/cb/cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08/data skopeo/library/alpine:latest/cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08
╭─root@sg-02 /var/lib/registry/docker
╰─# tree skopeo/library/alpine:latest
skopeo/library/alpine:latest
├── cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08
├── f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a
└── manifest

0 directories, 3 files
```

然后使用 skopeo copy 或者 skopeo sync 将镜像 push 到 harbor

- 使用 skopeo copy

```shell
skopeo copy  --insecure-policy --src-tls-verify=false --dest-tls-verify=false \
dir:skopeo/library/alpine:latest docker://harbor.k8s.li/library/alpine:latest
```

- 使用 skopeo sync

需要注意的是，skopeo sync 的方式是同步 project 级别的，镜像的 name 和 tag 就对应的是目录的名称

```shell
skopeo sync --insecure-policy --src-tls-verify=false --dest-tls-verify=false \
--src dir --dest docker skopeo/library/ harbor.k8s.li/library/

```

### 实现脚本

大叫一声 shell 大法好！😂

```shell
#!/bin/bash
REGISTRY_DOMAIN="harbor.k8s.li"
REGISTRY_PATH="/var/lib/registry"

# 切换到 registry 存储主目录下
cd ${REGISTRY_PATH}

gen_skopeo_dir() {
   # 定义 registry 存储的 blob 目录 和 repositories 目录，方便后面使用
    BLOB_DIR="docker/registry/v2/blobs/sha256"
    REPO_DIR="docker/registry/v2/repositories"
    # 定义生成 skopeo 目录
    SKOPEO_DIR="docker/skopeo"
    # 通过 find 出 current 文件夹可以得到所有带 tag 的镜像，因为一个 tag 对应一个 current 目录
    for image in $(find ${REPO_DIR} -type d -name "current"); do
        # 根据镜像的 tag 提取镜像的名字
        name=$(echo ${image} | awk -F '/' '{print $5"/"$6":"$9}')
        link=$(cat ${image}/link | sed 's/sha256://')
        mfs="${BLOB_DIR}/${link:0:2}/${link}/data"
        # 创建镜像的硬链接需要的目录
        mkdir -p "${SKOPEO_DIR}/${name}"
        # 硬链接镜像的 manifests 文件到目录的 manifest 文件
        ln ${mfs} ${SKOPEO_DIR}/${name}/manifest.json
        # 使用正则匹配出所有的 sha256 值，然后排序去重
        layers=$(grep -Eo "\b[a-f0-9]{64}\b" ${mfs} | sort -n | uniq)
        for layer in ${layers}; do
          # 硬链接 registry 存储目录里的镜像 layer 和 images config 到镜像的 dir 目录
            ln ${BLOB_DIR}/${layer:0:2}/${layer}/data ${SKOPEO_DIR}/${name}/${layer}
        done
    done
}

sync_image() {
    # 使用 skopeo sync 将 dir 格式的镜像同步到 harbor
    for project in $(ls ${SKOPEO_DIR}); do
        skopeo sync --insecure-policy --src-tls-verify=false --dest-tls-verify=false \
        --src dir --dest docker ${SKOPEO_DIR}/${project} ${REGISTRY_DOMAIN}/${project}
    done
}

gen_skopeo_dir
sync_image

```

其实魔改一下 skopeo 的源码也是可以无缝支持 registry 存储目录的，目前正在研究中😃

## 对比

|      | 方法         | 适用范围                           | 缺点              |
| ---- | ------------ | ---------------------------------- | ----------------- |
| 一   | docker retag | 两个 registry 之间同步镜像         |                   |
| 二   | skopeo       | 两个 registry 之间同步镜像         |                   |
| 三   | 解压目录     | registry 存储目录到另一个 registry | harbor 1.x        |
| 四   | skopeo dir   | registry 存储目录到另一个 registry | 适用于 harbor 2.x |

对比总结一下以上几种方案：

- 方案一：上手成本低，适用于镜像数量比较多少，无需安装 skopeo 的情况，缺点是性能较差；
- 方案二：适用于两个 registry 之间同步复制镜像，如将 docker hub 中的一些公共镜像复制到公司内网的镜像仓库中。
- 方案三：适用于镜像仓库之间进行迁移，性能是所有方案里最好的，需要额外注意的是如果目的镜像仓库是 harbor 2.x，是无法使用这种方式的。
- 方案四：是方案三的妥协版，为了适配 harbor 2.0 ，因为需要重新将镜像 push 到 harbor ，所以性能上要比方案三差一些。

## 参考

- [《harbor权威指南》]()
- [Harbor 2.0 takes a giant leap in expanding supported artifacts with OCI support](https://goharbor.io/blog/harbor-2.0/)

---
title: 镜像的一生
date: 2020-06-06
updated: 2020-06-06
slug:
categories: 技术
tag:
  - docker
  - image
  - registry
copyright: true
comment: true
---

上周在写[《镜像搬运工 skopeo 初体验》](https://blog.k8s.li/skopeo.html)时候看了很多关于容器镜像相关的博客，从大佬们那里偷偷学了不少知识，对容器镜像有了一点点深入的了解。这周末一个人闲着宅在家里没事就把最近所学的知识整理一下分享出来，大家一起来食用。同是也为自己查漏补缺，加深对这些基础知识的理解。

## 镜像是怎样炼成的🤔

对于正处于容器时代的我们来讲，容器已经是我们互联网行业家喻户晓的工具。

OCI目前有两个规范： 运行时规范 ([runtime-spec](https://github.com/opencontainers/runtime-spec)) 和镜像规范 ([image-spec](http://www.github.com/opencontainers/image-spec))。 运行时规范介绍了如何运行解压缩到磁盘上的 “[filesystem bundle](https://github.com/opencontainers/runtime-spec/blob/master/bundle.md)”。 概括来说，实施OCI会下载OCI镜像，然后将该镜像解压到某个OCI Runtime Bundle fliesystem bundle。此时，某个OCI运行时会运行该OCI Runtime Bundle。

### OCI image-spec

#### layer

[文件系统](https://github.com/opencontainers/image-spec/blob/master/layer.md)：以 layer 保存的文件系统，每个 layer 保存了和上层之间变化的部分，layer 应该保存哪些文件，怎么表示增加、修改和删除的文件等。

#### config

[config 文件](https://github.com/opencontainers/image-spec/blob/master/config.md)：保存了文件系统的层级信息（每个层级的 hash 值，以及历史信息），以及容器运行时需要的一些信息（比如环境变量、工作目录、命令参数、mount 列表），指定了镜像在某个特定平台和系统的配置。比较接近我们使用 `docker inspect <image_id>` 看到的内容

#### manifest

[manifest 文件](https://github.com/opencontainers/image-spec/blob/master/manifest.md)：镜像的 config 文件索引，有哪些 layer，额外的 annotation 信息，manifest 文件中保存了很多和当前平台有关的信息

#### index

[index 文件](https://github.com/opencontainers/image-spec/blob/master/image-index.md)：可选的文件，指向不同平台的 manifest 文件，这个文件能保证一个镜像可以跨平台使用，每个平台拥有不同的 manifest 文件，使用 index 作为索引。

#### example

```json
[
    {
        "Id": "sha256:30d9679b0b1ca7e56096eca0cdb7a6eedc29b63968f25156ef60dec27bc7d206",
        "RepoTags": [
            "webpsh/webps:latest"
        ],
        "RepoDigests": [
       "webpsh/webps@sha256:8c00cbb0a78aa5ec0fc80c55cb765414800ebd86d2c8fc6c13b80a06a95a5b96"
        ],
        "Parent": "",
        "Comment": "",
        "Created": "2020-05-23T08:44:52.312682538Z",
        "Container": "77832fa5c28c66ecfeddb819753c3d450fc1b8f4642bbcb4c139e5f4af4de8c6",
        "ContainerConfig": {
            "Hostname": "77832fa5c28c",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "#(nop) ",
                "CMD [\"/usr/bin/webp-server\" \"--config\" \"/etc/config.json\"]"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:72890c3501685064e5ce6e955698d20c27171c721bd80f5cd022be9d3b489576",
            "Volumes": {
                "/opt/exhaust": {}
            },
            "WorkingDir": "/opt",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "DockerVersion": "18.03.1-ee-3",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/usr/bin/webp-server",
                "--config",
                "/etc/config.json"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:72890c3501685064e5ce6e955698d20c27171c721bd80f5cd022be9d3b489576",
            "Volumes": {
                "/opt/exhaust": {}
            },
            "WorkingDir": "/opt",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 20549472,
        "VirtualSize": 20549472,
        "GraphDriver": {
            "Data": {
                "LowerDir": "/opt/docker/overlay2/e31dcab3fed6b1a16ca60e9bdb26be0dcd2be253f2ab0cc7f3b0220e98caab2a/diff:/opt/docker/overlay2/259cf6934509a674b1158f0a6c90c60c133fd11189f98945c7c3a524784509ff/diff",
                "MergedDir": "/opt/docker/overlay2/35366b925242eea6e7fbd3e51946062531ee00e2b4032c6be5e62a44e13c1bbb/merged",
                "UpperDir": "/opt/docker/overlay2/35366b925242eea6e7fbd3e51946062531ee00e2b4032c6be5e62a44e13c1bbb/diff",
                "WorkDir": "/opt/docker/overlay2/35366b925242eea6e7fbd3e51946062531ee00e2b4032c6be5e62a44e13c1bbb/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:3e207b409db364b595ba862cdc12be96dcdad8e36c59a03b7b3b61c946a5741a",
                "sha256:e8896357b09d7f18aa7959ec3156b46f1051e101436533c9df28d2d5c9868f1a",
                "sha256:7fa7d2998ee02838dab0997606b8f78103bb688a5fab67eaa26297bcca04bd78"
            ]
        },
        "Metadata": {
            "LastTagTime": "0001-01-01T00:00:00Z"
        }
    }
]
```

### Dockerfile

```dockerfile
FROM golang:alpine as builder
ARG IMG_PATH=/opt/pics
ARG EXHAUST_PATH=/opt/exhaust
RUN apk update ;\
    apk add alpine-sdk ;\
    git clone https://github.com/webp-sh/webp_server_go /build ;\
    cd /build ;\
    sed -i "s|.\/pics|${IMG_PATH}|g" config.json ;\
    sed -i "s|\"\"|\"${EXHAUST_PATH}\"|g" config.json ;\
    sed -i 's/127.0.0.1/0.0.0.0/g' config.json
WORKDIR /build
RUN go build -o webp-server .
FROM alpine
COPY --from=builder /build/webp-server  /usr/bin/webp-server
COPY --from=builder /build/config.json /etc/config.json
WORKDIR /opt
VOLUME /opt/exhaust
CMD ["/usr/bin/webp-server", "--config", "/etc/config.json"]
```

需要注意的是，在 RUN 指令的每行结尾我使用的是 `;\` 来接下一行 shell ，另一种写法是 `&&` 。二者有本质的区别，比如 COMMAND 1;COMMAND 2 ，当 `COMMAND 1` 运行失败时也继续运行 `COMMAND2`。而 COMMAND 1&& COMMAND 2，时 `COMMAND 1` 运行成功时才接着运行 `COMMAND 2` ， `COMMAND 1`运行失败会退出。不过建议用 `&&` ，如果是老司机的话用 `;` ，docker hub 官方镜像中用 `;` 较多一些，因为 `;` 比 `&&` 要美观一些（大雾😂

### base image

当我们在写 `Dockerfile` 的时候都需要一个 `FROM` 语句来指定一个基础镜像，这些基础镜像并不是无中生有，也许需要一个 `Dockerfile` 来炼制成镜像。下面我们拿来 [debian:buster](https://hub.docker.com/_/debian) 这个基础镜像的 [Dockerfile](https://github.com/debuerreotype/docker-debian-artifacts/blob/18cb4d0418be1c80fb19141b69ac2e0600b2d601/buster/Dockerfile) 来看一下基础镜像是如何练成的。

```dockerfile
FROM scratch
ADD rootfs.tar.xz /
CMD ["bash"]
```

你没看错，一个基础镜像的 `Dockerfile` 一般仅有三行。第一行 `FROM scratch` 中的`scratch` 这个镜像并不真实的存在。当你使用 `docker pull scratch` 命令来拉取这个镜像的时候会翻车哦，提示 `Error response from daemon: 'scratch' is a reserved name`。这是因为自从 docker 1.5 版本开始，在 Dockerfile 中 `FROM scratch` 指令并不进行任何操作，也就是不会创建一个镜像层。接着第二行的 `ADD rootfs.tar.xz /` 产生的一层镜像就是最终构建的镜像。第三行 `CMD ["bash"]` 指定这镜像在启动容器的时候执行的应用程序。

>   As of Docker 1.5.0 (specifically, [`docker/docker#8827`](https://github.com/docker/docker/pull/8827)), `FROM scratch` is a no-op in the `Dockerfile`, and will not create an extra layer in your image (so a previously 2-layer image will be a 1-layer image instead).

`ADD rootfs.tar.xz /` 中，这个 `rootfs.tar.xz` 就是我们经过一系列骚操作搓出来的根文件系统，这个操作比较复杂，木子太菜了就不在这里瞎掰掰了🤣，所以感兴趣的可以去看一下构建 debian 基础镜像的 Jenkins 流水线任务 [debuerreotype](https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/)，上面有构建这个 `rootfs.tar.xz` 完整过程，或者参考 Debian 官方的 [docker-debian-artifacts](https://github.com/debuerreotype/docker-debian-artifacts) 这个 repo 里的 shell 脚本。其实基础镜像通过一系列操作，比如源码构建，搓出来一个 `rootfs.tar.xz` 就可以啦。

需要额外注意一点，在这里往镜像里添加 `rootfs.tar.xz` 时使用的时 `ADD` 而不是 `COPY` ，因为在 Dockerfile 中的 ADD 指令 src 文件可以是本机当前目录下的文件，也可以是个 URL ，而且如果往里面添加的文件是个 tar 包 ，使用 ADD 指令构建的时候 docker 会帮我们把 tar 包解开，使用 COPY 并不会解开 tarball 。

>   PS：面试的时候经常被问 ADD 和 COPY 的区别😂。

搓这个 `rootfs.tar.xz` 不同的发行版方法可能不太一样，Debian 发行版的  `rootfs.tar.xz` 可以在 [docker-debian-artifacts](https://github.com/debuerreotype/docker-debian-artifacts) 这个 repo 上找到，根据不同处理器 arch 选择相应的 branch ，然后这个 branch 下的目录就对应着该发行版的不同的版本的代号。发现 Debian 官方是将所有 arch 和所有版本的 `rootfs.tar.xz` 都放在这个 repo 里的，以至于这个 repo 的大小接近 2.88 GiB 😨，当网盘来用的嘛🤣（：手动滑稽

```shell
╭─root@sg-02 ~
╰─# git clone https://github.com/debuerreotype/docker-debian-artifacts
Cloning into 'docker-debian-artifacts'...
remote: Enumerating objects: 278, done.
remote: Counting objects: 100% (278/278), done.
Receiving objects:  67% (443/660), 1.60 GiB | 16.96 MiB/s
remote: Total 660 (delta 130), reused 244 (delta 97), pack-reused 382
Receiving objects: 100% (660/660), 2.88 GiB | 16.63 MiB/s, done.
Resolving deltas: 100% (267/267), done.
```

我们把这个 `rootfs.tar.xz` 解开就可以看到，这就是一个 Linux 的根文件系统，不同于我们使用 ISO 安装系统的那个根文件系统，这个根文件系统是经过一系列的裁剪，去掉了一些在容器运行中不必要的文件，使之更加轻量适用于容器运行的场景，整个根跟文件系统的大小为 125M，如果使用 slim 的`rootfs.tar.xz` 会更小一些，仅仅 76M。当然相比于仅仅几M 的 `alpine` ，这算是够大的了。

```shell
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# git checkout dist-amd64
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# cd buster
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# mkdir rootfs
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# tar -xvf rootfs.tar.xz -C !$
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# ls rootfs/
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# du -sh rootfs
125M    rootfs
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64*›
╰─# du -sh slim/rootfs
76M     slim/rootfs
```

想要自己亲自~~指挥~~炼制一个 debian 基础镜像其实很简单，就像下面这样一把梭操作下来就行😂：

```shell
git clone https://github.com/debuerreotype/docker-debian-artifacts debian
cd !$
git checkout dist-amd64
cd buster
docker build -t debian:buster .
```

下面就是构建 Debian 基础镜像的过程，正如 Dockerfile 中的那样，最终只产生了一层镜像。

```shell
docker build -t debian:buster .
Sending build context to Docker daemon  30.12MB
Step 1/3 : FROM scratch
 --->
Step 2/3 : ADD rootfs.tar.xz /
 ---> 1756d6a585ae
Step 3/3 : CMD ["bash"]
 ---> Running in c86a8b6deb3d
Removing intermediate container c86a8b6deb3d
 ---> 04948daa3c2e
Successfully built 04948daa3c2e
Successfully tagged debian:buster
```

### layer

## 镜像是怎么搬运的🤣

在搬运一个镜像之前

### docker

#### docker pull

#### docker push

#### docker save

docker save

注意，docker save 只能导出来 tar 包，所以当你 docker save -o images.tar.gz 时，你得到的并不是个 gzip 压缩过的 tar 包。所以如果你想得到一个真正的 .tar.gz 格式的正确的搬运姿势就是 docker save -o image.tar && gzip image.tar

#### docker load

### Python

#### [docker-drag](https://github.com/NotGlop/docker-drag)

```python

```

### skopeo

#### skopeo copy

#### skopeo inspect

### containerd

## 镜像是怎样存放的🙄

在开始 hack 之前我们先统一一下环境信息，我使用的机器是 Ubuntu 1804，`docker info` 信息如下：

```yaml
╭─root@sg-02 /var/lib/docker
╰─# docker info
Client:
 Debug Mode: false
 Plugins:
  buildx: Build with BuildKit (Docker Inc., v0.3.1-tp-docker)
  app: Docker Application (Docker Inc., v0.8.0)
Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 2
 Server Version: 19.03.5
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: b34a5c8af56e510852c35414db4c1f4fa6172339
 runc version: 3e425f80a8c931f88e6d94a8c831b9d5aa481657
 init version: fec3683
 Security Options:
  apparmor
  seccomp
   Profile: default
 Kernel Version: 4.15.0-1052-aws
 Operating System: Ubuntu 18.04.1 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 1
 Total Memory: 983.9MiB
 Name: sg-02
 ID: B7J5:Y7ZM:Y477:7AS6:WMYI:6NLV:YOMA:W32Y:H4NZ:UQVD:XHDX:Y5EF
 Docker Root Dir: /opt/docker
 Debug Mode: false
 Username: webpsh
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  127.0.0.0/8
 Registry Mirrors:
  https://registry.k8s.li/
 Live Restore Enabled: false
```

为了方便分析，我将其他的 docker image 全部清空掉，只保留 `alpine:latest` 和 `registry:v2` 这两个镜像，这两个镜像足够帮助我们理解容器镜像是如何存放的，镜像多了多话分析下面存储目录的时候可能不太方便（＞﹏＜）

```shell
╭─root@sg-02 /var/lib/docker
╰─# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
alpine              latest              f70734b6a266        6 weeks ago         5.61MB
registry            2                   708bc6af7e5e        4 months ago        25.8MB
```

### docker (/var/lib/docker)

```shell
╭─root@sg-02 /var/lib/docker
╰─# tree -d -L 1
.
├── builder
├── buildkit
├── containers
├── image
├── network
├── overlay2
├── plugins
├── runtimes
├── swarm
├── tmp
├── trust
└── volumes

12 directories
```

关于容器镜像的存储，我们只关心 image 和 overlay2 这两个文件夹即可，容器的元数据存放在 image 目录下，容器的 layer 数据存放在 overlay2 目录下。

#### /var/lib/docker/image

```shell
image
└── overlay2
    ├── distribution
    │   ├── diffid-by-digest
    │   │   └── sha256
    │   │       ├── 039b991354af4dcbc534338f687e27643c717bb57e11b87c2e81d50bdd0b2376
    │   │       ├── 09a4142c5c9dde2fbf35e7a6e6475eba75a8c28540c375c80be7eade4b7cb438
    │   └── v2metadata-by-diffid
    │       └── sha256
    │           ├── 0683de2821778aa9546bf3d3e6944df779daba1582631b7ea3517bb36f9e4007
    │           ├── 0f7493e3a35bab1679e587b41b353b041dca1e7043be230670969703f28a1d83
    ├── imagedb
    │   ├── content
    │   │   └── sha256
    │   │       ├── 708bc6af7e5e539bdb59707bbf1053cc2166622f5e1b17666f0ba5829ca6aaea
    │   │       └── f70734b6a266dcb5f44c383274821207885b549b75c8e119404917a61335981a
    │   └── metadata
    │       └── sha256
    ├── layerdb
    │   ├── mounts
    │   ├── sha256
    │   │   ├── b9835d6a62886d4e85b65abb120c0ea44ff1b3d116d7a707620785d4664d8c1a
    │   │   │   ├── cache-id
    │   │   │   ├── diff
    │   │   │   ├── parent
    │   │   │   ├── size
    │   │   │   └── tar-split.json.gz
    │   │   └── d9b567b77bcdb9d8944d3654ea9bb5f6f4f7c4d07a264b2e40b1bb09af171dd3
    │   │       ├── cache-id
    │   │       ├── diff
    │   │       ├── parent
    │   │       ├── size
    │   │       └── tar-split.json.gz
    │   └── tmp
    └── repositories.json
21 directories, 119 files
```

#### /var/lib/docker/overlay2

下面是一段从 StackOverflow 上搬运过来的解释，

>   **LowerDir**: these are the read-only layers of an overlay filesystem. For docker, these are the image layers assembled in order.
>
>   **UpperDir**: this is the read-write layer of an overlay filesystem. For docker, that is the equivalent of the container specific layer that contains changes made by that container.
>
>   **WorkDir**: this is a required directory for overlay, it needs an empty directory for internal use.
>
>   **MergedDir**: this is the result of the overlay filesystem. Docker effectively chroot's into this directory when running the container.

如果想对 overlayfs 文件系统有详细的了解，可以参考 Linux 内核官网上的这篇文档 [overlayfs.txt](https://www.kernel.org/doc/Documentation/filesystems/overlayfs.txt) 。

从 docker 官方文档 [Use the OverlayFS storage driver](https://docs.docker.com/storage/storagedriver/overlayfs-driver/) 偷来的一张图片

![overlayfs lowerdir, upperdir, merged](img/overlay_constructs.jpg)

```shell
overlay2
├── 259cf6934509a674b1158f0a6c90c60c133fd11189f98945c7c3a524784509ff
│   └── diff
│       ├── bin
│       ├── dev
│       ├── etc
│       ├── home
│       ├── lib
│       ├── media
│       ├── mnt
│       ├── opt
│       ├── proc
│       ├── root
│       ├── run
│       ├── sbin
│       ├── srv
│       ├── sys
│       ├── tmp
│       ├── usr
│       └── var
├── 27f9e9b74a88a269121b4e77330a665d6cca4719cb9a58bfc96a2b88a07af805
│   ├── diff
│   └── work
├── a0df3cc902cfbdee180e8bfa399d946f9022529d12dba3bc0b13fb7534120015
│   ├── diff
│   │   └── bin
│   └── work
├── b2fbebb39522cb6f1f5ecbc22b7bec5e9bc6ecc25ac942d9e26f8f94a028baec
│   ├── diff
│   │   ├── etc
│   │   ├── lib
│   │   ├── usr
│   │   └── var
│   └── work
├── be8c12f63bebacb3d7d78a09990dce2a5837d86643f674a8fd80e187d8877db9
│   ├── diff
│   │   └── etc
│   └── work
├── e8f6e78aa1afeb96039c56f652bb6cd4bbd3daad172324c2172bad9b6c0a968d
│   └── diff
│       ├── bin
│       ├── dev
│       ├── etc
│       ├── home
│       ├── lib
│       ├── media
│       ├── mnt
│       ├── proc
│       ├── root
│       ├── run
│       ├── sbin
│       ├── srv
│       ├── sys
│       ├── tmp
│       ├── usr
│       └── var
└── l
    ├── 526XCHXRJMZXRIHN4YWJH2QLPY -> ../b2fbebb39522cb6f1f5ecbc22b7bec5e9bc6ecc25ac942d9e26f8f94a028baec/diff
    ├── 5RZOXYR35NSGAWTI36CVUIRW7U -> ../be8c12f63bebacb3d7d78a09990dce2a5837d86643f674a8fd80e187d8877db9/diff
    ├── LBWRL4ZXGBWOTN5JDCDZVNOY7H -> ../a0df3cc902cfbdee180e8bfa399d946f9022529d12dba3bc0b13fb7534120015/diff
    ├── MYRYBGZRI4I76MJWQHN7VLZXLW -> ../27f9e9b74a88a269121b4e77330a665d6cca4719cb9a58bfc96a2b88a07af805/diff
    ├── PCIS4FYUJP4X2D4RWB7ETFL6K2 -> ../259cf6934509a674b1158f0a6c90c60c133fd11189f98945c7c3a524784509ff/diff
    └── XK5IA4BWQ2CIS667J3SXPXGQK5 -> ../e8f6e78aa1afeb96039c56f652bb6cd4bbd3daad172324c2172bad9b6c0a968d/diff

62 directories
```



### registry (/registry/docker/v2)

```shell

```

#### docker.io

docker hub 上的 library 镜像即官方镜像的构建可以参考 docker hub 官方的这个 repo [docker-library/oi-janky-groovy](https://github.com/docker-library/oi-janky-groovy) ，是使用 Jenkins 进行构建的。



#### quay.io

这个是红帽子家的 registry，去年的时候已经开源了

#### 私有 registry

目前

### docker-archive

本来我想着 docker save 出来的并不是一个镜像，而是一个 `.tar` 文件，但我想了又想，还是觉着它是一个镜像，只不过存在的方式不同而已。于在 docker 和 registry 中存放的方式不同，使用 docker save 出来的镜像是一个孤立的存在。就像是从蛋糕店里拿出来的蛋糕，外面肯定要有个精美的包装是吧，你总没见过。放在哪里都可以，使用的时候我们使用 docker load 拆开外包装(`.tar`)就可。

## 镜像是怎么食用的😋

### docker

当我们启动一个容器之后我们使用 tree 命令来分析一下 overlay2 就会发现，在

```shell
╭─root@sg-02 /var/lib/docker
╰─# tree overlay2 -d -L 3
overlay2
├── 259cf6934509a674b1158f0a6c90c60c133fd11189f98945c7c3a524784509ff
│   └── diff
│       ├── bin
|
│       └── var
├── 27f9e9b74a88a269121b4e77330a665d6cca4719cb9a58bfc96a2b88a07af805
│   ├── diff
│   └── work
├── 5f85c914c55220ec2635bce0080d2ad677f739dcfac4fd266b773625e3051844
│   ├── diff
│   │   └── var
│   ├── merged
│   │   ├── bin
│   │   ├── dev
│   │   ├── etc
│   │   ├── home
│   │   ├── lib
│   │   ├── media
│   │   ├── mnt
│   │   ├── proc
│   │   ├── root
│   │   ├── run
│   │   ├── sbin
│   │   ├── srv
│   │   ├── sys
│   │   ├── tmp
│   │   ├── usr
│   │   └── var
│   └── work
│       └── work
├── 5f85c914c55220ec2635bce0080d2ad677f739dcfac4fd266b773625e3051844-init
│   ├── diff
│   │   ├── dev
│   │   └── etc
│   └── work
│       └── work
```



### containerd

### Pod

## 镜像是怎么焚毁的

当我们食用完一个镜像之后，如果今后不再需要它了，我们怎么从本地删除一个镜像呢，其实就是 `rm -rf /` 啦（才不是x

## 镜像的一生

到此为止，走我们马观花式的看完了镜像的一生：它诞生于一个 Dockerfile，

## 参考

### 官方文档

-   [Create a base image](https://docs.docker.com/develop/develop-images/baseimages/)
-   [FROM scratch](https://hub.docker.com/_/scratch)

### 源码

-   [oi-janky-groovy](https://github.com/docker-library/oi-janky-groovy)

-   [docker-debian-artifacts](https://github.com/debuerreotype/docker-debian-artifacts)
-   

### 博客


---
title: 深入浅出容器镜像的一生
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

上周在写[《镜像搬运工 skopeo 》](https://blog.k8s.li/skopeo.html)的时候看了很多关于容器镜像相关的博客，从大佬们那里偷偷学了不少知识，对容器镜像有了一点点深入的了解。这周末一个人闲着宅在家里没事就把最近所学的知识整理一下分享出来，供大家一起来食用。同是也为自己查漏补缺，加深对这些基础知识的理解。

>   PS：木子花了一天的时间亲自~~指挥~~写完的这篇博客，内容比较多，耐心看完的话，还是能收获一些~~没用的~~知识滴😂

## 镜像是怎样炼成的🤔

所谓炼成像就是构建镜像啦，下面用到的**搓**和**炼制**都是指的构建镜像啦，只是个人习惯用语而已😂。

提到容器镜像就不得不提一下 OCI ，即 Open Container Initiative 旨在围绕容器格式和运行时制定一个开放的工业化标准。目前 OCI 主要有三个规范： 运行时规范 [runtime-spec](https://github.com/opencontainers/runtime-spec) ，镜像规范 [image-spec](http://www.github.com/opencontainers/image-spec) 以及不常见的镜像仓库规范 [distribution-spec](https://github.com/opencontainers/distribution-spec) 。下面这些大白话从 [容器开放接口规范（CRI OCI）](https://wilhelmguo.cn/blog/post/william/%E5%AE%B9%E5%99%A8%E5%BC%80%E6%94%BE%E6%8E%A5%E5%8F%A3%E8%A7%84%E8%8C%83%EF%BC%88CRI-OCI%EF%BC%89-2) 复制过来的，我也就懒得自己组织语言灌水了😂（凑字数

>   制定容器格式标准的宗旨概括来说就是不受上层结构的绑定，如特定的客户端、编排栈等，同时也不受特定的供应商或项目的绑定，即不限于某种特定操作系统、硬件、CPU架构、公有云等。
>
>   这两个协议通过 OCI runtime filesytem bundle 的标准格式连接在一起，OCI 镜像可以通过工具转换成 bundle，然后 OCI 容器引擎能够识别这个 bundle 来运行容器
>
>   -   操作标准化：容器的标准化操作包括使用标准容器创建、启动、停止容器，使用标准文件系统工具复制和创建容器快照，使用标准化网络工具进行下载和上传。
>   -   内容无关：内容无关指不管针对的具体容器内容是什么，容器标准操作执行后都能产生同样的效果。如容器可以用同样的方式上传、启动，不管是PHP应用还是MySQL数据库服务。
>   -   基础设施无关：无论是个人的笔记本电脑还是AWS S3，亦或是OpenStack，或者其它基础设施，都应该对支持容器的各项操作。
>   -   为自动化量身定制：制定容器统一标准，是的操作内容无关化、平台无关化的根本目的之一，就是为了可以使容器操作全平台自动化。
>   -   工业级交付：制定容器标准一大目标，就是使软件分发可以达到工业级交付成为现实

其实 OCI 规范就是一堆 markdown 文件啦，内容也很容易理解，不像 RFC 和 ISO 那么高深莫测，所以汝想对容器镜像有个深入的了解还是推荐大家去读一下这些 markdown 文件😂。OCI 规范是免费的哦，不像大多数 ISO 规范还要交钱才能看（︶^︶）哼。





### OCI image-spec

#### layer

[文件系统](https://github.com/opencontainers/image-spec/blob/master/layer.md)：以 layer 保存的文件系统，每个 layer 保存了和上层之间变化的部分，layer 应该保存哪些文件，怎么表示增加、修改和删除的文件等。

#### config

[config 文件](https://github.com/opencontainers/image-spec/blob/master/config.md)：保存了文件系统的层级信息（每个层级的 hash 值，以及历史信息），以及容器运行时需要的一些信息（比如环境变量、工作目录、命令参数、mount 列表），指定了镜像在某个特定平台和系统的配置。比较接近我们使用 `docker inspect <image_id>` 看到的内容

#### manifest

[manifest 文件](https://github.com/opencontainers/image-spec/blob/master/manifest.md)：镜像的 config 文件索引，有哪些 layer，额外的 annotation 信息，manifest 文件中保存了很多和当前平台有关的信息。切记 manifest 中的 layer 和 config 中的 layer 表达的虽然都是镜像的 layer ，但二者代表的意义不太一样，稍后会讲到。根据 OCI image-spec 规范中 [OCI Image Manifest Specification](https://github.com/opencontainers/image-spec/blob/master/manifest.md) 的定义可以得知，镜像的 manifest 文件主要有以下三个目标：

>   There are three main goals of the Image Manifest Specification.
>
>   -   The first goal is content-addressable images, by supporting an image model where the image's configuration can be hashed to generate a unique ID for the image and its components. 
>   -   The second goal is to allow multi-architecture images, through a "fat manifest" which references image manifests for platform-specific versions of an image. In OCI, this is codified in an [image index](https://github.com/opencontainers/image-spec/blob/master/image-index.md). 
>   -   The third goal is to be [translatable](https://github.com/opencontainers/image-spec/blob/master/conversion.md) to the [OCI Runtime Specification](https://github.com/opencontainers/runtime-spec).

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

需要注意的是，在 RUN 指令的每行结尾我使用的是 `;\` 来接下一行 shell ，另一种写法是 `&&` 。二者有本质的区别，比如 COMMAND 1;COMMAND 2 ，当 `COMMAND 1` 运行失败时也继续运行 `COMMAND2`。而 COMMAND 1&& COMMAND 2，时 `COMMAND 1` 运行成功时才接着运行 `COMMAND 2` ， `COMMAND 1`运行失败会退出。不过建议用 `&&` ，如果是老司机的话建议用 `;` ，docker hub 官方镜像中用 `;` 较多一些，因为 `;` 比 `&&` 要美观一些（大雾😂

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

想要自己亲自~~指挥~~炼制一个 `debian:buster` 基础镜像其实很简单，就像下面这样一把梭操作下来就行😂：

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

### 世界上有两个完全相同的镜像嘛？

大家思考下面这两个问题

-   问题1：使用相同的 `Dockerfile` 和 `rootfs.tar.xz` 构建出来的镜像相同嘛？
-   问题2：对于应用镜像比如 [webp_server_go]() 使用相同的源码，相同的 `Dockerfile` 搓出来的镜像相同嘛？

要弄懂这两个问题首先要明白**相同**是指的什么相同？回到我们的起点镜像是怎炼成的，我们可以得知，既然一个镜像是由 layer 和元数据组成的。那么这里的相同就是指的两个镜像的 layer 相同，元数据相同。

呜呜呜，我哭了。我把 debian 官方的镜像 pull 后发现我搓的镜像和 docker hub 官方的镜像不一样，为什么有同样的 `Dockerfile` 和 `rootfs.tar.xz` 以及镜像，搓出来的基础镜像不一样呢（掀桌儿！

```shell
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64›
╰─# docker build -t debian:buster-build . 
Sending build context to Docker daemon  30.12MB
Step 1/3 : FROM scratch
 --->
Step 2/3 : ADD rootfs.tar.xz /
 ---> 20a2231921a6
Step 3/3 : CMD ["bash"]
 ---> Running in 9e623b5a86ee
Removing intermediate container 9e623b5a86ee
 ---> e5b0631f4c3a
Successfully built e5b0631f4c3a
Successfully tagged debian:buster-build
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64›
╰─# docker pull debian:buster
buster: Pulling from library/debian
376057ac6fa1: Pull complete
Digest: sha256:4ab3309ba955211d1db92f405be609942b595a720de789286376f030502ffd6f
Status: Downloaded newer image for debian:buster
docker.io/library/debian:buster
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64›
╰─# docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
debian              buster-build        e5b0631f4c3a        30 seconds ago      114MB
debian              buster              5971ee6076a0        3 weeks ago         114MB
registry            2                   708bc6af7e5e        4 months ago        25.8MB
registry            latest              708bc6af7e5e        4 months ago        25.8MB
```

使用 docker history 命令查看一下镜像构建的历史信息，可以发现，其实这两个镜像的 `rootfs.tar.xz` 并不一样。

```shell
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64›
╰─# docker history debian:buster-build
IMAGE               CREATED             CREATED BY                                      SIZE 
e5b0631f4c3a        6 minutes ago       /bin/sh -c #(nop)  CMD ["bash"]                 0B
20a2231921a6        6 minutes ago       /bin/sh -c #(nop) ADD file:2a331dd613d7d20bf…   114MB
╭─root@sg-02 ~/docker-debian-artifacts/buster ‹dist-amd64›
╰─# docker history debian:buster
IMAGE               CREATED             CREATED BY                                      SIZE 
5971ee6076a0        3 weeks ago         /bin/sh -c #(nop)  CMD ["bash"]                 0B
<missing>           3 weeks ago         /bin/sh -c #(nop) ADD file:fb54c709daa205bf9…   114MB
```



docker history debian:v1

```shell
╭─root@sg-02 ~/buster/slim
╰─# docker history debian:v1
IMAGE               CREATED              CREATED BY                                      SIZE
17dae480645a        About a minute ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B
7388695dc441        About a minute ago   /bin/sh -c #(nop) ADD file:a82014afc29e7b364…   69.2MB
```

debian_v1.json

```json
[
    {
        "Id": "sha256:17dae480645a19672c762da5041bc54c4cfe9400aadb331b7fd24de807640e2f",
        "RepoTags": [
            "debian:v1"
        ],
        "RepoDigests": [],
        "Parent": "sha256:7388695dc4416674b1848b44822b4f91ee5d00a0f95e48349f8eca983dd3674d",
        "Comment": "",
        "Created": "2020-06-07T00:45:57.238044195Z",
        "Container": "58c2d6e203c60c9c5d38af43dcdbc8ad9a44ab6d6df6d3a232d63c3eb4d9b64e",
        "ContainerConfig": {
            "Hostname": "58c2d6e203c6",
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
                "CMD [\"bash\"]"
            ],
            "Image": "sha256:7388695dc4416674b1848b44822b4f91ee5d00a0f95e48349f8eca983dd3674d",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "DockerVersion": "19.03.5",
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
                "bash"
            ],
            "Image": "sha256:7388695dc4416674b1848b44822b4f91ee5d00a0f95e48349f8eca983dd3674d",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 69212698,
        "VirtualSize": 69212698,
        "GraphDriver": {
            "Data": {
                "MergedDir": "/opt/docker/overlay2/f48c49095a0d9411f7c180641437ad9528166ffd073183c5df55056ba090f94c/merged",
                "UpperDir": "/opt/docker/overlay2/f48c49095a0d9411f7c180641437ad9528166ffd073183c5df55056ba090f94c/diff",
                "WorkDir": "/opt/docker/overlay2/f48c49095a0d9411f7c180641437ad9528166ffd073183c5df55056ba090f94c/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:d1b85e6186f67d9925c622a7a6e66faa447e767f90f65ae47cdc817c629fa956"
            ]
        },
        "Metadata": {
            "LastTagTime": "2020-06-07T00:45:57.302756165Z"
        }
    }
]
```

`docker history debian:v2`

```shell
╭─root@sg-02 ~/buster/slim
╰─# docker history debian:v2
IMAGE               CREATED              CREATED BY                                      SIZE 
4beee5244f85        About a minute ago   /bin/sh -c #(nop)  CMD ["bash"]                 0B
d82f3623bb12        About a minute ago   /bin/sh -c #(nop) ADD file:a82014afc29e7b364…   69.2MB
```

`debian_v2.json`

```json
[
    {
        "Id": "sha256:4beee5244f85a4b8d1aea573561a038456f1ca7432a61e82b9c51e389ee81d01",
        "RepoTags": [
            "debian:v2"
        ],
        "RepoDigests": [],
        "Parent": "sha256:d82f3623bb12d1baa2ccdc820507e197c6810a080a7054a02699569fbefa6de0",
        "Comment": "",
        "Created": "2020-06-07T00:48:35.313229294Z",
        "Container": "f45ebb6d876e79c97a0b68990aeae22de1d00f9b7b00324186bc3a4f6b399032",
        "ContainerConfig": {
            "Hostname": "f45ebb6d876e",
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
                "CMD [\"bash\"]"
            ],
            "Image": "sha256:d82f3623bb12d1baa2ccdc820507e197c6810a080a7054a02699569fbefa6de0",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "DockerVersion": "19.03.5",
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
                "bash"
            ],
            "Image": "sha256:d82f3623bb12d1baa2ccdc820507e197c6810a080a7054a02699569fbefa6de0",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 69212698,
        "VirtualSize": 69212698,
        "GraphDriver": {
            "Data": {
                "MergedDir": "/opt/docker/overlay2/cd5edcb6235ce3d7387b42164d4b996e35565bb0adf32f34e181e7e0fd9d9a47/merged",
                "UpperDir": "/opt/docker/overlay2/cd5edcb6235ce3d7387b42164d4b996e35565bb0adf32f34e181e7e0fd9d9a47/diff",
                "WorkDir": "/opt/docker/overlay2/cd5edcb6235ce3d7387b42164d4b996e35565bb0adf32f34e181e7e0fd9d9a47/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:d1b85e6186f67d9925c622a7a6e66faa447e767f90f65ae47cdc817c629fa956"
            ]
        },
        "Metadata": {
            "LastTagTime": "2020-06-07T00:48:35.384439283Z"
        }
    }
]
```

`diff debian_v1.json debian_v2.json`

```diff
3c3
<         "Id": "sha256:17dae480645a19672c762da5041bc54c4cfe9400aadb331b7fd24de807640e2f",
---
>         "Id": "sha256:4beee5244f85a4b8d1aea573561a038456f1ca7432a61e82b9c51e389ee81d01",
5c5
<             "debian:v1"
---
>             "debian:v2"
8c8
<         "Parent": "sha256:7388695dc4416674b1848b44822b4f91ee5d00a0f95e48349f8eca983dd3674d",
---
>         "Parent": "sha256:d82f3623bb12d1baa2ccdc820507e197c6810a080a7054a02699569fbefa6de0",
10,11c10,11
<         "Created": "2020-06-07T00:45:57.238044195Z",
<         "Container": "58c2d6e203c60c9c5d38af43dcdbc8ad9a44ab6d6df6d3a232d63c3eb4d9b64e",
---
>         "Created": "2020-06-07T00:48:35.313229294Z",
>         "Container": "f45ebb6d876e79c97a0b68990aeae22de1d00f9b7b00324186bc3a4f6b399032",
13c13
<             "Hostname": "58c2d6e203c6",
---
>             "Hostname": "f45ebb6d876e",
31c31
<             "Image": "sha256:7388695dc4416674b1848b44822b4f91ee5d00a0f95e48349f8eca983dd3674d",
---
>             "Image": "sha256:d82f3623bb12d1baa2ccdc820507e197c6810a080a7054a02699569fbefa6de0",
56c56
<             "Image": "sha256:7388695dc4416674b1848b44822b4f91ee5d00a0f95e48349f8eca983dd3674d",
---
>             "Image": "sha256:d82f3623bb12d1baa2ccdc820507e197c6810a080a7054a02699569fbefa6de0",
69,71c69,71
<                 "MergedDir": "/opt/docker/overlay2/f48c49095a0d9411f7c180641437ad9528166ffd073183c5df55056ba090f94c/merged",
<                 "UpperDir": "/opt/docker/overlay2/f48c49095a0d9411f7c180641437ad9528166ffd073183c5df55056ba090f94c/diff",
<                 "WorkDir": "/opt/docker/overlay2/f48c49095a0d9411f7c180641437ad9528166ffd073183c5df55056ba090f94c/work"
---
>                 "MergedDir": "/opt/docker/overlay2/cd5edcb6235ce3d7387b42164d4b996e35565bb0adf32f34e181e7e0fd9d9a47/merged",
>                 "UpperDir": "/opt/docker/overlay2/cd5edcb6235ce3d7387b42164d4b996e35565bb0adf32f34e181e7e0fd9d9a47/diff",
>                 "WorkDir": "/opt/docker/overlay2/cd5edcb6235ce3d7387b42164d4b996e35565bb0adf32f34e181e7e0fd9d9a47/work"
82c82
<             "LastTagTime": "2020-06-07T00:45:57.302756165Z"
---
>             "LastTagTime": "2020-06-07T00:48:35.384439283Z"
```

结论，根据 docker build 的原理我们可以大胆地论断，**世界上两台机器上不可能构建出完全相同镜像！**



```shell

```



```json
╭─root@sg-02 ~/buster/slim
╰─# skopeo inspect docker-daemon:debian:v1 --raw | jq "."
{
  "schemaVersion": 2,
  "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
  "config": {
    "mediaType": "application/vnd.docker.container.image.v1+json",
    "size": 1462,
    "digest": "sha256:cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d"
  },
  "layers": [
    {
      "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
      "size": 72485376,
      "digest": "sha256:d1b85e6186f67d9925c622a7a6e66faa447e767f90f65ae47cdc817c629fa956"
    }
  ]
}
```



```json
{
  "schemaVersion": 2,
  "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
  "config": {
    "mediaType": "application/vnd.docker.container.image.v1+json",
    "size": 1462,
    "digest": "sha256:e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df"
  },
  "layers": [
    {
      "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
      "size": 72485376,
      "digest": "sha256:d1b85e6186f67d9925c622a7a6e66faa447e767f90f65ae47cdc817c629fa956"
    }
  ]
}
```



## 镜像是怎么搬运的🤣

当我们在本地构建完成一个镜像之后，如何传递给他人呢？这就涉及到镜像是怎么搬运的一些知识，搬运镜像就像我们在 GitHub 上搬运代码一样，docker 也有类似于 git clone 和 git push 的搬运方式。

### docker

#### docker push

docker push 就和我们使用 git push 一样，将本地的镜像推送到一个称之为 registry 的镜像仓库，这个 registry 镜像仓库就像 GitHub 用来存放公共/私有的镜像，一个中心化的镜像仓库方便大家来进行交流和搬运镜像。这个 registry 稍后在镜像是怎样存放的章节详细讲一下。

#### docker pull



![image](https://user-images.githubusercontent.com/12036324/70367494-646d2380-18db-11ea-992a-d2bca4cbfeb0.png)

docker pull 就和我们使用 git clone 一样效果，将远程的镜像仓库

1.  由镜像名请求Manifest Schema v2



2.  解析Manifest获取镜像Configuration



3.  下载各Layer gzip压缩文件



4.  验证Configuration中的RootFS.DiffIDs是否与下载（解压后）hash相同



5.  解析Manifest获取镜像Configuration

#### docker save

docker save

注意，docker save 只能导出来 tar 包，所以当你 docker save -o images.tar.gz 时，你得到的并不是个 gzip 压缩过的 tar 包。所以如果你想得到一个真正的 .tar.gz 格式的正确的搬运姿势就是 docker save -o image.tar && gzip image.tar

#### docker load

### Python

#### [docker-drag](https://github.com/NotGlop/docker-drag)

这是一个很简单粗暴的 Python 脚本，使用 request 库请求 registry API 来从镜像仓库中拉取镜像，并保存为一个 tar 包，拉完之后使用 docker load 加载一下就能食用啦。该 python 脚本简单到去掉空行和注释不到 200 行，如果把这个脚本源码读一遍的话就能大概知道 docker pull 和 skopeo copy 的一些原理，他们都是去调用 registry 的 API ，所以还是推荐去读一下这个它的源码。

食用起来也很简单直接 `python3 docker_pull.py [image name]`，貌似只能拉取 docker.io 上的镜像。

```shell
╭─root@sg-02 /home/ubuntu
╰─# wget https://raw.githubusercontent.com/NotGlop/docker-drag/master/docker_pull.py
╭─root@sg-02 /home/ubuntu
╰─# python3 docker_pull.py nginx
Creating image structure in: tmp_nginx_latest
afb6ec6fdc1c: Pull complete [27098756]
dd3ac8106a0b: Pull complete [26210578]                                       ]
8de28bdda69b: Pull complete [538]
a2c431ac2669: Pull complete [900]
e070d03fd1b5: Pull complete [669]
Docker image pulled: library_nginx.tar
╭─root@sg-02 /home/ubuntu
╰─# docker load -i library_nginx.tar
ffc9b21953f4: Loading layer [==================================================>]  72.49MB/72.49MB
d9c0b16c8d5b: Loading layer [==================================================>]  63.81MB/63.81MB
8c7fd6263c1f: Loading layer [==================================================>]  3.072kB/3.072kB
077ae58ac205: Loading layer [==================================================>]  4.096kB/4.096kB
787328500ad5: Loading layer [==================================================>]  3.584kB/3.584kB
Loaded image: nginx:latest
```

### skopeo

这个工具是红帽子家的，是 Podman、Skopeo 和 Buildah （简称 PSB ）下一代容器新架构中的一员，不过木子觉着 Podman 想要取代 docker 和 containerd 容器运行时还有很长的路要走，虽然它符合 OCI 规范，但对于企业来讲，替换的成本并不值得他们去换到 PSB 上去。

其中的 skopeo 这个镜像搬运工具简直是个神器，尤其是在 CI/CD 流水线中搬运两个镜像仓库里的镜像简直爽的不得了。我入职新公司后做的一个工作就是优化我们的 Jenkins 流水线中同步两个镜像仓库的过程，使用 了skopeo 替代 docker 来同步两个镜像仓库中的镜像，将原来需要 2h 小时缩短到了 25min 😀。

关于这个工具的详细使用推荐大家去读一下我之前写的一篇博客 [镜像搬运工 skopeo 初体验](https://blog.k8s.li/skopeo.html) 。在这里只讲两个木子最常用的功能。

#### skopeo copy

使用 skopeo copy 两个 registry 中的镜像时，skopeo 请求两个 registry API 直接 copy `original blob` 到另一个 registry ，这样免去了像 docker pull –> docker tag –> docker push 那样 pull 镜像对镜像进行解压缩，push 镜像进行压缩。尤其是在搬运一些较大的镜像（几GB 或者几十 GB的镜像，比如 `nvidia/cuda` ），使用 skopeo copy 的加速效果十分明显。

```shell
DEBU[0000] Detected compression format gzip
DEBU[0000] Using original blob without modification

Getting image source signatures
Copying blob 09a9f6a07669 done
Copying blob f8cdeb3c6c18 done
Copying blob 22c4d5853f25 done
Copying blob 76abc3f50d9b done
Copying blob 3386b7c9ccd4 done
Copying blob b9207193f1af [==============================>-------] 224.2MiB / 271.2MiB
Copying blob 2f32d819e6ce done
Copying blob 5dbc3047e646 done
Copying blob f8dfcc3265c3 [==================>-------------------] 437.1MiB / 864.3MiB
Copying blob 13d3556105d1 done
Copying blob f9b7fa6a027e [=========================>------------] 84.0MiB / 124.3MiB
Copying blob a1a0f6abe73b [====================>-----------------] 417.9MiB / 749.1MiB
Copying blob bcc9947fc8a4 done
Copying blob 9563b2824fef done
Copying blob a1b8faa0044b [===>----------------------------------] 88.0MiB / 830.1MiB
Copying blob 9917e218edfd [===============>----------------------] 348.6MiB / 803.6MiB
Copying blob 776b9ff2f788 done
Copying config d0c3cfd730 done
Writing manifest to image destination
Storing signatures
```

#### skopeo inspect

用 skopeo inspect 命令可以很方方便地通过 registry 的 API 来查看镜像的 manifest 文件，以前我都是用 curl 命令的，要 token 还要加一堆参数，所以比较麻烦，所以后来就用上了  skopeo inspect😀。 

```json
root@deploy:/root # skopeo inspect docker://index.docker.io/webpsh/webps:latest --raw
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
   "config": {
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 2534,
      "digest": "sha256:30d9679b0b1ca7e56096eca0cdb7a6eedc29b63968f25156ef60dec27bc7d206"
   },
   "layers": [
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 2813316,
         "digest": "sha256:cbdbe7a5bc2a134ca8ec91be58565ec07d037386d1f1d8385412d224deafca08"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 8088920,
         "digest": "sha256:54335262c2ed2d4155e62b45b187a1394fbb6f39e0a4a171ab8ce0c93789e6b0"
      },
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 262,
         "digest": "sha256:31555b34852eddc7c01f26fa9c0e5e577e36b4e7ccf1b10bec977eb4593a376b"
      }
   ]
}
```

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

-   `repositories.json`

repositories.json 就是存储镜像元数据信息，主要是 image name和 image id 的对应，digest 和 image id 的对应。当 pull 完一个镜像的时候 docker 会更新这个文件。当我们 docker run 一个容器的时候也用到这个文件去索引本地是否存在该镜像，没有镜像的话就自动去 pull 这个镜像。

```json
╭─root@sg-02 /var/lib/docker/image/overlay2
╰─# jq "." repositories.json
{
  "Repositories": {
    "debian": {
      "debian:v1": "sha256:cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d",
      "debian:v2": "sha256:e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df"
    },
    "localhost:5000/library/debian": {
      "localhost:5000/library/debian:v1": "sha256:cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d",
      "localhost:5000/library/debian:v2": "sha256:e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df",
      "localhost:5000/library/debian@sha256:b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239": "sha256:cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d",
      "localhost:5000/library/debian@sha256:c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11": "sha256:e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df"
    },
    "registry": {
      "registry:latest": "sha256:708bc6af7e5e539bdb59707bbf1053cc2166622f5e1b17666f0ba5829ca6aaea",
      "registry@sha256:7d081088e4bfd632a88e3f3bcd9e007ef44a796fddfe3261407a3f9f04abe1e7": "sha256:708bc6af7e5e539bdb59707bbf1053cc2166622f5e1b17666f0ba5829ca6aaea"
    }
  }
}
```



```

```



#### /var/lib/docker/overlay2

下面是一段从 [StackOverflow](https://stackoverflow.com/questions/56550890/docker-image-merged-diff-work-lowerdir-components-of-graphdriver) 上搬运过来的解释，

>   **LowerDir**: these are the read-only layers of an overlay filesystem. For docker, these are the image layers assembled in order.
>
>   **UpperDir**: this is the read-write layer of an overlay filesystem. For docker, that is the equivalent of the container specific layer that contains changes made by that container.
>
>   **WorkDir**: this is a required directory for overlay, it needs an empty directory for internal use.
>
>   **MergedDir**: this is the result of the overlay filesystem. Docker effectively chroot's into this directory when running the container.

如果想对 overlayfs 文件系统有详细的了解，可以参考 Linux 内核官网上的这篇文档 [overlayfs.txt](https://www.kernel.org/doc/Documentation/filesystems/overlayfs.txt) 。

从 docker 官方文档 [Use the OverlayFS storage driver](https://docs.docker.com/storage/storagedriver/overlayfs-driver/) 里偷来的一张图片

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

我们在本地使用 docker run 来起 registry 的容器，我们仅仅是来分析 registry 中镜像时如何存储的，这种场景下不太适合用 harbor 这种重量级的 registry 。

```shell
╭─root@sg-02 /home/ubuntu
╰─# docker run -d --name registry -p 5000:5000 -v /var/lib/registry:/var/lib/registry registry
335ea763a2fa4508ebf3ec6f8b11f3b620a11bdcaa0ab43176b781427e0beee6
```

```shell
╭─root@sg-02 ~/buster/slim
╰─# docker tag debian:v1  localhost:5000/library/debian:v1
╭─root@sg-02 ~/buster/slim
╰─# ^v1^v2
╭─root@sg-02 ~/buster/slim
╰─# docker tag debian:v2  localhost:5000/library/debian:v2
╭─root@sg-02 ~/buster/slim
╰─# docker images
REPOSITORY                      TAG                 IMAGE ID            CREATED             SIZE
debian                          v2                  e6e782a57a51        5 minutes ago       69.2MB
localhost:5000/library/debian   v2                  e6e782a57a51        5 minutes ago       69.2MB
debian                          v1                  cfba37fd24f8        9 minutes ago       69.2MB
localhost:5000/library/debian   v1                  cfba37fd24f8        9 minutes ago       69.2MB
╭─root@sg-02 ~/buster/slim
╰─# docker push localhost:5000/library/debian:v1
The push refers to repository [localhost:5000/library/debian]
d1b85e6186f6: Pushed
v1: digest: sha256:b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239 size: 529
╭─root@sg-02 ~/buster/slim
╰─# docker push localhost:5000/library/debian:v2
The push refers to repository [localhost:5000/library/debian]
d1b85e6186f6: Layer already exists
v2: digest: sha256:c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11 size: 529
```

当我们在本地启动一个 registry 容器之后，容器内默认的存储位置为 `/var/lib/registry` ，所以我们在启动的时候加了参数 `-v /var/lib/registry:/var/lib/registry` 将本机的路径挂载到容器内。进入这里路径我们使用 tree 命令查看一下这个目录的存储结构。

```shell
╭─root@sg-02 /var/lib/registry/docker/registry/v2
╰─# tree -h
.
├── [4.0K]  blobs
│   └── [4.0K]  sha256
│       ├── [4.0K]  aa
│       │   └── [4.0K]  aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb
│       │       └── [ 26M]  data
│       ├── [4.0K]  b9
│       │   └── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
│       │       └── [ 529]  data
│       ├── [4.0K]  c8
│       │   └── [4.0K]  c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11
│       │       └── [ 529]  data
│       ├── [4.0K]  cf
│       │   └── [4.0K]  cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d
│       │       └── [1.4K]  data
│       └── [4.0K]  e6
│           └── [4.0K]  e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df
│               └── [1.4K]  data
└── [4.0K]  repositories
    └── [4.0K]  library
        └── [4.0K]  debian
            ├── [4.0K]  _layers
            │   └── [4.0K]  sha256
            │       ├── [4.0K]  aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb
            │       │   └── [  71]  link
            │       ├── [4.0K]  cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d
            │       │   └── [  71]  link
            │       └── [4.0K]  e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df
            │           └── [  71]  link
            ├── [4.0K]  _manifests
            │   ├── [4.0K]  revisions
            │   │   └── [4.0K]  sha256
            │   │       ├── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
            │   │       │   └── [  71]  link
            │   │       └── [4.0K]  c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11
            │   │           └── [  71]  link
            │   └── [4.0K]  tags
            │       ├── [4.0K]  v1
            │       │   ├── [4.0K]  current
            │       │   │   └── [  71]  link
            │       │   └── [4.0K]  index
            │       │       └── [4.0K]  sha256
            │       │           └── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
            │       │               └── [  71]  link
            │       └── [4.0K]  v2
            │           ├── [4.0K]  current
            │           │   └── [  71]  link
            │           └── [4.0K]  index
            │               └── [4.0K]  sha256
            │                   └── [4.0K]  c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11
            │                       └── [  71]  link
            └── [4.0K]  _uploads

37 directories, 14 files
```

树形的结构看着不太直观，木子就亲自~~指挥~~画了一张层级结构的图来：

![](img/registry-arch.png)

#### blobs 目录

之前我们向 registry 种推送了两个镜像，这两个镜像的 layer 相同但不是用一个镜像，在我们之前 push image 的时候也看到了 `d1b85e6186f6: Layer already exists`。也就可以证明了，虽然两个镜像不同，但它们的 layer 在 registry 中存储的时候可能是相同的。

在 `blobs/sha256` 目录下一共有 5 个名为 data 的文件，我们可以推测一下最大的那个 `[ 26M]` 应该是镜像的 layer ，最小的 `[ 529]` 那个应该是 image config ，剩下的那个 `[1.4K]` 应该就是 manifest 文件。

```shell
╭─root@sg-02 /var/lib/registry/docker/registry/v2/blobs/sha256
╰─# tree -h
.
├── [4.0K]  aa
│   └── [4.0K]  aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb
│       └── [ 26M]  data
├── [4.0K]  b9
│   └── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
│       └── [ 529]  data
├── [4.0K]  c8
│   └── [4.0K]  c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11
│       └── [ 529]  data
├── [4.0K]  cf
│   └── [4.0K]  cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d
│       └── [1.4K]  data
└── [4.0K]  e6
    └── [4.0K]  e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df
        └── [1.4K]  data
```

在 `registry` 的存储目录下，`blobs` 目录用来存放镜像的三种文件： layer 的真实数据，镜像的 manifest 文件，镜像的 image config 文件。这些文件都是以 `data` 为名的文件存放在于该文件 `sha256` 相对应的目录下。 使用 `sha256`散列存储方便索引文件，在 `blob digest` 目录下有一个名为 `data`的文件，对于 layer 来讲，这是个 `data` 文件的格式是 `vnd.docker.image.rootfs.diff.tar.gzip` ，我们可以使用 `tar -xvf` 命令将这个 layer 解开。当我们使用 docker pull 命令拉取镜像的时候，也是去下载这个 `data`文件，下载完成之后会有一个 `docker-untar`的进程将这个 `data`文件解开存放在`/var/lib/docker/overlay2/${digest}/diff` 目录下。

```shell
├── [4.0K]  blobs
│   └── [4.0K]  sha256
│       ├── [4.0K]  aa
│       │   └── [4.0K]  aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb
│       │       └── [ 26M]  data
```

**manifest 文件**就是一个普通的 json 文件啦😂

```json
╭─root@sg-02 /var/lib/registry/docker/registry/v2/blobs/sha256/b9/b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
╰─# cat data
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
   "config": {
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 1462,
      "digest": "sha256:cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d"
   },
   "layers": [
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 27097859,
         "digest": "sha256:aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb"
      }
   ]
}#              
```

#### image config 文件

image config 文件里并没有包含镜像的 tag 信息。

```json
╭─root@sg-02 /var/lib/registry/docker/registry/v2/blobs/sha256/e6/e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df
╰─# cat data | jq "."
{
  "architecture": "amd64",
  "config": {
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
      "bash"
    ],
    "Image": "sha256:ba8f577813c7bdf6b737f638dffbc688aa1df2ff28a826a6c46bae722977b549",
    "Volumes": null,
    "WorkingDir": "",
    "Entrypoint": null,
    "OnBuild": null,
    "Labels": null
  },
  "container": "38501d5aa48c080884f4dc6fd4b1b6590ff1607d9e7a12e1cef1d86a3fdc32df",
  "container_config": {
    "Hostname": "38501d5aa48c",
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
      "CMD [\"bash\"]"
    ],
    "Image": "sha256:ba8f577813c7bdf6b737f638dffbc688aa1df2ff28a826a6c46bae722977b549",
    "Volumes": null,
    "WorkingDir": "",
    "Entrypoint": null,
    "OnBuild": null,
    "Labels": {}
  },
  "created": "2020-06-07T01:59:47.348924716Z",
  "docker_version": "19.03.5",
  "history": [
    {
      "created": "2020-06-07T01:59:46.877600299Z",
      "created_by": "/bin/sh -c #(nop) ADD file:a82014afc29e7b364ac95223b22ebafad46cc9318951a85027a49f9ce1a99461 in / "
    },
    {
      "created": "2020-06-07T01:59:47.348924716Z",
      "created_by": "/bin/sh -c #(nop)  CMD [\"bash\"]",
      "empty_layer": true
    }
  ],
  "os": "linux",
  "rootfs": {
    "type": "layers",
    "diff_ids": [
      "sha256:d1b85e6186f67d9925c622a7a6e66faa447e767f90f65ae47cdc817c629fa956"
    ]
  }
}
```

#### _uploads 文件夹

_uploads 文件夹是个临时的文件夹，主要用来存放 push 镜像过程中的文件数据，当镜像 `layer` 上传完成之后会清空该文件夹。其中的 `data` 文件上传完毕后会移动到 `blobs` 目录下，根据该文件的 `sha256` 值来进行散列存储到相应的目录下。

```shell
_uploads
├── [  53]  0d6c996e-638f-4436-b2b6-54fa7ad430d2
│   ├── [198M]  data
│   ├── [  20]  hashstates
│   │   └── [  15]  sha256
│   │       └── [ 108]  0
│   └── [  20]  startedat
└── [  53]  ba31818e-4217-47ef-ae46-2784c9222614
    ├── [571M]  data
    ├── [  20]  hashstates
    │   └── [  15]  sha256
    │       └── [ 108]  0
    └── [  20]  startedat

6 directories, 6 files
```

-   上传完镜像之后，`_uploads` 文件夹就会被清空，正常情况下这个文件夹是空的。但也有异常的时候😂，比如网络抖动导致上传意外中断，该文件夹就可能不为空。

```shell
_uploads

0 directories, 0 files
```

#### _manifests 文件夹

`_manifests` 文件夹是镜像上传完成之后由 registry 来生成的，并且该目录下的文件都是一个名为 `link`的文本文件，它的值指向 blobs 目录下与之对应的目录。

```shell
╭─root@sg-02 /var/lib/registry/docker/registry/v2/repositories/library
╰─# find . -type f
./debian/_layers/sha256/aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb/link
./debian/_layers/sha256/e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df/link
./debian/_layers/sha256/cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d/link
./debian/_manifests/tags/v2/current/link
./debian/_manifests/tags/v2/index/sha256/c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11/link
./debian/_manifests/tags/v1/current/link
./debian/_manifests/tags/v1/index/sha256/b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239/link
./debian/_manifests/revisions/sha256/b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239/link
./debian/_manifests/revisions/sha256/c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11/link
```

`_manifests` 文件夹下包含着镜像的 `tags` 和 `revisions` 信息，每一个镜像的每一个 tag 对应着于 tag 名相同的目录。镜像的 tag 并不存储在 image config 中，而是以目录的形式来形成镜像的 tag，这一点比较奇妙。

```shell
.
├── [4.0K]  _layers
│   └── [4.0K]  sha256
│       ├── [4.0K]  aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb
│       │   └── [  71]  link
│       ├── [4.0K]  cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d
│       │   └── [  71]  link
│       └── [4.0K]  e6e782a57a51d01168907938beb5cd5af24fcb7ebed8f0b32c203137ace6d3df
│           └── [  71]  link
├── [4.0K]  _manifests
│   ├── [4.0K]  revisions
│   │   └── [4.0K]  sha256
│   │       ├── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
│   │       │   └── [  71]  link
│   │       └── [4.0K]  c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11
│   │           └── [  71]  link
│   └── [4.0K]  tags
│       ├── [4.0K]  v1
│       │   ├── [4.0K]  current
│       │   │   └── [  71]  link
│       │   └── [4.0K]  index
│       │       └── [4.0K]  sha256
│       │           └── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
│       │               └── [  71]  link
│       └── [4.0K]  v2
│           ├── [4.0K]  current
│           │   └── [  71]  link
│           └── [4.0K]  index
│               └── [4.0K]  sha256
│                   └── [4.0K]  c805f078bb47c575e9602b09af7568eb27fd1c92073199acba68c187bc5bcf11
│                       └── [  71]  link
└── [4.0K]  _uploads

22 directories, 9 files
```

#### 镜像的 tag

 每个 `tag`名目录下面有 `current` 目录和 `index` 目录， `current` 目录下的 link 文件保存了该 tag 目前的 manifest 文件的 sha256 编码，对应在 `blobs` 中的 `sha256` 目录下的 `data` 文件，而 `index` 目录则列出了该 `tag` 历史上传的所有版本的 `sha256` 编码信息。`_revisions` 目录里存放了该 `repository` 历史上上传版本的所有 sha256 编码信息。

```shell
╭─root@sg-02 /var/lib/registry/docker/registry/v2/repositories/library/debian/_manifests/tags/v1
╰─# cat current/link
sha256:b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
╭─root@sg-02 /var/lib/registry/docker/registry/v2/blobs/sha256
╰─# tree -h
.
├── [4.0K]  aa
│   └── [4.0K]  aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb
│       └── [ 26M]  data
├── [4.0K]  b9
│   └── [4.0K]  b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239
│       └── [ 529]  data
```

当我们 `pull` 镜像的时候如果不指定镜像的 `tag`名，默认就是 latest，registry 会从 HTTP 请求中解析到这个 tag 名，然后根据 tag 名目录下的 link 文件找到该镜像的 manifest 的位置返回给客户端，客户端接着去请求这个 manifest 文件，客户端根据这个 manifest 文件来 pull 相应的镜像 layer 。

```json
╭─root@sg-02 /var/lib/registry/docker/registry/v2/repositories/library/debian/_manifests/tags/v1
╰─# cat  /var/lib/registry/docker/registry/v2/blobs/sha256/b9/b9caca385021f231e15aee34929eac332c49402372a79808d07ee66866792239/data
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
   "config": {
      "mediaType": "application/vnd.docker.container.image.v1+json",
      "size": 1462,
      "digest": "sha256:cfba37fd24f80f59e5d7c1f7735cae7a383e887d8cff7e2762fdd78c0d73568d"
   },
   "layers": [
      {
         "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
         "size": 27097859,
         "digest": "sha256:aaae33815489895f602207ac5a583422b8a8755b3f67fc6286ca9484ba685bdb"
      }
   ]
}
```

最后再补充一点就是，同一个镜像在 registry 中存储的位置是相同的，具体的分析可以参考 [镜像仓库中镜像存储的原理解析](https://supereagle.github.io/2018/04/24/docker-registry/) 这篇博客。

>   -   通过 Registry API 获得的两个镜像仓库中相同镜像的 manifest 信息完全相同。
>   -   两个镜像仓库中相同镜像的 manifest 信息的存储路径和内容完全相同。
>   -   两个镜像仓库中相同镜像的 blob 信息的存储路径和内容完全相同。

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

## 镜像是怎么焚毁的

当我们食用完一个镜像之后，如果今后不再需要它了，我们怎么从本地删除一个镜像呢，其实就是 `rm -rf /` 啦（才不是x

## 镜像的一生

到此为止，走我们马观花式的看完了镜像的一生：它诞生于一个 Dockerfile，

## 参考

### 官方文档

-   [Create a base image](https://docs.docker.com/develop/develop-images/baseimages/)
-   [FROM scratch](https://hub.docker.com/_/scratch)
-   [Docker Registry](https://docs.docker.com/registry/)
-   [Docker Registry HTTP API V2](https://docs.docker.com/registry/spec/api/)
-   [image](https://github.com/containers/image)
-   [OCI Image Manifest Specification](https://github.com/opencontainers/image-spec)
-   [distribution-spec](https://github.com/opencontainers/distribution-spec)
-   [debuerreotype/](https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/)
-    [overlayfs.txt](https://www.kernel.org/doc/Documentation/filesystems/overlayfs.txt) 

### 源码

-   [oi-janky-groovy](https://github.com/docker-library/oi-janky-groovy)
-   [docker-debian-artifacts](https://github.com/debuerreotype/docker-debian-artifacts)
-   [docker-drag](https://github.com/NotGlop/docker-drag)
-   [oras](https://github.com/deislabs/oras)
-   [skopeo](https://github.com/containers/skopeo)
-   [tar-split](https://github.com/vbatts/tar-split)

### 博客

-   [镜像仓库中镜像存储的原理解析](https://supereagle.github.io/2018/04/24/docker-registry/)
-   [镜像是怎样炼成的](https://blog.fleeto.us/post/how-are-docker-images-built/)
-   [docker pull分析](https://duyanghao.github.io/docker-registry-pull-manifest-v2/)
-   [浅谈docker中镜像和容器在本地的存储](https://github.com/helios741/myblog/blob/new/learn_go/src/2019/20191206_docker_disk_storage/README.md)
-   [容器OCI规范 镜像规范](https://www.qedev.com/cloud/103860.html)
-   [开放容器标准(OCI) 内部分享](https://xuanwo.io/2019/08/06/oci-intro/)
-   [容器开放接口规范（CRI OCI）](https://wilhelmguo.cn/blog/post/william/%E5%AE%B9%E5%99%A8%E5%BC%80%E6%94%BE%E6%8E%A5%E5%8F%A3%E8%A7%84%E8%8C%83%EF%BC%88CRI-OCI%EF%BC%89-2)
-   [Docker镜像的存储机制](https://segmentfault.com/a/1190000014284289)
-   [Docker源码分析（十）：Docker镜像下载](http://open.daocloud.io/docker-source-code-analysis-part10/)
-   [Docker源码分析（九）：Docker镜像](http://open.daocloud.io/docker-source-code-analysis-part9/)
-   [docker push 過程 distribution源碼 分析](https://www.twblogs.net/a/5b8aab392b71775d1ce86eca)
-   [Allen 谈 Docker](http://open.daocloud.io/tag/allen-tan-docker/)
-   [深入理解 Docker 镜像 json 文件](http://open.daocloud.io/shen-ru-li-jie-dockerjing-xiang-jsonwen-jian-2/)
-   [Docker 镜像内有啥，存哪？](http://open.daocloud.io/docker-jing-xiang-nei-you-sha-cun-na-ntitled/)
-   [理解 Docker 镜像大小](http://open.daocloud.io/allen-tan-docker-xi-lie-zhi-shen-ke-li-jie-docker-jing-xiang-da-xiao/)
-   [看尽 docker 容器文件系统](http://open.daocloud.io/allen-tan-docker-xi-lie-zhi-tu-kan-jin-docker-rong-qi-wen-jian-xi-tong/)


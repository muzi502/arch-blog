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

上周在写[《镜像搬运工 skopeo 初体验》](https://blog.k8s.li/skopeo.html)时候看了很多关于镜像的博客，从大佬们那里偷偷学了不少知识，对容器镜像有了一点点深入的了解，这周末一个人闲着宅在家里没事就把最近所学的知识整理一下分享出来，大家一起来食用。同是也为自己查漏补缺，加深对这些基础知识的理解。

## 镜像是怎样炼成的🤔

对于正处于容器时代的我们来讲，容器已经是我们互联网行业家喻户晓的工具。

### image config

### Dockerfile

### base image

当我们在写 Dockerfile 的时候都需要一个 FROM 语句来指定一个基础镜像，这些基础镜像并不是无中生有，也许需要一个 Dockerfile 来炼制成镜像。下面我们拿来 debian 这个基础镜像的 Dockerfile 来看一下基础镜像是如何练成的。

```dockerfile
FROM scratch
ADD rootfs.tar.xz /
CMD ["bash"]
```

你没看错，一个基础镜像的 Dockerfile 就是有三行。`FROM scratch` 

`scratch` 这个镜像并不真实的存在，当你使用 `docker pull scratch` 命令来拉取这个镜像的时候会翻车哦，提示 `Error response from daemon: 'scratch' is a reserved name`。自从 docker 1.5 版本开始，在 dockerfile 中 `FROM scratch` 语句并不会创建一个镜像层，下面的 `ADD rootfs.tar.xz /` 产生的一层镜像就是最终构建的镜像。

>   As of Docker 1.5.0 (specifically, [`docker/docker#8827`](https://github.com/docker/docker/pull/8827)), `FROM scratch` is a no-op in the `Dockerfile`, and will not create an extra layer in your image (so a previously 2-layer image will be a 1-layer image instead).

`ADD rootfs.tar.xz /` 中，这个 `rootfs.tar.xz` 就是我们经过一系列骚操作搓出来的根文件系统，这个操作比较复杂，木子太菜了就不在这里瞎掰掰了🤣，所以感兴趣的可以去看一下构建 debian 基础镜像的 Jenkins 流水线任务 [debuerreotype](https://doi-janky.infosiftr.net/job/tianon/job/debuerreotype/)，上面有构建这个 `rootfs.tar.xz` 完整过程，或者参考 Debian 官方的 [docker-debian-artifacts](https://github.com/debuerreotype/docker-debian-artifacts) 这个 repo 里的 shell 脚本。其实基础镜像通过一系列操作，比如源码构建，搓出来一个 `rootfs.tar.xz` 就可以啦。

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

### docker (/var/lib/docker)

```shell
╭─root@sg-02 /var/lib/docker
╰─# tree ../docker/image ../docker/overlay2 -d -L 2
../docker/image
└── overlay2
    ├── distribution
    ├── imagedb
    └── layerdb
../docker/overlay2
├── 259cf6934509a674b1158f0a6c90c60c133fd11189f98945c7c3a524784509ff
│   └── diff
├── 27f9e9b74a88a269121b4e77330a665d6cca4719cb9a58bfc96a2b88a07af805
│   ├── diff
│   └── work
├── a0df3cc902cfbdee180e8bfa399d946f9022529d12dba3bc0b13fb7534120015
│   ├── diff
│   └── work
├── b2fbebb39522cb6f1f5ecbc22b7bec5e9bc6ecc25ac942d9e26f8f94a028baec
│   ├── diff
│   └── work
├── be8c12f63bebacb3d7d78a09990dce2a5837d86643f674a8fd80e187d8877db9
│   ├── diff
│   └── work
├── e8f6e78aa1afeb96039c56f652bb6cd4bbd3daad172324c2172bad9b6c0a968d
│   └── diff
└── l
    ├── 526XCHXRJMZXRIHN4YWJH2QLPY -> ../b2fbebb39522cb6f1f5ecbc22b7bec5e9bc6ecc25ac942d9e26f8f94a028baec/diff
    ├── 5RZOXYR35NSGAWTI36CVUIRW7U -> ../be8c12f63bebacb3d7d78a09990dce2a5837d86643f674a8fd80e187d8877db9/diff
    ├── LBWRL4ZXGBWOTN5JDCDZVNOY7H -> ../a0df3cc902cfbdee180e8bfa399d946f9022529d12dba3bc0b13fb7534120015/diff
    ├── MYRYBGZRI4I76MJWQHN7VLZXLW -> ../27f9e9b74a88a269121b4e77330a665d6cca4719cb9a58bfc96a2b88a07af805/diff
    ├── PCIS4FYUJP4X2D4RWB7ETFL6K2 -> ../259cf6934509a674b1158f0a6c90c60c133fd11189f98945c7c3a524784509ff/diff
    └── XK5IA4BWQ2CIS667J3SXPXGQK5 -> ../e8f6e78aa1afeb96039c56f652bb6cd4bbd3daad172324c2172bad9b6c0a968d/diff
```

### registry (/registry/docker/v2)

#### docker.io

[docker-library/oi-janky-groovy](https://github.com/docker-library/oi-janky-groovy)



#### quay.io

#### 私有 registry



### docker-archive

本来我想着 docker save 出来的并不是一个镜像，而是一个 `.tar` 文件，但我想了又想，还是觉着它是一个镜像，只不过存在的方式不同而已。于在 docker 和 registry 中存放的方式不同，使用 docker save 出来的镜像是一个孤立的存在。就像是从蛋糕店里拿出来的蛋糕，外面肯定要有个精美的包装是吧，你总没见过。放在哪里都可以，使用的时候我们使用 docker load 拆开外包装(`.tar`)就可。

## 镜像是怎么食用的😋

### docker

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


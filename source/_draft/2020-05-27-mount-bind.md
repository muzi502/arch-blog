---
title: mount 命令 --bind 挂载参数
date: 2020-05-27
updated:
slug:
categories: 技术
tag: 
  - linux
  - overlay2
  - docker
copyright: true
comment: true
---

## 翻车（：

由于我的 VPS 不是大盘鸡(就是大容量磁盘机器啦😂)， docker 存储目录 `/var/lib/docker` 所在的分区严重不足，于是就想着在不改变 docker 配置的下将 `/opt` 目录下的分区分配给 `/var/lib/docker` 目录。首先想到的是把 `/var/lib/docker` 复制到 `/opt/docker`，然后再将 `/opt/docker` 软链接到 `/var/lib/docker` 。

于是我就一顿操作猛如虎，`mv /var/lib/docker /opt/docker && ln -s /opt/docker /var/lib/docker` 一把梭，然后我启动一个容器的时候当场就翻车了🤣。

```shell

```

原来有些程序是不支持软链接目录的，还有一点就是软链接的路径也有点坑。比如我将 `/opt/docker -> /var/lib/docker/` ，在 `/var/lib/docker` 目录下执行 `ls ../` 即它的上一级目录是 `/opt` 而不是 `/var/lib` ，对于一些依赖相对路径的应用（尤其是 shell 脚本）来讲这样使用软链接的方式也容易翻车😂。

那么有没有一种更好的办法将两个目录进行“硬链接”呢，注意我在此用的是双引号，并非是真正的”硬链接“，搜了一圈发现 mount --bind 这种骚操作。比较适合这种场景。

## bind

其实 bind 这个挂载选项我们在使用 docker 或者 kubernetes 多少都会用到的，尤其是当使用 kubernetes  时 kubelet 在启动容器挂载存储的时候底层是将 node 节点本机的 `/var/lib/kubelet/pods/<Pod的ID>/volumes/kubernetes.io~<Volume类型>/<Volume名字>` 目录通过 bind 的方式挂载到容器中的，详细的分析可以参考之前我写的一篇博客 [kubelet 挂载 volume 原理分析](https://blog.k8s.li/kubelet-mount-volumes-analysis.html) 。

>   -   **Volumes** are stored in a part of the host filesystem which is *managed by Docker* (`/var/lib/docker/volumes/` on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.
>   -   **Bind mounts** may be stored *anywhere* on the host system. They may even be important system files or directories. Non-Docker processes on the Docker host or a Docker container can modify them at any time.
>   -   **`tmpfs` mounts** are stored in the host system’s memory only, and are never written to the host system’s filesystem.

不过那时候并没有详细地去了解 bind 的原理，直到最近翻了一次车才想起来 bind ，于是接下来就详细地分析以下 mount --bind 挂载参数。

```shell
# 使用软链接链接目录
# ls -i 显示文件/目录的 inode 号
╭─root@sg-02 /var/lib
╰─# ln -s /opt/docker /var/lib/docker
╭─root@sg-02 /var/lib
╰─# ls -i /opt | grep docker
2304916 docker
╭─root@sg-02 /var/lib
╰─# ls -i /var/lib | grep docker
    211 docker
    
# 使用硬链接链接两个文件
╭─root@sg-02 /var/lib
╰─# ln /usr/local/bin/docker-compose /usr/bin/docker-compose
╭─root@sg-02 /var/lib
╰─# ls -i /usr/bin/docker-compose
112 /usr/bin/docker-compose
╭─root@sg-02 /var/lib
╰─# ls -i /usr/bin/docker-compose
112 /usr/bin/docker-compose

# 使用 --bind 挂载目录
╭─root@sg-02 /var/lib
╰─# mount --bind /opt/docker /var/lib/docker
╭─root@sg-02 /var/lib
╰─# ls -i /var/lib | grep docker
2304916 docker
╭─root@sg-02 /var/lib
╰─# ls -i /opt | grep docker
2304916 docker
```

我们可以看到当使用使用硬链接或 bind 挂载目录时，两个文件 inode 号是相同的，使用软链接的两个文件的 inode 号是不同的。但目录又不能使用硬链接，而且硬链接不支持跨分区。我们是否可以将 bind 的效果和
“硬链接目录“ 样来使用呢？其实可以这样用，但这样类比并不严谨。

当我们使用 bind 的时候，是将一个目录 A  挂载到另一个目录 B ，目录 B 原有的内容就被屏”蔽掉“了，目录 B 里面的内容就是目录 A 里面的内容。这和我们挂在其他分区到挂载点目录一样，目录 B 的内容还是存在的，只不过是被”屏蔽“掉了，当我们 umount B 后，原内容就会复现。

当我们使用 docker run -v PATH:PATH 启动一个容器的时候，实质上



```
docker run -v /opt/bind/:/var --privileged --rm -it alpine sh
docker inspect 
```

·

```json
        "Mounts": [
            {
                "Type": "bind",
                "Source": "/opt/bind",
                "Destination": "/var",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ]
```


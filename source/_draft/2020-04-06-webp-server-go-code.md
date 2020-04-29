---
title: Golang 入门之 Webp Server Go 源码阅读
date: 2020-04-06
updated:
slug:
categories: 技术
tag:
  - golang
  - 基础
copyright: true
comment: true
---

>   咱来推销 Webp Server Go 啦（小声

## Webp Server Go

上月中旬复工之后一直觉着自己的开发能力很菜，菜的掉渣的那种😂。就想着还是学门编程语言比较好，正好也在 Webp Server Go 项目里摸鱼（其实就是负责 benchmark 啦，还是靠 小土豆和 nova 两位大佬带咱。

先看一下 Webp Server Go 源码的结构，一共有 6 个 .go 文件，外带一个 config.json 配置文件，总代码行数不超过 430 行，在 0.0.3 版本的时候，总代码行数才 260 行就实现了整个 webp server 的功能，可以说是麻雀虽小五脏俱全哈。

```shell
╭─debian@debian ~/webp_server_go  ‹master›
╰─$ ls *.go | xargs wc -l | sort -n
   50 prefetch.go         # 预转换
   60 update.go           # 程序自动更新
   61 helper.go           # 辅助功能
   72 encoder.go          # 图片转码
  100 router.go           # 处理请求
  147 webp-server.go      # 程序入口
  490 total
╭─debian@debian ~/webp_server_go  ‹master›
╰─$ cat *.go | sed -e '/^[ \t]*$/d'  | wc
    429    1369   11954
   
╭─debian@debian ~/webp_server_go  ‹bd5ef5a›
╰─$ cat *.go | sed -e '/^[ \t]*$/d'  | wc
    260     928    7645
```


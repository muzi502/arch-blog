---
title: 让图片飞起来 webp-sh ！
date: 2020-03-05
updated: 2020-03-05
slug: 
categories: 技术
tag:
  - 博客
copyright: true
comment: true
---

> 咱来推销 webp server go 啦 （x小声

## 劝退三连😂

- 需要会命令行操作 (ﾉ*･ω･)ﾉ
- 需要 nginx 反向代理（＞﹏＜）
- 需要独立的服务器，GitHub page 之类的不得行（╯︿╰）

不过，对于已经会自由访问互联网的人来说这都不难 (●ˇ∀ˇ●) ，食用过程中有什么疑问的话也可以联系咱，咱会尽自己所能提供一些帮助😘，一起来完善这个开源项目。

## WebP

WebP 是一种衍生自 Google VP8 的图像格式，同时支持有损和无损编码。当使用有损模式，它在相同体积提供比 JPG 图像更好的质量；当使用无损模式，它提供比最佳压缩的 PNG 图像更小的体积。网站上的图片资源如果使用 WebP，那么自然也会减少这些图片文件的加载时间。

-   [A new image format for the Web](https://developers.google.com/speed/webp)
-   []()

## webp-sh

- 官网 [webp.sh](https://webp.sh)
- GitHub [webp-sh](https://github.com/webp-sh)

webp server 顾名思义就是 webp 服务器啦，用于将网站里的图片（jpg、png、jpeg）资源转换成 webp ，而且无须修改博客站点内图片的 url 。对于访问图片资源的 client 来讲是透明的。

### webp-server-go

![image-20200304191400500](img/image-20200304191400500.png)

### webp-server-rs

### webp-server-node

### webp-server-Java

### webp-server-Python

## 食用指南

### 1. 下载

### 2. 配置

### 3.启动

## benchmark



## 推荐阅读

-   [让站点图片加载速度更快——引入 WebP Server 无缝转换图片为 WebP](https://nova.moe/re-introduce-webp-server/)
-   [记 Golang 下遇到的一回「毫无由头」的内存更改](https://await.moe/2020/02/note-about-encountered-memory-changes-for-no-reason-in-golang/)
-   [WebP Server in Rust](https://await.moe/2020/02/webp-server-in-rust/)
-   [个人网站无缝切换图片到 webp](https://www.bennythink.com/flying-webp.html)
-   [优雅的让 Halo 支持 webp 图片输出](https://halo.run/archives/halo-and-webp)
-   [前端性能优化——使用webp来优化你的图片xx](https://vince.xin/2018/09/12/%E5%89%8D%E7%AB%AF%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E2%80%94%E2%80%94%E4%BD%BF%E7%94%A8webp%E6%9D%A5%E4%BC%98%E5%8C%96%E4%BD%A0%E7%9A%84%E5%9B%BE%E7%89%87/)
-   [探究WebP一些事儿](https://aotu.io/notes/2016/06/23/explore-something-of-webp/index.html)

```bash
╭─root@ubuntu-238 /opt/webp
╰─# time ./webp-server-go -prefetch
Prefetch will convert all your images to webp, it may take some time and consume a lot of CPU resource. Do you want to proceed(Y/n)
y
fatal error: unexpected signal during runtime execution
[signal SIGSEGV: segmentation violation code=0x1 addr=0x74cab335 pc=0x74cab335]

goroutine 2440 [running]:
runtime.throw(0x96edc3, 0x2a)
        /usr/local/go/src/runtime/panic.go:1112 +0x72 fp=0xc004e2dc38 sp=0xc004e2dc08 pc=0x43d452
runtime: unexpected return pc for runtime.sigpanic called from 0x74cab335
stack: frame={sp:0xc004e2dc38, fp:0xc004e2dc68} stack=[0xc004e2c000,0xc004e2e000)
000000c004e2db38:  00007f8b4c347fff  0000000000000400
000000c004e2db48:  0000000000203001  0000000000000400
000000c004e2db58:  0000000000000400  0000000000000010
000000c004e2db68:  00007f8b4c291100  00007f8b4c347fff
000000c004e2db78:  000000c004e2dbb8  000000000042203c <runtime.(*mcentral).grow+316>
000000c004e2db88:  00007f8b4c291000  0020300100000000
000000c004e2db98:  00007f8b4c347fff  00007f8b4dc83d30
000000c004e2dba8:  0010010000000000  0000000000000000
000000c004e2dbb8:  000000c004e2dc00  000000000042198e <runtime.(*mcentral).cacheSpan+414>
000000c004e2dbc8:  000000000043d617 <runtime.fatalthrow+87>  000000c004e2dbd8
000000c004e2dbd8:  0000000000469420 <runtime.fatalthrow.func1+0>  000000c000503500
000000c004e2dbe8:  000000000043d452 <runtime.throw+114>  000000c004e2dc08
000000c004e2dbf8:  000000c004e2dc28  000000000043d452 <runtime.throw+114>
000000c004e2dc08:  000000c004e2dc10  00000000004693a0 <runtime.throw.func1+0>
000000c004e2dc18:  000000000096edc3  000000000000002a
000000c004e2dc28:  000000c004e2dc58  00000000004530ea <runtime.sigpanic+1130>
000000c004e2dc38: <000000000096edc3  000000000000002a
000000c004e2dc48:  00007f8b784de9b8  0000000000000000
000000c004e2dc58:  000000c004e2dcf8 !0000000074cab335
000000c004e2dc68: >00007f8b784de9b8  000000c0066dcd05
000000c004e2dc78:  000000c004e2dcb8  000000000041469b <runtime.convT2Inoptr+107>
000000c004e2dc88:  000000c006921c34  010000c004e2dcec
000000c004e2dc98:  0000000000000004  0000000000000004
000000c004e2dca8:  000000c006921c34  0000000000923640
000000c004e2dcb8:  000000c004e2dcf0  000000c00004aa80
000000c004e2dcc8:  00007f8b784de9b8  0000000000000000
000000c004e2dcd8:  0000000000a008e0  000000c006921c34
000000c004e2dce8:  ffbcaab200000008  000000c004e2dd20
000000c004e2dcf8:  000000c004e2dd38  0000000000414671 <runtime.convT2Inoptr+65>
000000c004e2dd08:  0000000000000004  0000000000923480
000000c004e2dd18:  000000c006921c00  000000c004e2dd70
000000c004e2dd28:  000000000051b16e <image.(*RGBA).Set+158>  0000000000923480
000000c004e2dd38:  000000c004e2dd70  000000000051be21 <image.(*NRGBA).At+129>
000000c004e2dd48:  0000000000a00860  000000c004e2dd6c
000000c004e2dd58:  00000000000001a6  00000000ffbfaeb6
runtime.sigpanic()
        /usr/local/go/src/runtime/signal_unix.go:671 +0x46a fp=0xc004e2dc68 sp=0xc004e2dc38 pc=0x4530ea
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 1 [chan receive]:
main.prefetchImages.func1(0xc0055e2020, 0x1e, 0xa0a7e0, 0xc0001d0340, 0x0, 0x0, 0x4e660f, 0xc0001d0340)
        /root/webp_server_go/webp-server.go:257 +0x266
path/filepath.walk(0xc0055e2020, 0x1e, 0xa0a7e0, 0xc0001d0340, 0xc0001cbd08, 0x0, 0x0)
        /usr/local/go/src/path/filepath/path.go:360 +0x425
path/filepath.walk(0xc0003688e0, 0x11, 0xa0a7e0, 0xc0003704e0, 0xc0001cbd08, 0x0, 0x0)
        /usr/local/go/src/path/filepath/path.go:384 +0x2ff
path/filepath.walk(0xc0000b0672, 0x9, 0xa0a7e0, 0xc000367ee0, 0xc0001cbd08, 0x0, 0x0)
        /usr/local/go/src/path/filepath/path.go:384 +0x2ff
path/filepath.Walk(0xc0000b0672, 0x9, 0xc0001cbd08, 0x0, 0x0)
        /usr/local/go/src/path/filepath/path.go:406 +0xff
main.prefetchImages(0xc0000b0672, 0x9, 0xc0000b0670, 0x2)
        /root/webp_server_go/webp-server.go:246 +0x303
main.main()
        /root/webp_server_go/webp-server.go:281 +0x40d

goroutine 2452 [syscall]:
github.com/chai2010/webp._Cfunc_webpEncodeRGBA(0xc00e5bc000, 0x59300000592, 0x42a0000000001648, 0xc0022c5f08, 0x0)
        _cgo_gotypes.go:375 +0x4e
github.com/chai2010/webp.webpEncodeRGBA(0xc00e5bc000, 0x7c3358, 0x7c3358, 0x592, 0x593, 0x1648, 0x42a00000, 0x0, 0x0, 0x0, ...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/capi.go:213 +0x14b
github.com/chai2010/webp.EncodeRGBA(0xa07a00, 0xc0080460c0, 0x42a00000, 0xc0080460c0, 0x417058, 0xc000098b90, 0x90e820, 0x1)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/webp.go:120 +0x8e
github.com/chai2010/webp.encode(0x9ff040, 0xc00b1b6000, 0xa07940, 0xc008046080, 0xc004e31f24, 0x0, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:85 +0xb2
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc000024100, 0x1e, 0xc000d36100, 0x36, 0x42a00000, 0xc0001d6000, 0xc000d36100, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2337 [runnable]:
image.(*YCbCr).At(0xc00243a080, 0x806, 0x793, 0xfad9e2, 0xc0068ae6a9)
        /usr/local/go/src/image/ycbcr.go:71 +0x78
github.com/chai2010/webp.NewRGBImageFrom(0xa07a80, 0xc00243a080, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/rgb.go:148 +0x165
github.com/chai2010/webp.adjustImage(0xa07a80, 0xc00243a080, 0xc002a99370, 0x2)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:135 +0x353
github.com/chai2010/webp.encode(0x9ff040, 0xc009a44000, 0xa07a80, 0xc00243a080, 0xc00efc3f24, 0xc00243a080, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:75 +0x60
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc01147e020, 0x1e, 0xc000d360c0, 0x36, 0x42a00000, 0xc0001d6000, 0xc000d360c0, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2426 [syscall]:
github.com/chai2010/webp._Cfunc_webpEncodeRGBA(0xc011480000, 0xed800000960, 0x42a0000000002580, 0xc0003931e8, 0x0)
        _cgo_gotypes.go:375 +0x4e
github.com/chai2010/webp.webpEncodeRGBA(0xc011480000, 0x22ca400, 0x22ca400, 0x960, 0xed8, 0x2580, 0x42a00000, 0x0, 0x0, 0x0, ...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/capi.go:213 +0x14b
github.com/chai2010/webp.EncodeRGBA(0xa07a00, 0xc000aae080, 0x42a00000, 0xc000aae080, 0x417058, 0xc0055b6070, 0x90e820, 0x1)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/webp.go:120 +0x8e
github.com/chai2010/webp.encode(0x9ff040, 0xc002cd4120, 0xa07a00, 0xc0057e8080, 0xc0001c9f24, 0x0, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:85 +0xb2
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc0055e22e0, 0x1e, 0xc000d3a2c0, 0x36, 0x42a00000, 0xc0001d6000, 0xc000d3a2c0, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2409 [syscall]:
github.com/chai2010/webp._Cfunc_webpEncodeRGB(0xc004f26000, 0x3bb000005dc, 0x42a0000000001194, 0xc00576c5d0, 0x0)
        _cgo_gotypes.go:357 +0x4e
github.com/chai2010/webp.webpEncodeRGB(0xc004f26000, 0x41931c, 0x41931c, 0x5dc, 0x3bb, 0x1194, 0x42a00000, 0x0, 0x0, 0x0, ...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/capi.go:186 +0x14b
github.com/chai2010/webp.EncodeRGB(0xa076c0, 0xc008046000, 0x42a00000, 0xc008046000, 0x80, 0x0, 0x0, 0xda00000000000001)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/webp.go:114 +0x8e
github.com/chai2010/webp.encode(0x9ff040, 0xc005670000, 0xa07a80, 0xc0017f0100, 0xc00efc2f24, 0xc0017f0100, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:81 +0x16f
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc000368040, 0x1e, 0xc000028140, 0x36, 0x42a00000, 0xc0001d6000, 0xc000028140, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2393 [runnable]:
compress/flate.(*decompressor).huffmanBlock(0xc00016e000)
        /usr/local/go/src/compress/flate/inflate.go:494 +0xbe
compress/flate.(*decompressor).Read(0xc00016e000, 0xc0000c8c57, 0x1142, 0x1142, 0x257, 0x0, 0x0)
        /usr/local/go/src/compress/flate/inflate.go:347 +0x77
compress/zlib.(*reader).Read(0xc000078050, 0xc0000c8c57, 0x1142, 0x1142, 0x257, 0x0, 0x0)
        /usr/local/go/src/compress/zlib/reader.go:94 +0x73
io.ReadAtLeast(0x7f8b4cc1e030, 0xc000078050, 0xc0000c8a00, 0x1399, 0x1399, 0x1399, 0x1399, 0x0, 0x0)
        /usr/local/go/src/io/io.go:310 +0x87
io.ReadFull(...)
        /usr/local/go/src/io/io.go:329
image/png.(*decoder).readImagePass(0xc0055b8400, 0x7f8b4cc1e030, 0xc000078050, 0x0, 0xc000078000, 0xa03280, 0xc000078050, 0x0, 0x0)
        /usr/local/go/src/image/png/reader.go:508 +0x4b4
image/png.(*decoder).decode(0xc0055b8400, 0x0, 0x0, 0x0, 0x0)
        /usr/local/go/src/image/png/reader.go:371 +0x5de
image/png.(*decoder).parseIDAT(0xc0055b8400, 0x16cf66, 0x95d6ef, 0x4)
        /usr/local/go/src/image/png/reader.go:845 +0x36
image/png.(*decoder).parseChunk(0xc0055b8400, 0x0, 0x0)
        /usr/local/go/src/image/png/reader.go:905 +0x3a4
image/png.Decode(0x9ff060, 0xc002cd40c0, 0x95d435, 0x3, 0x6, 0x0)
        /usr/local/go/src/image/png/reader.go:964 +0x13f
main.webpEncoder(0xc01147e040, 0x1e, 0xc000d3a0c0, 0x36, 0x42a00000, 0xc0001d6000, 0xc000d3a0c0, 0x36)
        /root/webp_server_go/webp-server.go:85 +0x784
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2451 [runnable]:
github.com/chai2010/webp.NewRGBImageFrom(0xa07a80, 0xc0000f6380, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/rgb.go:148 +0x179
github.com/chai2010/webp.adjustImage(0xa07a80, 0xc0000f6380, 0xc002b1f370, 0x2)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:135 +0x353
github.com/chai2010/webp.encode(0x9ff040, 0xc00009a7e0, 0xa07a80, 0xc0000f6380, 0xc00efc5f24, 0xc0000f6380, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:75 +0x60
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc0000242c0, 0x1e, 0xc000028100, 0x36, 0x42a00000, 0xc0001d6000, 0xc000028100, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2450 [syscall]:
github.com/chai2010/webp._Cfunc_webpEncodeRGB(0xc00d0b8000, 0xc94000008e9, 0x42a0000000001abb, 0xc000897b70, 0x0)
        _cgo_gotypes.go:357 +0x4e
github.com/chai2010/webp.webpEncodeRGB(0xc00d0b8000, 0x150381c, 0x150381c, 0x8e9, 0xc94, 0x1abb, 0x42a00000, 0x0, 0x0, 0x0, ...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/capi.go:186 +0x14b
github.com/chai2010/webp.EncodeRGB(0xa076c0, 0xc0000d4000, 0x42a00000, 0xc0000d4000, 0x80, 0x0, 0x0, 0xda00000000000001)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/webp.go:114 +0x8e
github.com/chai2010/webp.encode(0x9ff040, 0xc009a44030, 0xa07a80, 0xc0000f6300, 0xc00efc6f24, 0xc0000f6300, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:81 +0x16f
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc005960020, 0x1e, 0xc000268080, 0x36, 0x42a00000, 0xc0001d6000, 0xc000268080, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242

goroutine 2384 [runnable]:
github.com/chai2010/webp.NewRGBImageFrom(0xa07a80, 0xc0017f0080, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/rgb.go:148 +0x179
github.com/chai2010/webp.adjustImage(0xa07a80, 0xc0017f0080, 0xc006756870, 0x2)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:135 +0x353
github.com/chai2010/webp.encode(0x9ff040, 0xc002cd4030, 0xa07a80, 0xc0017f0080, 0xc008bfaf24, 0xc0017f0080, 0x0)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:75 +0x60
github.com/chai2010/webp.Encode(...)
        /root/go/pkg/mod/github.com/chai2010/webp@v1.1.0/writer.go:42
main.webpEncoder(0xc01147e080, 0x1e, 0xc0017ee0c0, 0x36, 0x42a00000, 0xc0001d6000, 0xc0017ee0c0, 0x36)
        /root/webp_server_go/webp-server.go:99 +0x27d
created by main.prefetchImages.func1
        /root/webp_server_go/webp-server.go:256 +0x242
./webp-server-go -prefetch  1396.19s user 26.34s system 783% cpu 3:01.59 total

```

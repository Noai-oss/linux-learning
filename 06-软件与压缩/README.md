<!-- SPDX-License-Identifier: GPL-2.0-only -->

# 软件与压缩

这一章的目标：会用系统的包管理器**装软件**，会用 `tar` / `zip` 做**打包与解压**。

> 包管理器随发行版不同而不同，下面只列最常见的三种。不要在一台机器上混用多个包管理器。

## 一、包管理器对照

| 系统 | 包管理器 | 更新索引 | 安装 | 搜索 |
|---|---|---|---|---|
| Debian / Ubuntu | apt | `sudo apt update` | `sudo apt install 软件` | `apt search 关键词` |
| CentOS / RHEL | dnf / yum | `sudo dnf check-update` | `sudo dnf install 软件` | `dnf search 关键词` |
| macOS | Homebrew | `brew update` | `brew install 软件` | `brew search 关键词` |

几点提醒：

- 装软件需要管理员权限，所以带 `sudo`
- 装之前可以先 `apt search` 确认包名，避免装错
- `apt update` 只是**更新软件索引**，不会升级已装的软件；升级已装软件用 `sudo apt upgrade`

## 二、tar：打包与解包

`tar` 是最常用的打包工具。记住两个组合就够日常使用：

```bash
tar -cvf 包.tar 目录/         # c = 创建，v = 显示过程，f = 指定文件名
tar -xvf 包.tar              # x = 解包
tar -xvf 包.tar -C 目标目录/  # 解到指定目录
tar -tvf 包.tar              # 不解包，只看里面有什么
```

常用参数：

| 参数 | 含义 |
|---|---|
| `c` | 创建新包 |
| `x` | 解包 |
| `v` | 列出处理过程（可省略，只是看得清楚） |
| `f` | 指定文件名，**必须放在最后** |
| `t` | 列出包内文件清单 |
| `z` | 用 gzip 压缩/解压（对应 `.tar.gz` / `.tgz`） |
| `j` | 用 bzip2 压缩/解压（对应 `.tar.bz2`） |
| `C` | 指定解包目标目录 |

带压缩的写法：`tar -czvf 包.tar.gz 目录/`、`tar -xzvf 包.tar.gz`。

## 三、zip / unzip

```bash
zip -r 包.zip 目录/          # 打包并压缩
unzip 包.zip                # 解压到当前目录
unzip 包.zip -d 目标目录/    # 解压到指定目录
unzip -l 包.zip             # 不解压，查看内容
```

## 四、判断压缩包类型

| 后缀 | 用什么解 |
|---|---|
| `.tar` | `tar -xvf` |
| `.tar.gz` / `.tgz` | `tar -xzvf` |
| `.tar.bz2` | `tar -xjvf` |
| `.tar.xz` | `tar -xJvf` |
| `.zip` | `unzip` |

记不住参数时，`tar -xvf` 通常能自动识别 gzip / bzip2，可以直接试。

## 练一练

把 `07-实战练习/练习素材/` 整个目录打包成 `练习素材.tar.gz`，再解压到一个新目录，确认内容一致。

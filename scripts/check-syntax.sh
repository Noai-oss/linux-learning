#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-only
# 用 shellcheck 检查本仓库里的脚本语法（如已安装）
set -e

if ! command -v shellcheck >/dev/null 2>&1; then
    echo "未安装 shellcheck，跳过检查。"
    echo "安装方式：sudo apt install shellcheck  或  brew install shellcheck"
    exit 0
fi

echo "==> 检查 scripts/ 目录下的脚本"
shellcheck scripts/*.sh
echo "==> 全部通过"

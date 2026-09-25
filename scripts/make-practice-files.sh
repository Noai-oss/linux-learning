#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-only
# 为「07-实战练习」创建一套无害的练习素材
set -e

DIR="07-实战练习/练习素材"
mkdir -p "$DIR"

# 生成三个内容不同的文本文件
cat > "$DIR/笔记一.txt" <<'EOF'
今天学了 ls 和 cd
ls -l 可以看详情
cd .. 回到上一级
EOF

cat > "$DIR/笔记二.txt" <<'EOF'
今天学了 cp 和 mv
cp 是复制，mv 是移动
mv 也可以用来改名
EOF

cat > "$DIR/配置.txt" <<'EOF'
# 这是一个示例配置文件
name=demo
version=1.0
enabled=true
EOF

mkdir -p "$DIR/子目录"
echo "这是子目录里的文件" > "$DIR/子目录/示例.md"

echo "==> 素材已生成在 $DIR"
ls -R "$DIR"

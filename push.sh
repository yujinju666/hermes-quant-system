#!/bin/bash
# Hermes Quant System — GitHub 一键推送脚本
# 使用前: 先运行 gh auth login --web 登录GitHub

set -e
cd "$(dirname "$0")"

echo "🚀 推送 Hermes Quant System 到 GitHub..."

# 检查是否已登录gh
if ! gh auth status 2>/dev/null; then
    echo "⚠️  需要先登录GitHub"
    echo "运行: gh auth login --web"
    echo "然后重试本脚本"
    exit 1
fi

# 创建GitHub仓库（如果不存在）
gh repo create hermes-quant-system \
  --public \
  --description "Hermes Quant System - 自动化合约量化交易 + 飞书实时推送 + AI大模型驱动" \
  --source . \
  --remote origin \
  --push 2>/dev/null || {

    # 仓库已存在，直接推送
    git remote add origin https://github.com/$(gh api user | grep -o '"login":"[^"]*"' | cut -d'"' -f4)/hermes-quant-system.git 2>/dev/null || true
    git push -u origin main
}

echo "✅ 推送完成！"
echo "🌐 https://github.com/$(gh api user | grep -o '"login":"[^"]*"' | cut -d'"' -f4)/hermes-quant-system"

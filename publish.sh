#!/bin/bash
# ============================================
# Hermes Quant — 一键全网发布工具
# ============================================
# 帮你完成：GitHub推送 + 社交账号注册指引
# ============================================

set -e
cd "$(dirname "$0")"

echo "╔═══════════════════════════════════════╗"
echo "║   Hermes Quant — 一键发布             ║"
echo "╚═══════════════════════════════════════╝"
echo ""

# === 检测 GitHub CLI ===
if ! command -v gh &>/dev/null; then
    echo "📦 正在安装 GitHub CLI..."
    brew install gh 2>/dev/null || npm install -g gh 2>/dev/null || {
        echo "❌ 请手动安装: brew install gh"
        exit 1
    }
fi

# === GitHub 登录 ===
if ! gh auth status &>/dev/null; then
    echo "🔐 请登录 GitHub（浏览器会弹出）"
    echo "   如果没有账号，先去 https://github.com/signup 注册"
    echo ""
    gh auth login --web
fi

# === 创建仓库并推送 ===
echo ""
echo "🚀 正在创建 GitHub 仓库..."

REPO_NAME="hermes-quant-system"
REPO_DESC="Hermes Quant System - 自动化合约量化交易 + AI驱动策略 + 飞书实时推送"

gh repo create "$REPO_NAME" \
  --public \
  --description "$REPO_DESC" \
  --source . \
  --remote origin \
  --push 2>/dev/null || {
    echo "⚠️  仓库可能已存在，尝试推送..."
    git remote add origin "https://github.com/$(gh api user | jq -r '.login')/$REPO_NAME.git" 2>/dev/null
    git push -u origin main
  }

echo ""
echo "✅ GitHub 发布完成！"
echo "🌐 https://github.com/$(gh api user | jq -r '.login')/$REPO_NAME"
echo ""
echo "═══════════════════════════════════════"
echo "  下一步：注册 X/Twitter @Hermes_Quant"
echo "  然后在 README 和官网更新联系方式"
echo "═══════════════════════════════════════"

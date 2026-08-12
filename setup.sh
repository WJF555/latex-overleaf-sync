#!/usr/bin/env bash
# ============================================================
#  latex-overleaf-sync 一键部署脚本 (Linux / macOS)
#  仅负责环境安装: 检查 Node.js -> 安装 olcli
#  认证与项目同步请按 README 手动执行:
#    olcli auth --cookie "..."   # 认证 Overleaf
#    olcli pull "项目名" "目录"    # 拉取项目
#    olcli push / olcli sync      # 日常同步
# ============================================================
set -e

echo ""
echo "=============================================="
echo "  latex-overleaf-sync 一键部署"
echo "=============================================="

# [1/2] 检查 Node.js / npm
echo ""
echo "[1/2] 检查 Node.js 环境..."
if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
    echo "未检测到 Node.js，请先安装: https://nodejs.org/ (LTS 版本)"
    echo "  macOS:  brew install node"
    echo "  Ubuntu: sudo apt install nodejs npm"
    exit 1
fi
echo "[OK] Node.js $(node --version) / npm $(npm --version)"

# [2/2] 安装 olcli (如缺失)
echo ""
echo "[2/2] 检查 olcli..."
if command -v olcli >/dev/null 2>&1; then
    echo "[OK] olcli $(olcli --version) 已安装"
else
    echo "未安装 olcli，正在全局安装 @aloth/olcli ..."
    npm install -g @aloth/olcli
    export PATH="$(npm prefix -g)/bin:$PATH"
    if command -v olcli >/dev/null 2>&1; then
        echo "[OK] olcli $(olcli --version) 安装完成"
    else
        echo "olcli 安装完成，但请重新打开终端使 PATH 生效。" >&2
        exit 1
    fi
fi

# 下一步提示
echo ""
echo "=============================================="
echo "  环境就绪! 下一步请按 README 操作:"
echo ""
echo "  1. 认证 Overleaf (README 步骤 5):"
echo "     olcli auth --cookie \"你的overleaf_session2\""
echo ""
echo "  2. 拉取项目并生成配置:"
echo "     olcli pull \"项目名称\" \"本地目录\""
echo ""
echo "  3. 日常同步:"
echo "     olcli pull / olcli push / olcli sync"
echo "=============================================="

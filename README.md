# latex-overleaf-sync

本地编译 + VS Code + Overleaf 同步的完整工作流 (with a template for ICRA latex).

`latex` `overleaf` `local-compile` `vscode` `latex-workshop` `olcli` `sync` `workflow`

## 为什么选择 **Ours**？

Overleaf 同步方案对比：

| 方案 | 费用 | 适用场景 | 
|------|------|---------|
| **Ours** | ✅ 免费 | 个人/小团队 |
| Git Bridge | 💰 付费 | 团队协作 | 

**推荐：Ours** — 免费、命令行友好、支持 pull/push/sync。

## 工作流拓扑

```
┌─────────────────────────────────────────────────────────────────┐
│                        LOCAL (你的电脑)                          │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────┐ │
│  │   VS Code   │───▶│  TeX Live   │───▶│   PDF 预览/跳转     │ │
│  │  (编辑器)   │    │  (编译器)   │    │   (LaTeX Workshop)  │ │
│  └─────────────┘    └─────────────┘    └─────────────────────┘ │
│         │                                                     │
│         ▼                                                     │
│  ┌─────────────┐                                              │
│  │   olcli     │◀─── pull / push / sync                      │
│  └─────────────┘                                              │
└─────────────────────────────────────────────────────────────────┘
                            │
                            │ HTTPS (cookie 认证)
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                      OVERLEAF (云端)                            │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────────────┐ │
│  │  在线编辑器  │    │  云端编译   │    │   版本历史/协作     │ │
│  └─────────────┘    └─────────────┘    └─────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

## 优势

- **本地编译** — 无网络依赖，编译速度快，无超时限制
- **VS Code 集成** — 智能补全、SyncTeX 跳转、保存自动编译
- **Overleaf 协作** — 远程备份、多人协作、版本历史
- **olcli 同步** — 免费、命令行友好、一键 pull/push

## 环境配置

> 不想手动一步步配置？直接使用下方 **一键部署** 即可完成 步骤 1-4。

### 0. 一键部署 (推荐, Linux/macOS)

只需安装 Node.js（https://nodejs.org/ LTS），然后：

```bash
# 1. 克隆本仓库
git clone <仓库地址>
cd <项目文件夹>

# 2. 运行一键部署脚本 (自动安装 olcli)
bash setup.sh
```

完成后继续 [5. 认证 Overleaf](#5-认证-overleaf) 即可开始使用。

### 1. 安装 TeX Live

```bash
# 下载 TeX Live: https://www.tug.org/texlive/
# 安装到 D:\texlive (或自定义路径)
# 安装完成后验证:
pdflatex --version
```

### 2. 安装 VS Code + LaTeX Workshop

```bash
# 安装 VS Code: https://code.visualstudio.com/
# 安装 LaTeX Workshop 插件: James-Yu.latex-workshop
```

### 3. 配置 LaTeX Workshop

将 `.vscode/settings.json` 复制到你的项目中：

```json
{
    "latex-workshop.latex.tools": [
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex",
            "tools": ["pdflatex"]
        }
    ],
    "latex-workshop.latex.recipe.default": "lastUsed",
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.view.pdf.internal.synctex.keybind": "ctrl-click",
    "latex-workshop.latex.autoBuild.run": "onSave"
}
```

### 4. 安装 olcli (Overleaf CLI)

> 使用一键部署脚本 `bash setup.sh` 可自动完成本步骤。

```bash
npm install -g @aloth/olcli
```

### 5. 认证 Overleaf

1. 打开 https://www.overleaf.com 并登录
2. F12 → Application → Cookies → `overleaf_session2`
3. 复制 cookie 值

```bash
olcli auth --cookie "你的cookie值"
```

## 日常使用

### 编辑论文

1. 用 VS Code 打开项目文件夹
2. 编辑 `.tex` 文件，保存时自动编译
3. Ctrl+Alt+V 预览 PDF
4. Ctrl+Click 在源码和 PDF 之间跳转

### 同步到 Overleaf

```bash
# 拉取远程更改
olcli pull "项目名称" "本地路径"

# 推送本地更改
olcli push "本地路径"

# 双向同步
olcli sync "本地路径"
```

### 完整工作流

```bash
# 1. 拉取最新版本
olcli pull "IEEE Conference Template" "."

# 2. 编辑论文 (用 VS Code)
code .

# 3. 推送更改
olcli push "."
```

## 项目结构

```
├── .gitignore               # Git 忽略规则
├── README.md                # 本文件
├── setup.sh                  # 一键部署脚本 (Linux/macOS)
└── overleaf_project/
    ├── .vscode/
    │   └── settings.json    # LaTeX Workshop 配置
    ├── conference_101719.tex # 主 LaTeX 文件
    ├── fig1.png             # 图片
    ├── IEEEtran.cls         # IEEE 模板类文件
    └── IEEEtran_HOWTO.pdf   # 模板使用说明
```

## 常见问题

### Cookie 过期

Overleaf cookie 有效期约 5 天，过期后需重新获取：

```bash
olcli auth --cookie "新cookie值"
```

### 编译失败

确保 TeX Live 已正确安装并在 PATH 中：

```bash
pdflatex --version
```

### 同步冲突

如果本地和远程都有修改，使用 `olcli sync` 会自动检测冲突并提示选择。
# ICRA2026 LaTeX Workflow

本地编译 + VS Code + Overleaf 同步的完整工作流。

## 优势

| 特性 | 说明 |
|------|------|
| 本地编译 | 快速、无限制、无网络依赖 |
| VS Code | 智能编辑、LaTeX Workshop 插件、SyncTeX 跳转 |
| Overleaf | 远程协作、无限制存储 |
| olcli | 命令行同步，支持 pull/push/sync |

## 环境配置

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
├── .vscode/
│   └── settings.json        # LaTeX Workshop 配置
├── .gitignore               # Git 忽略规则
├── README.md                # 本文件
├── conference_101719.tex    # 主 LaTeX 文件
├── fig1.png                 # 图片
├── IEEEtran.cls             # IEEE 模板类文件
└── IEEEtran_HOWTO.pdf       # 模板使用说明
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

## License

MIT

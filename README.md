# ALICE PaperPal

**ALICE PaperPal** — 基于 MinerU + DeepSeek V4 的论文辅助阅读工具。支持 Windows 桌面和 Android 移动端。

搜索论文、导入 PDF、自动解析、自动翻译、AI 问答与摘要。AI 伙伴会记住你的偏好和过往对话，像真人一样陪伴你阅读论文。

> **v0.3.0 新增 Android 支持** — 完整的 Android 移动端适配，自适应底部导航、平台抽象层加密、移动端阅读体验优化。[⬇ 下载 APK](https://github.com/jonah791/alice-paperpal/releases/latest)

## 快速开始

### 桌面应用

从 [Releases](https://github.com/jonah791/alice-paperpal/releases) 下载最新版：
- `ALICE-PaperPal-v*.Setup.exe` — 安装包（推荐）
- `ALICE-PaperPal-v*.zip` — 便携版（解压即用）

### Android 移动端

从 [Releases](https://github.com/jonah791/alice-paperpal/releases) 下载 `app-release.apk`，安装到 Android 7.0+ 设备。

### CLI 工具（无需 Flutter GUI）

```bash
git clone https://github.com/jonah791/alice-paperpal.git
cd alice-paperpal
dart run tool/paperpal.dart help
```

12 个命令覆盖全部产品功能：

| 命令 | 功能 |
|---|---|
| `config set/get/list` | 配置 API Key、模型等 |
| `search <query>` | arXiv + Semantic Scholar 搜索 |
| `import search <index>` | 从搜索结果导入 |
| `import pdf <path>` | 解析本地 PDF（MinerU API） |
| `import url <url>` | 解析 URL 论文 |
| `papers list/show/delete` | 论文管理 |
| `ask <id> <question>` | AI 问答（含灵魂/画像/记忆上下文） |
| `summarize <id>` | AI 摘要 |
| `translate <id>` | AI 翻译 |
| `export bibtex/markdown <id>` | 导出 |
| `soul list/set` | 灵魂管理 |
| `note list/add/delete` | 笔记 |
| `memory list/prune` | 记忆管理 |
| `portrait show` | 用户画像 |

```bash
# 示例：配置密钥 → 搜索 → 解析 → 问答
dart run tool/paperpal.dart config set llm-api-key <key>
dart run tool/paperpal.dart search "transformer attention"
dart run tool/paperpal.dart import url https://arxiv.org/pdf/1706.03762.pdf
dart run tool/paperpal.dart ask <id> "核心贡献是什么？"
```

### 从源码构建

```bash
git clone https://github.com/jonah791/alice-paperpal.git
cd alice-paperpal
flutter pub get

# Windows 桌面版
flutter build windows --release
# 产物：build/windows/x64/runner/Release/paperpal.exe

# Android APK
flutter build apk --release
# 产物：build/app/outputs/flutter-apk/app-release.apk
```

### 首次使用

**Windows：**
1. 运行安装包（或解压 ZIP 后运行 paperpal.exe）
2. 在设置页填入 LLM API Key
3. 选择或创建一个 AI 伙伴（灵魂）
4. 搜索论文或上传 PDF
5. 自动解析 + 自动翻译 → 开始阅读

**Android：**
1. 安装 APK 后打开
2. 在设置页填入 LLM API Key
3. 其余步骤同上

## 功能

| 功能 | 说明 |
|---|---|---|
| **AI 灵魂** | 预置 4 个角色（学术导师/代码专家/审稿人/科普达人），也可用自然语言创建自定义灵魂 |
| **元灵魂** | 底层生命规则，让 AI 伙伴自然地引用过往、表达情绪、说"我不确定" |
| **对话记忆** | 每次对话自动生成摘要，跨 session 注入，AI 伙伴记得你之前讨论过什么 |
| **用户画像** | LLM 自动维护你的兴趣和偏好，你不需要做任何操作 |
| **头像系统** | 内置默认头像 + 从相册选择，AI 伙伴有一个"脸" |
| **论文搜索** | arXiv + Semantic Scholar 一键搜索，实时下载进度 |
| **本地上传** | 选择本地 PDF，自动解析 |
| **URL 导入** | 粘贴 arXiv 链接或 PDF 直链，自动下载 |
| **PDF 文件关联** | 双击 .pdf 自动用 PaperPal 打开（运行 `windows/install_assoc.bat`） |
| **自动解析** | MinerU v4 API 异步解析：公式 → LaTeX、表格 → HTML、图片提取 |
| **论文库管理** | 按状态筛选（已解析/已翻译/错误），支持批量删除 |
| **自动翻译** | 非中文论文自动检测 + DeepSeek 全文翻译，原文/译文/对照三模式 |
| **AI 问答** | 流式输出，逐字显示，基于灵魂+记忆+画像的个性化回答 |
| **摘要生成** | 一句话 + 结构化摘要 |
| **公式解释** | 点击公式 → AI 解读 |
| **多论文对比** | 长按选择多篇论文 → AI 对比分析 |
| **笔记系统** | 阅读时添加笔记，持久化保存 |
| **导出** | Markdown / BibTeX 导出 |
| **双主题** | Alice in Wonderland 主题 — 深紫+暖金暗色 / 暖白+金日间，可一键切换 |
| **动效系统** | 动感渐变背景、页面过渡动画、扑克牌花色加载、错列入场、骨架屏 |
| **自定义字体** | Playfair Display（标题）、Inter（UI）、Noto Serif SC（中文阅读） |
| **全新图标** | 256×256 爱丽丝主题应用图标 |
| **安装包** | Windows: Inno Setup 安装包 + ZIP 便携版<br>Android: APK（CI 自动构建） |
| **Android 平台** | 自适应底部导航、平台抽象加密（Android Keystore）、移动端阅读优化 |
| **论文库** | 本地缓存 + 持久化，重启不丢失 |

## 架构

```
ALICE PaperPal (Flutter Desktop + Android)
    │
    ├── MinerU v4 API     PDF → Markdown/LaTeX/HTML（异步任务提交 → 轮询）
    ├── DeepSeek V4 API   问答 / 翻译 / 摘要
    ├── arXiv API         论文搜索
    └── Semantic Scholar  论文搜索
```

**无自建后端服务器。** 所有 API 直连外部服务，用户自备 API Key。

**跨平台：** 单代码库（single entry point），`PlatformService` 抽象层处理平台差异（加密、文件打开、窗口管理）。桌面端 90%+ 代码与移动端共享。

## 项目结构

```
paperpal/
├── lib/
│   ├── main.dart                    # 入口 + Dependencies DI + AnimatedBackground
│   ├── core/
│   │   ├── api/                     # 外部 API 客户端
│   │   ├── models/                  # 数据模型
│   │   ├── services/                # 业务服务（含 platform_service.dart 平台抽象层）
│   │   └── utils/                   # 工具
│   └── ui/
│       ├── pages/                   # 页面（7 个）
│       ├── widgets/                 # 组件（10 个）
│       └── theme/                   # 主题（Alice in Wonderland 双主题）
├── android/                         # Android 工程
├── test/                            # 320+ 个单元测试
├── tool/                            # CLI 命令行工具
└── windows/
    ├── installer.iss                # Inno Setup 安装包脚本
    └── runner/resources/            # 应用图标
```

## 配置

| 配置项 | 说明 | 默认 |
|---|---|---|
| LLM API Key | DeepSeek / OpenAI / Claude | 必填 |
| LLM API Base | OpenAI 兼容 API 地址 | `https://api.deepseek.com` |
| MinerU API Key | MinerU 解析服务 Token | 必填 |
| MinerU 模型版本 | vlm（推荐）/ pipeline / MinerU-HTML | `vlm` |
| 公式识别 | 是否提取 LaTeX 公式 | 开启 |
| 表格识别 | 是否提取 HTML 表格 | 开启 |
| 自动翻译 | 非中文论文自动翻译 | 开启 |

## 技术栈

- **框架:** Flutter (Dart) + Material 3
- **桌面:** 原生 Flutter Windows（无需 Python）
- **移动端:** Android 7.0+ (API 24+)
- **解析:** MinerU v4 API（异步任务模型，支持预签名上传）
- **LLM:** DeepSeek V4 / OpenAI / Claude
- **搜索:** arXiv + Semantic Scholar
- **安全:** HTTPS 强制 / DPAPI 加密（桌面）+ Android Keystore（移动端）/ 日志脱敏
- **UI 主题:** 自定义双主题 ColorScheme（深紫+暖金 / 暖白+金）
- **UI 字体:** Google Fonts — Playfair Display, Inter, Noto Serif SC
- **UI 动效:** AnimationController + CustomPainter 动感渐变背景
- **测试:** 320+ 个单元测试覆盖 models/services/utils/API
- **CLI 工具:** 纯 Dart 命令行，`dart run tool/paperpal.dart`
- **打包:** Windows: Inno Setup + ZIP / Android: APK
- **CI:** GitHub Actions (analyze → test → build → release)

## 许可

[Apache 2.0](LICENSE)

## 致谢

- [MinerU](https://github.com/opendatalab/MinerU) — 高精度文档解析引擎
- [DeepSeek](https://deepseek.com) — LLM API
- [arXiv](https://arxiv.org) — 论文搜索 API
- [Semantic Scholar](https://semanticscholar.org) — 论文搜索 API
- [Syncfusion](https://www.syncfusion.com) — PDF 库（社区许可）

# Changelog

## [0.2.0] - 2026-05-10

### Added

- **灵魂系统**：4 个预置灵魂（学术导师/代码专家/论文审稿人/科普达人）+ 零代码创建向导（LLM 从自然语言生成灵魂定义）
- **元灵魂（Meta-Soul）**：底层生命规则，定义主动性、连续性、人性化行为
- **用户画像**：LLM 自动维护用户兴趣/偏好画像，对话后异步更新，用户无感
- **对话记忆**：自动积累对话摘要，跨 session 注入，所有灵魂共享（连续生命感）
- **头像系统**：内置默认头像（首字母+色块）+ image_picker 从相册选择
- **流式响应**：SSE 流式输出，Q&A 逐字显示
- **主动事件**：启动问候（引用最近记忆）、解析完成后主动评论
- **Windows DPAPI 加密**：通过 dart:ffi 调用 CryptProtectData 加密 API Key
- **共享 Dio 客户端**：统一 HTTPS 强制 + 重试拦截器
- **重试逻辑**：RetryInterceptor（3 次重试，指数退避）
- **网络状态检测**：connectivity_plus + NavigationRail 底部状态图标
- **导出功能**：Markdown / BibTeX 导出
- **PDF 原始视图**：系统默认 PDF 阅读器打开
- **多论文对比**：长按多选 → AI 对比分析
- **公式/表格解释**：选中公式/表格 → AI 解读
- **标注/笔记**：侧栏笔记面板，持久化存储
- **URL 导入**：粘贴 arXiv 链接或 PDF 直链
- **PDF 文件关联**：install_assoc.bat 注册 Windows 文件关联
- **单元测试**：18 个测试覆盖 models + translation + services

## [0.1.0] - 2026-05-09

### Added

- 初始版本
- 论文搜索 (arXiv + Semantic Scholar)
- PDF 本地上传
- MinerU API 解析（含自动分批）
- 自动翻译（语言检测 → 翻译 → 后校验 → 缓存）
- AI 问答与摘要
- Markdown + LaTeX 阅读视图
- 原文/译文/对照三模式
- 论文库本地缓存 + 持久化（JSON 索引）
- 系统托盘 + 窗口管理
- 暗黑模式
- 字体大小调整
- 欢迎页 + 首次引导
- 设置页（API Key 配置）
- 键盘快捷键（Ctrl+S/L/P/Q）
- 日志系统（脱敏 + 文件轮转）

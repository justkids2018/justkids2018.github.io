# Blog Agent Guide

在本仓库创建或整理笔记前，请遵守以下核心规范（详细约定见 `docs/note-conventions.md`）：

## 1. 目录与命名
- **文章目录**：`content/post/<分类>/<年份>/<具体文件名>.md`（如 `content/post/invest/2026/投资-不为清单-2026-10-24.md`、`content/post/thinking/2026/...`）
- **文章标题**：`<文章名称>｜<YYYY-MM-DD>`（全角竖线分隔，日期只用数字，如 `我的投资不为清单（Stop Doing List）｜2026-10-24`）
- **Front Matter**：`description: ""` 默认留空，保持页面与卡片简洁。

## 2. 封面配图（Cover Image）
- **存放路径**：`static/<分类>/<英文文件名>.jpg`（如 `image: /invest/stop-doing-list-cover.jpg`）
- **比例与构图**：统一使用 **`2.5:1`** 宽幅横条（如 `1376 × 550`，可通过 `sips` 裁切），核心主体与文字必须垂直居中（避免列表卡片裁切）。
- **视觉风格（二选一，保持简洁）**：
  1. **桌面摄影风**（清单/思考类）：木质桌面、米白笔记本上钢笔手写核心英文标题（如 `Stop Doing List`），配钢笔与咖啡。
  2. **人物/纪实风**（访谈/案例类）：高清人物或真实场景画面，干净留白，可辅以极简文字。

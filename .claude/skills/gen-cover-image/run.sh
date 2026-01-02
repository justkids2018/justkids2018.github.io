#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 获取文件路径参数
FILE_PATH="${1:-$CLAUDE_CURRENT_FILE}"

if [ -z "$FILE_PATH" ]; then
    echo -e "${RED}错误: 未提供文件路径${NC}"
    echo "用法: /gen-cover-image [文件路径]"
    exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
    echo -e "${RED}错误: 文件不存在: $FILE_PATH${NC}"
    exit 1
fi

echo -e "${GREEN}开始为文章生成封面图...${NC}"

# 提取文章信息
TITLE=$(grep "^title:" "$FILE_PATH" | sed 's/title: *"\(.*\)"/\1/' | head -1)
SUBTITLE=$(grep "^subtitle:" "$FILE_PATH" | sed 's/subtitle: *"\(.*\)"/\1/' | head -1)

if [ -z "$TITLE" ]; then
    echo -e "${RED}错误: 无法提取文章标题${NC}"
    exit 1
fi

echo -e "${YELLOW}原始标题: $TITLE${NC}"
echo -e "${YELLOW}原始副标题: $SUBTITLE${NC}"
echo ""

# 使用Claude API分析文章内容，生成更合适的标题和副标题
echo -e "${GREEN}正在分析文章内容，生成优化的标题...${NC}"

# 读取文章完整内容
ARTICLE_CONTENT=$(cat "$FILE_PATH")

# 检查是否有Claude API配置（支持两种环境变量名）
API_KEY="${ANTHROPIC_API_KEY:-$ANTHROPIC_AUTH_TOKEN}"

if [ -z "$API_KEY" ]; then
    echo -e "${YELLOW}警告: 未设置 ANTHROPIC_API_KEY 或 ANTHROPIC_AUTH_TOKEN，将使用原始标题${NC}"
    OPTIMIZED_TITLE="$TITLE"
    OPTIMIZED_SUBTITLE="$SUBTITLE"
else
    # 调用Claude API分析文章
    API_BASE="${ANTHROPIC_BASE_URL:-https://api.anthropic.com}"

    ANALYSIS_PROMPT="请分析以下投资主题的博客文章内容，为其生成一个更专业、更吸引人的标题和副标题。

要求：
1. 标题要简洁有力，体现文章核心主题（10-20字）
2. 副标题要补充说明，吸引读者（15-30字）
3. 符合价值投资、理性思考的调性
4. 适合作为博客文章的标题

请直接返回JSON格式：
{
  \"title\": \"建议的标题\",
  \"subtitle\": \"建议的副标题\"
}

文章内容：
$ARTICLE_CONTENT"

    CLAUDE_RESPONSE=$(curl -s "$API_BASE/v1/messages" \
        -H "Content-Type: application/json" \
        -H "x-api-key: $API_KEY" \
        -H "anthropic-version: 2023-06-01" \
        -d "{
            \"model\": \"claude-3-5-sonnet-20241022\",
            \"max_tokens\": 1024,
            \"messages\": [{
                \"role\": \"user\",
                \"content\": $(echo "$ANALYSIS_PROMPT" | jq -Rs .)
            }]
        }")

    # 提取Claude返回的内容
    CLAUDE_TEXT=$(echo "$CLAUDE_RESPONSE" | jq -r '.content[0].text' 2>/dev/null || echo "")

    # 调试：检查API错误
    if echo "$CLAUDE_RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
        ERROR_MSG=$(echo "$CLAUDE_RESPONSE" | jq -r '.error.message' 2>/dev/null)
        echo -e "${YELLOW}警告: Claude API错误: $ERROR_MSG${NC}"
        echo -e "${YELLOW}使用原始标题${NC}"
        OPTIMIZED_TITLE="$TITLE"
        OPTIMIZED_SUBTITLE="$SUBTITLE"
    elif [ -n "$CLAUDE_TEXT" ] && [ "$CLAUDE_TEXT" != "null" ]; then
        # 提取JSON中的标题和副标题
        OPTIMIZED_TITLE=$(echo "$CLAUDE_TEXT" | jq -r '.title' 2>/dev/null || echo "$TITLE")
        OPTIMIZED_SUBTITLE=$(echo "$CLAUDE_TEXT" | jq -r '.subtitle' 2>/dev/null || echo "$SUBTITLE")

        echo -e "${GREEN}✓ AI优化后的标题: $OPTIMIZED_TITLE${NC}"
        echo -e "${GREEN}✓ AI优化后的副标题: $OPTIMIZED_SUBTITLE${NC}"
    else
        echo -e "${YELLOW}警告: Claude API返回为空，使用原始标题${NC}"
        OPTIMIZED_TITLE="$TITLE"
        OPTIMIZED_SUBTITLE="$SUBTITLE"
    fi
fi

echo ""

# 创建图片保存目录
IMAGE_DIR="static/images/post/$(date +%Y)"
mkdir -p "$IMAGE_DIR"

# 生成图片文件名
IMAGE_FILENAME="cover_$(date +%Y%m%d_%H%M%S).png"
IMAGE_PATH="$IMAGE_DIR/$IMAGE_FILENAME"
IMAGE_REF="/images/post/$(date +%Y)/$IMAGE_FILENAME"

echo -e "${GREEN}图片将保存到: $IMAGE_PATH${NC}"

# 生成图片提示词
read -r -d '' PROMPT_TEMPLATE <<'EOF' || true
根据以下投资主题文章生成一张16:9比例的封面图：

标题：{TITLE}
副标题：{SUBTITLE}

设计要求：
- 16:9比例，适合博客文章封面
- 投资理财主题，专业且有深度
- 色调：沉稳、理性，使用深蓝、金色、灰色等商务色调
- 元素：可以包含图表、书籍、金融符号、上升曲线等
- 风格：现代简约，避免过于花哨
- 文字：可以包含标题文字，字体清晰专业
- 整体氛围：知识分享、价值投资、理性思考

请生成一张符合以上要求的图片。
EOF

# 替换模板中的变量（使用优化后的标题）
PROMPT="${PROMPT_TEMPLATE//\{TITLE\}/$OPTIMIZED_TITLE}"
PROMPT="${PROMPT//\{SUBTITLE\}/$OPTIMIZED_SUBTITLE}"

echo -e "${YELLOW}图片生成提示词:${NC}"
echo "$PROMPT"
echo ""

# 检查图片生成服务配置
IMAGE_SERVICE="${CLAUDE_IMAGE_SERVICE:-openai}"

case "$IMAGE_SERVICE" in
    "openai")
        # 使用 OpenAI DALL-E API
        if [ -z "$OPENAI_API_KEY" ]; then
            echo -e "${RED}错误: 未设置 OPENAI_API_KEY 环境变量${NC}"
            echo "请在 ~/.claude/settings.json 中配置:"
            echo '{'
            echo '  "env": {'
            echo '    "OPENAI_API_KEY": "your-api-key-here",'
            echo '    "CLAUDE_IMAGE_SERVICE": "openai"'
            echo '  }'
            echo '}'
            exit 1
        fi

        echo -e "${GREEN}使用 OpenAI DALL-E 生成图片...${NC}"

        # 调用 OpenAI API 生成图片
        RESPONSE=$(curl -s -X POST "https://api.openai.com/v1/images/generations" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $OPENAI_API_KEY" \
            -d "{
                \"model\": \"dall-e-3\",
                \"prompt\": $(echo "$PROMPT" | jq -Rs .),
                \"n\": 1,
                \"size\": \"1792x1024\",
                \"quality\": \"standard\"
            }")

        # 检查是否有错误
        if echo "$RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
            ERROR_MSG=$(echo "$RESPONSE" | jq -r '.error.message')
            echo -e "${RED}OpenAI API 错误: $ERROR_MSG${NC}"
            exit 1
        fi

        # 获取图片URL
        IMAGE_URL=$(echo "$RESPONSE" | jq -r '.data[0].url')

        if [ "$IMAGE_URL" = "null" ] || [ -z "$IMAGE_URL" ]; then
            echo -e "${RED}错误: 未能从API响应中获取图片URL${NC}"
            echo "API响应: $RESPONSE"
            exit 1
        fi

        echo -e "${GREEN}图片生成成功，下载中...${NC}"

        # 下载图片
        curl -s "$IMAGE_URL" -o "$IMAGE_PATH"
        ;;

    "stable-diffusion")
        # 预留：可以添加 Stable Diffusion API 支持
        echo -e "${RED}Stable Diffusion 服务尚未实现${NC}"
        exit 1
        ;;

    "manual")
        # 手动模式：只生成提示词，不实际生成图片
        echo -e "${YELLOW}手动模式：请使用以下提示词手动生成图片${NC}"
        echo "================================"
        echo "$PROMPT"
        echo "================================"
        echo ""
        echo -e "${YELLOW}图片生成后，请保存到: $IMAGE_PATH${NC}"
        echo -e "${YELLOW}然后运行以下命令更新文章:${NC}"
        echo "sed -i '' 's|^image:.*|image: $IMAGE_REF|' \"$FILE_PATH\""
        exit 0
        ;;

    *)
        echo -e "${RED}未知的图片生成服务: $IMAGE_SERVICE${NC}"
        echo "支持的服务: openai, stable-diffusion, manual"
        exit 1
        ;;
esac

# 检查图片是否成功保存
if [ ! -f "$IMAGE_PATH" ]; then
    echo -e "${RED}错误: 图片保存失败${NC}"
    exit 1
fi

echo -e "${GREEN}图片已保存到: $IMAGE_PATH${NC}"

# 更新 markdown 文件的 image 字段
echo -e "${GREEN}更新文章的 image 字段...${NC}"

# 使用 sed 更新 image 字段（macOS 版本）
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|^image:.*|image: $IMAGE_REF|" "$FILE_PATH"
else
    sed -i "s|^image:.*|image: $IMAGE_REF|" "$FILE_PATH"
fi

echo -e "${GREEN}✅ 完成！${NC}"
echo -e "${GREEN}图片路径: $IMAGE_REF${NC}"
echo -e "${GREEN}文章已更新: $FILE_PATH${NC}"

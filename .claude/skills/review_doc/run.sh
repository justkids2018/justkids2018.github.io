#!/bin/bash
set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 获取文件路径参数
FILE_PATH="${1:-$CLAUDE_CURRENT_FILE}"

if [ -z "$FILE_PATH" ]; then
    echo -e "${RED}错误: 未提供文件路径${NC}"
    echo "用法: /review-doc [文件路径]"
    exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
    echo -e "${RED}错误: 文件不存在: $FILE_PATH${NC}"
    exit 1
fi

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}     文档审核系统 - 汪曾祺式风格标准${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""
echo -e "${BLUE}审核文件: $FILE_PATH${NC}"
echo ""

# 读取文章完整内容
ARTICLE_CONTENT=$(cat "$FILE_PATH")

# 提取front matter中的关键信息
TITLE=$(echo "$ARTICLE_CONTENT" | grep "^title:" | sed 's/title: *"\?\(.*\)"\?/\1/' | head -1)
DATE=$(echo "$ARTICLE_CONTENT" | grep "^date:" | sed 's/date: *"\?\(.*\)"\?/\1/' | head -1)
DESCRIPTION=$(echo "$ARTICLE_CONTENT" | grep "^description:" | sed 's/description: *"\?\(.*\)"\?/\1/' | head -1)

# 从文件路径提取年份
FILEPATH_YEAR=$(echo "$FILE_PATH" | grep -oE '20[0-9]{2}' | head -1)

# 从日期字段提取年份
if [ -n "$DATE" ]; then
    DATE_YEAR=$(echo "$DATE" | grep -oE '20[0-9]{2}' | head -1)
else
    DATE_YEAR=""
fi

echo -e "${YELLOW}=== 基础信息 ===${NC}"
echo -e "标题: ${TITLE:-未设置}"
echo -e "日期: ${DATE:-未设置}"
echo -e "描述: ${DESCRIPTION:-未设置}"
echo -e "文件路径年份: ${FILEPATH_YEAR:-未检测到}"
echo -e "日期字段年份: ${DATE_YEAR:-未检测到}"
echo ""

# 检查时间一致性
echo -e "${YELLOW}=== 时间一致性检查 ===${NC}"
TIME_ISSUES=""

if [ -n "$FILEPATH_YEAR" ] && [ -n "$DATE_YEAR" ] && [ "$FILEPATH_YEAR" != "$DATE_YEAR" ]; then
    echo -e "${RED}✗ 文件路径年份($FILEPATH_YEAR)与日期字段年份($DATE_YEAR)不一致${NC}"
    TIME_ISSUES="文件路径年份与日期字段不一致"
else
    echo -e "${GREEN}✓ 时间信息一致${NC}"
fi

# 检查标题是否与日期匹配（如果标题包含年份）
TITLE_YEAR=$(echo "$TITLE" | grep -oE '20[0-9]{2}' | head -1)
if [ -n "$TITLE_YEAR" ] && [ -n "$DATE_YEAR" ] && [ "$TITLE_YEAR" != "$DATE_YEAR" ]; then
    echo -e "${RED}✗ 标题中的年份($TITLE_YEAR)与日期字段年份($DATE_YEAR)不一致${NC}"
    if [ -n "$TIME_ISSUES" ]; then
        TIME_ISSUES="$TIME_ISSUES; 标题年份与日期不一致"
    else
        TIME_ISSUES="标题年份与日期不一致"
    fi
fi

echo ""

# 检查是否有Claude API配置
API_KEY="${ANTHROPIC_API_KEY:-$ANTHROPIC_AUTH_TOKEN}"

if [ -z "$API_KEY" ]; then
    echo -e "${YELLOW}警告: 未设置 ANTHROPIC_API_KEY，无法进行AI审核${NC}"
    echo -e "${YELLOW}请在环境变量中设置 ANTHROPIC_API_KEY 以启用完整审核功能${NC}"
    exit 1
fi

# 调用Claude API进行深度审核
API_BASE="${ANTHROPIC_BASE_URL:-https://api.anthropic.com}"

echo -e "${YELLOW}=== AI深度审核中... ===${NC}"
echo ""

# 构建审核提示词
REVIEW_PROMPT="你是一位专业的文字编辑和写作风格评论家。请对以下博客文章进行全面审核。

审核标准：
1. 错别字检查：找出所有错别字、标点符号错误、语法问题
2. 时间一致性：检查文章内容中提到的时间、年份是否与元数据一致
3. 格式问题：检查是否有空标题、格式错误等
4. 写作风格评估（汪曾祺式标准）：
   - 朴实自然：语言是否平实、真诚，不浮夸
   - 不营销：是否避免了营销话术、煽动性语言
   - 不标题党：标题是否实在，不夸大、不误导
   - 不贩卖焦虑：是否避免制造恐慌、焦虑情绪
   - 尊重读者：是否以平等姿态与读者交流
   - 独立思考：是否体现作者独立见解，不人云亦云

时间一致性问题：${TIME_ISSUES:-无}

请以JSON格式返回审核结果：
{
  \"score\": 85,  // 总分0-100
  \"typos\": [
    {\"error\": \"youbube\", \"correct\": \"youtube\", \"line\": 23, \"reason\": \"拼写错误\"}
  ],
  \"time_issues\": [
    {\"issue\": \"标题写2026但日期是2024\", \"suggestion\": \"建议统一为2026年\"}
  ],
  \"format_issues\": [
    {\"issue\": \"第20行存在空标题##\", \"suggestion\": \"补充标题内容或删除\"}
  ],
  \"style_evaluation\": {
    \"朴实自然\": {\"score\": 90, \"comment\": \"语言简洁平实\"},
    \"不营销\": {\"score\": 95, \"comment\": \"无营销话术\"},
    \"不标题党\": {\"score\": 80, \"comment\": \"标题较为平实，但可以更具体\"},
    \"不贩卖焦虑\": {\"score\": 100, \"comment\": \"完全没有焦虑制造\"},
    \"尊重读者\": {\"score\": 85, \"comment\": \"态度真诚\"},
    \"独立思考\": {\"score\": 75, \"comment\": \"可以更深入展现个人见解\"}
  },
  \"suggestions\": [
    \"建议补充描述字段，让读者更快了解文章主题\",
    \"目标的表述可以更具体，比如'2周做自媒体'可以明确具体产出\"
  ],
  \"corrected_content\": \"修正后的完整文章内容（如果有错误需要修正）\"
}

文章内容：
$ARTICLE_CONTENT"

# 调用Claude API
CLAUDE_RESPONSE=$(curl -s "$API_BASE/v1/messages" \
    -H "Content-Type: application/json" \
    -H "x-api-key: $API_KEY" \
    -H "anthropic-version: 2023-06-01" \
    -d "{
        \"model\": \"claude-3-5-sonnet-20241022\",
        \"max_tokens\": 4096,
        \"messages\": [{
            \"role\": \"user\",
            \"content\": $(echo "$REVIEW_PROMPT" | jq -Rs .)
        }]
    }")

# 检查API错误
if echo "$CLAUDE_RESPONSE" | jq -e '.error' > /dev/null 2>&1; then
    ERROR_MSG=$(echo "$CLAUDE_RESPONSE" | jq -r '.error.message' 2>/dev/null)
    echo -e "${RED}Claude API 错误: $ERROR_MSG${NC}"
    exit 1
fi

# 提取Claude返回的内容
CLAUDE_TEXT=$(echo "$CLAUDE_RESPONSE" | jq -r '.content[0].text' 2>/dev/null || echo "")

if [ -z "$CLAUDE_TEXT" ] || [ "$CLAUDE_TEXT" = "null" ]; then
    echo -e "${RED}错误: Claude API返回为空${NC}"
    echo "API响应: $CLAUDE_RESPONSE"
    exit 1
fi

# 提取JSON内容（可能被markdown代码块包裹）
REVIEW_JSON=$(echo "$CLAUDE_TEXT" | sed -n '/^{/,/^}/p' | head -1)
if [ -z "$REVIEW_JSON" ]; then
    # 尝试提取被```json包裹的内容
    REVIEW_JSON=$(echo "$CLAUDE_TEXT" | sed -n '/```json/,/```/p' | sed '1d;$d')
fi

if [ -z "$REVIEW_JSON" ]; then
    echo -e "${YELLOW}警告: 无法解析JSON，显示原始输出:${NC}"
    echo "$CLAUDE_TEXT"
    exit 0
fi

# 解析并显示审核结果
SCORE=$(echo "$REVIEW_JSON" | jq -r '.score // 0')

echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}     审核结果${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""
echo -e "${BLUE}综合评分: ${NC}${GREEN}$SCORE/100${NC}"
echo ""

# 显示错别字
TYPO_COUNT=$(echo "$REVIEW_JSON" | jq '.typos | length' 2>/dev/null || echo 0)
if [ "$TYPO_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}=== 错别字与语法问题 ($TYPO_COUNT处) ===${NC}"
    echo "$REVIEW_JSON" | jq -r '.typos[] | "  ✗ 第\(.line)行: \(.error) → \(.correct) (\(.reason))"' 2>/dev/null
    echo ""
fi

# 显示时间问题
TIME_ISSUE_COUNT=$(echo "$REVIEW_JSON" | jq '.time_issues | length' 2>/dev/null || echo 0)
if [ "$TIME_ISSUE_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}=== 时间一致性问题 ($TIME_ISSUE_COUNT处) ===${NC}"
    echo "$REVIEW_JSON" | jq -r '.time_issues[] | "  ✗ \(.issue)\n    建议: \(.suggestion)"' 2>/dev/null
    echo ""
fi

# 显示格式问题
FORMAT_ISSUE_COUNT=$(echo "$REVIEW_JSON" | jq '.format_issues | length' 2>/dev/null || echo 0)
if [ "$FORMAT_ISSUE_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}=== 格式问题 ($FORMAT_ISSUE_COUNT处) ===${NC}"
    echo "$REVIEW_JSON" | jq -r '.format_issues[] | "  ✗ \(.issue)\n    建议: \(.suggestion)"' 2>/dev/null
    echo ""
fi

# 显示风格评估
echo -e "${YELLOW}=== 写作风格评估（汪曾祺式标准）===${NC}"
echo "$REVIEW_JSON" | jq -r '.style_evaluation | to_entries[] | "  \(.key): \(.value.score)/100 - \(.value.comment)"' 2>/dev/null
echo ""

# 显示改进建议
SUGGESTION_COUNT=$(echo "$REVIEW_JSON" | jq '.suggestions | length' 2>/dev/null || echo 0)
if [ "$SUGGESTION_COUNT" -gt 0 ]; then
    echo -e "${YELLOW}=== 改进建议 ===${NC}"
    echo "$REVIEW_JSON" | jq -r '.suggestions[] | "  • \(.)"' 2>/dev/null
    echo ""
fi

# 询问是否保存修正后的内容
CORRECTED_CONTENT=$(echo "$REVIEW_JSON" | jq -r '.corrected_content // ""' 2>/dev/null)
if [ -n "$CORRECTED_CONTENT" ] && [ "$CORRECTED_CONTENT" != "null" ] && [ "$CORRECTED_CONTENT" != "无需修正" ]; then
    echo -e "${CYAN}================================================${NC}"
    echo -e "${GREEN}✓ 已生成修正后的文章内容${NC}"
    echo -e "${YELLOW}修正后的内容已保存到: ${FILE_PATH}.corrected${NC}"
    echo "$CORRECTED_CONTENT" > "${FILE_PATH}.corrected"
    echo ""
    echo -e "${YELLOW}如需应用修正，请运行:${NC}"
    echo -e "  mv \"${FILE_PATH}.corrected\" \"${FILE_PATH}\""
fi

echo ""
echo -e "${CYAN}================================================${NC}"
echo -e "${GREEN}✅ 审核完成${NC}"
echo -e "${CYAN}================================================${NC}"

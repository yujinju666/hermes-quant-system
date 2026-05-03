# 🛡️ 飞书实时推送系统

实时监控交易状态，通过飞书机器人推送持仓、盈亏和异常通知。

## 工作流程

```
策略开仓/平仓 → FMZ日志 → Python监控脚本 → 飞书Webhook → 手机通知
```

## 功能

- **开仓推送**：币种、方向、张数、价格、保证金
- **平仓推送**：盈亏金额、盈亏比例、持仓时间
- **定时报告**：每30分钟汇总持仓状态
- **异常告警**：机器人停止、API异常、风控触发

## 技术实现

```python
# 简化示例 — 完整代码不含敏感信息
import requests

FEISHU_WEBHOOK = "your_webhook_url"

def push_message(content: str):
    payload = {
        "msg_type": "interactive",
        "card": {
            "header": {"title": {"tag": "plain_text", "content": "Hermes 量化"}},
            "elements": [{"tag": "markdown", "content": content}]
        }
    }
    requests.post(FEISHU_WEBHOOK, json=payload)
```

## 部署

```bash
# Python 3.6+
pip install requests

# 设置定时任务 (crontab)
*/5 * * * * python3 /path/to/monitor.py
```

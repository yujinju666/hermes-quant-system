# 🔄 看门狗自动恢复系统

确保交易机器人 24/7 持续运行，异常自动恢复。

## 工作原理

```
每2分钟执行一次:
  1. 通过FMZ API查询机器人状态
  2. 状态=1 (运行中) → 无事发生
  3. 状态≠1 (停止/错误) → 调用重启API
  4. 推送飞书通知：机器人已自动恢复
```

## 技术实现

```python
# 简化示例
def check_and_restart():
    robot_status = query_robot_status(ROBOT_ID)
    if robot_status != 1:  # 非运行状态
        restart_robot(ROBOT_ID)
        push_notification("⚠️ 机器人已停止，已自动重启")
```

## 部署

通过 crontab 实现，独立于交易服务器运行：

```bash
# 每2分钟执行
*/2 * * * * python3 /path/to/watchdog.py
```

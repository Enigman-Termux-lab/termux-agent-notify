---
name: termux-agent-notify
description: Integrate AI coding agent lifecycle events with native Android notifications and haptics via Termux:API.
---

# Termux Agent Notify Skill

Use this skill to configure system notifications, vibration feedback, and deep links back to Termux when long AI agent reasoning or coding tasks complete.

## Workflow

1. **Pre-invocation Hook:** Save timestamp on agent task start (`date +%s > /tmp/agy_invoke_start`).
2. **Stop Hook:** On completion, trigger haptic feedback via `termux-vibrate -d 24`. If elapsed time exceeds threshold (e.g. 5 minutes), dispatch interactive notification via `termux-notification --action "am start -n com.termux/com.termux.app.TermuxActivity"`.
